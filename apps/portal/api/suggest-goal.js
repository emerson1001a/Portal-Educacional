import { createClient } from "@supabase/supabase-js";

const allowedAreas = new Set(["leitura", "escrita", "matematica", "organizacao", "outro"]);
const allowedTypes = new Set(["meta", "observar", "apoio"]);

export const maxDuration = 30;

function json(res, status, body) {
  return res.status(status).json(body);
}

function parseJsonLoose(text) {
  try {
    return JSON.parse(text);
  } catch {
    const match = String(text || "").match(/\{[\s\S]*\}/);
    if (!match) return null;
    try {
      return JSON.parse(match[0]);
    } catch {
      return null;
    }
  }
}

function normalizeSuggestion(value) {
  const type = allowedTypes.has(value?.type) ? value.type : "observar";
  const area = allowedAreas.has(value?.suggested_area) ? value.suggested_area : "outro";
  const goal = value?.suggested_goal && typeof value.suggested_goal === "object" ? value.suggested_goal : {};

  return {
    type,
    suggested_area: area,
    reassurance: String(value?.reassurance || "Vamos organizar essa percepção com calma, sem transformar em diagnóstico.").slice(0, 420),
    explanation: String(value?.explanation || "").slice(0, 700),
    next_steps: Array.isArray(value?.next_steps) ? value.next_steps.map(String).slice(0, 4) : [],
    suggested_goal: type === "meta" ? {
      area,
      title: String(goal.title || "").slice(0, 120),
      description: String(goal.description || "").slice(0, 500),
      measurement: String(goal.measurement || "").slice(0, 240),
      adult_phrase: String(goal.adult_phrase || "").slice(0, 180)
    } : null
  };
}

function fallbackSuggestion({ perception, areaHint, child }) {
  const area = allowedAreas.has(areaHint) ? areaHint : "outro";
  const childName = child?.full_name || "a crianca";
  const shortPerception = String(perception || "")
    .replace(/\s+/g, " ")
    .trim()
    .slice(0, 180);

  return normalizeSuggestion({
    type: "meta",
    suggested_area: area,
    reassurance: `Vamos olhar para ${childName} com calma e por evidencias pequenas.`,
    explanation: "Organizei uma meta inicial de observacao. Ela deve ser revisada pelo adulto depois de algumas praticas, para evitar pressa ou conclusoes fortes demais.",
    next_steps: [
      "Fazer uma pratica curta e registrar uma evidencia simples.",
      "Repetir em outro dia, sem comparar com outras criancas.",
      "Ajustar a meta depois de 3 ou 4 evidencias."
    ],
    suggested_goal: {
      title: "Observar evolucao em uma habilidade especifica",
      description: shortPerception ? `Percepcao inicial: ${shortPerception}` : "Observar uma habilidade especifica em atividades curtas.",
      measurement: "Comparar pequenas evidencias ao longo dos proximos dias, olhando autonomia, clareza e disposicao.",
      adult_phrase: "Vamos fazer uma parte pequena e observar o que ficou mais facil hoje."
    }
  });
}

async function callOpenAI({ perception, areaHint, child }) {
  const controller = new AbortController();
  const timeoutId = setTimeout(() => controller.abort(), 22000);
  const response = await fetch("https://api.openai.com/v1/responses", {
    method: "POST",
    signal: controller.signal,
    headers: {
      Authorization: `Bearer ${process.env.OPENAI_API_KEY}`,
      "Content-Type": "application/json"
    },
    body: JSON.stringify({
      model: process.env.OPENAI_MODEL || "gpt-4.1-mini",
      input: [
        {
          role: "system",
          content: [
            "Você é um assistente pedagógico para pais e professores.",
            "Sua tarefa é organizar uma percepção do adulto em uma resposta cuidadosa.",
            "Nunca dê diagnóstico, laudo, rótulo clínico ou conclusão sobre a criança.",
            "Observe a evolução principalmente em relação ao percurso da própria criança, não em comparação com outras crianças.",
            "Use habilidades pedagógicas como referência, mas nunca como rótulo.",
            "Todo feedback ao adulto deve terminar com uma ação concreta, pequena e respeitosa.",
            "Nenhuma resposta deve aumentar culpa, medo ou sensação de incapacidade do adulto.",
            "Quando faltar evidência, prefira orientar observação antes de criar meta.",
            "Quando houver sinais intensos, emocionais, persistentes ou fora do pedagógico, sugira conversar com a escola ou profissional especializado, sem alarmismo.",
            "Use português do Brasil, tom acolhedor, positivo, concreto e breve.",
            "Evite termos como problema, atraso, déficit, transtorno, incapaz, confuso ou comparação com colegas.",
            "Retorne somente JSON válido."
          ].join(" ")
        },
        {
          role: "user",
          content: JSON.stringify({
            perception,
            area_hint: areaHint,
            child_context: child,
            output_schema: {
              type: "meta | observar | apoio",
              suggested_area: "leitura | escrita | matematica | organizacao | outro",
              reassurance: "frase tranquilizadora e não diagnóstica",
              explanation: "por que essa resposta foi escolhida",
              next_steps: ["passos práticos"],
              suggested_goal: {
                title: "meta objetiva, se type=meta",
                description: "observação pedagógica para salvar",
                measurement: "como observar evolução",
                adult_phrase: "frase positiva para o adulto usar"
              }
            }
          })
        }
      ]
    })
  }).finally(() => clearTimeout(timeoutId));

  const data = await response.json();
  if (!response.ok) throw new Error(data?.error?.message || `OpenAI HTTP ${response.status}`);
  const text = data.output_text || (data.output || [])
    .map((item) => (item.content || []).map((content) => content.text || "").join(""))
    .join("\n");
  const parsed = parseJsonLoose(text);
  if (!parsed) throw new Error("A IA não retornou um JSON válido.");
  return normalizeSuggestion(parsed);
}

export default async function handler(req, res) {
  if (req.method !== "POST") {
    res.setHeader("Allow", "POST");
    return json(res, 405, { ok: false, message: "Método não permitido." });
  }

  const url = process.env.SUPABASE_URL;
  const anonKey = process.env.SUPABASE_ANON_KEY;
  const serviceRoleKey = process.env.SUPABASE_SERVICE_ROLE_KEY;
  if (!url || !anonKey || !serviceRoleKey) {
    return json(res, 500, { ok: false, message: "Variáveis do Supabase não configuradas." });
  }
  const bearer = String(req.headers.authorization || "").replace(/^Bearer\s+/i, "");
  if (!bearer) return json(res, 401, { ok: false, message: "Sessão não informada." });

  const body = req.body || {};
  const perception = String(body.perception || "").trim();
  const childId = body.child_id;
  const areaHint = allowedAreas.has(body.area_hint) ? body.area_hint : "outro";
  if (!childId || perception.length < 12) {
    return json(res, 400, { ok: false, message: "Descreva um pouco mais a percepção e selecione uma criança." });
  }

  const userClient = createClient(url, anonKey, {
    global: { headers: { Authorization: `Bearer ${bearer}` } },
    auth: { persistSession: false }
  });
  const { data: userData, error: userError } = await userClient.auth.getUser(bearer);
  if (userError || !userData?.user) return json(res, 401, { ok: false, message: "Sessão inválida." });

  const admin = createClient(url, serviceRoleKey, { auth: { persistSession: false } });
  const { data: link, error: linkError } = await admin
    .from("child_guardians")
    .select("child_id")
    .eq("child_id", childId)
    .eq("guardian_id", userData.user.id)
    .maybeSingle();
  if (linkError) return json(res, 500, { ok: false, message: linkError.message });
  if (!link) return json(res, 403, { ok: false, message: "Criança não vinculada a esta conta." });

  const { data: child } = await admin
    .from("children")
    .select("full_name, birth_date, grade, notes")
    .eq("id", childId)
    .maybeSingle();

  try {
    if (!process.env.OPENAI_API_KEY) {
      return json(res, 200, {
        ok: true,
        fallback: true,
        suggestion: fallbackSuggestion({ perception, areaHint, child })
      });
    }
    const suggestion = await callOpenAI({ perception, areaHint, child });
    return json(res, 200, { ok: true, suggestion });
  } catch (error) {
    console.warn("Fallback em /api/suggest-goal:", error.message);
    return json(res, 200, {
      ok: true,
      fallback: true,
      suggestion: fallbackSuggestion({ perception, areaHint, child })
    });
  }
}
