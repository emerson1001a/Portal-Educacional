import express from "express";
import cors from "cors";
import "dotenv/config";
import fs from "node:fs/promises";
import path from "node:path";
import { fileURLToPath } from "node:url";

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
const DATA_DIR = path.join(__dirname, "data");
const DATA_FILE = path.join(DATA_DIR, "leituras.json");
const isVercel = Boolean(process.env.VERCEL);

const app = express();
app.use((_req, res, next) => {
  res.charset = "utf-8";
  next();
});
app.use(cors());
app.use(express.json({ limit: "1mb" }));
app.use(express.static(__dirname, {
  setHeaders(res, filePath) {
    if (filePath.endsWith(".html")) {
      res.setHeader("Content-Type", "text/html; charset=utf-8");
    }
  }
}));

async function readStore() {
  if (isVercel) {
    globalThis.__interpretacaoStore ??= { nextId: 1, leituras: [] };
    return globalThis.__interpretacaoStore;
  }
  try {
    const raw = await fs.readFile(DATA_FILE, "utf8");
    return JSON.parse(raw);
  } catch {
    return { nextId: 1, leituras: [] };
  }
}

async function writeStore(store) {
  if (isVercel) {
    globalThis.__interpretacaoStore = store;
    return;
  }
  await fs.mkdir(DATA_DIR, { recursive: true });
  await fs.writeFile(DATA_FILE, JSON.stringify(store, null, 2), "utf8");
}

function cleanText(value, fallback = "") {
  return (value ?? fallback).toString().trim();
}

function clampNumber(value, fallback, min, max) {
  const n = Number(value);
  if (!Number.isFinite(n)) return fallback;
  return Math.min(Math.max(n, min), max);
}

function resolveTextProfile(idade, requestedSize) {
  const requested = cleanText(requestedSize).toLowerCase();
  const explicitSize = ["curto", "medio", "longo"].includes(requested) ? requested : "";
  const resolvedSize = explicitSize || (idade <= 8 ? "curto" : "medio");
  const complexity = idade <= 8
    ? "frases curtas, vocabulario familiar e uma sequencia simples de acontecimentos"
    : idade <= 11
      ? "paragrafos curtos, vocabulario cotidiano e uma inferencia leve"
      : "paragrafos organizados, vocabulario um pouco mais rico e inferencias moderadas";
  return {
    requested: explicitSize || "automatico",
    resolved: resolvedSize,
    complexity
  };
}

function extractOutputText(data) {
  if (typeof data?.output_text === "string") return data.output_text.trim();
  const parts = [];
  for (const item of data?.output ?? []) {
    for (const content of item?.content ?? []) {
      if (content?.type === "output_text" && content?.text) parts.push(content.text);
      if (content?.type === "text" && content?.text) parts.push(content.text);
    }
  }
  return parts.join("\n").trim();
}

function parseJsonLoose(text) {
  try {
    return JSON.parse(text);
  } catch {
    const match = text?.match(/\{[\s\S]*\}/);
    if (!match) return null;
    try {
      return JSON.parse(match[0]);
    } catch {
      return null;
    }
  }
}

function normalizeForMatch(value) {
  return cleanText(value)
    .normalize("NFD")
    .replace(/[\u0300-\u036f]/g, "")
    .toLowerCase()
    .replace(/\s+/g, " ");
}

function evidenceInText(evidence, texto) {
  const normalizedEvidence = normalizeForMatch(evidence);
  if (normalizedEvidence.length < 8) return false;
  return normalizeForMatch(texto).includes(normalizedEvidence);
}

function normalizeQuestion(question, texto) {
  const type = question?.type === "mcq" ? "mcq" : "open";
  const prompt = cleanText(question?.prompt);
  const evidence = cleanText(question?.evidence);
  if (!prompt || !evidenceInText(evidence, texto)) return null;

  const questionType = cleanText(question?.question_type || question?.skill_type || question?.kind || question?.tags?.[0], "literal");
  const difficulty = cleanText(question?.difficulty, "facil");
  const normalized = {
    type,
    prompt,
    evidence,
    question_type: normalizeQuestionType(questionType),
    difficulty: normalizeQuestionDifficulty(difficulty),
    expected_answer: cleanText(question?.expected_answer || question?.answer_key || evidence),
    tags: Array.isArray(question?.tags) ? question.tags.map(String) : []
  };

  if (type === "mcq") {
    const options = Array.isArray(question?.options)
      ? question.options.map((option) => cleanText(option)).filter(Boolean).slice(0, 4)
      : [];
    const answerKey = cleanText(question?.answer_key);
    if (options.length !== 4 || !options.includes(answerKey)) return null;
    normalized.options = options;
    normalized.answer_key = answerKey;
  }

  return normalized;
}

function normalizeQuestionType(value) {
  const key = normalizeForMatch(value).replace(/[^a-z0-9]+/g, "_");
  const map = {
    literal: "literal",
    informacao_literal: "literal",
    inferencia: "inferential",
    inferencial: "inferential",
    inferential: "inferential",
    vocabulario: "vocabulary_context",
    vocabulario_contexto: "vocabulary_context",
    vocabulary_context: "vocabulary_context",
    justificativa: "justification",
    justification: "justification",
    sequencia: "sequence",
    sequence: "sequence",
    ideia_principal: "main_idea",
    main_idea: "main_idea",
    acao_personagem: "character_action",
    character_action: "character_action",
    causa_consequencia: "cause_consequence",
    cause_consequence: "cause_consequence"
  };
  return map[key] || "literal";
}

function normalizeQuestionDifficulty(value) {
  const key = normalizeForMatch(value);
  if (["media", "medio"].includes(key)) return "media";
  if (key === "dificil") return "dificil";
  return "facil";
}

function evidenceSentences(texto) {
  const sentences = cleanText(texto)
    .split(/(?<=[.!?])\s+/)
    .map((sentence) => cleanText(sentence))
    .filter((sentence) => sentence.length >= 20);
  return sentences.length ? sentences : [cleanText(texto).slice(0, 160)];
}

function readOpenAIKey() {
  return String(process.env.OPENAI_API_KEY || "").trim().split(/\s+/)[0] || "";
}

async function askOpenAI(prompt) {
  const openAIKey = readOpenAIKey();
  if (!openAIKey) return "";
  const response = await fetch("https://api.openai.com/v1/responses", {
    method: "POST",
    headers: {
      "Authorization": `Bearer ${openAIKey}`,
      "Content-Type": "application/json"
    },
    body: JSON.stringify({
      model: process.env.OPENAI_MODEL || "gpt-4.1-mini",
      input: prompt
    })
  });
  const data = await response.json().catch(() => ({}));
  if (!response.ok) {
    throw new Error(data?.error?.message || `OpenAI HTTP ${response.status}`);
  }
  return extractOutputText(data);
}

function fallbackText({ idade, tema, tamanho }) {
  const assunto = cleanText(tema, "amizade e escola");
  const key = normalizeForMatch(assunto);
  const longExtra = tamanho === "longo"
    ? " Depois da atividade, a turma conversou sobre o que aconteceu e percebeu que observar os detalhes ajuda a tomar decisoes melhores."
    : "";

  if (/\b(ferias|viagem|praia|campo|passeio)\b/.test(key)) {
    return `Nas ferias, uma crianca de ${idade} anos viajou com a familia para um lugar diferente. No primeiro dia, ela guardou a mochila, observou o caminho ate a casa e anotou tres coisas que chamaram sua atencao: uma janela azul, uma arvore grande e uma rua silenciosa. Mais tarde, quando todos foram caminhar, essas pistas ajudaram a familia a encontrar o caminho de volta sem se perder.${longExtra}`;
  }

  if (/\b(aventura|exploracao|misterio|mapa|tesouro)\b/.test(key)) {
    return `Em uma tarde tranquila, um grupo de criancas encontrou um mapa dobrado perto do patio da escola. O desenho mostrava tres pistas: uma pedra redonda, um banco antigo e uma arvore com uma fita vermelha. Elas seguiram cada pista com cuidado e descobriram uma caixa com bilhetes deixados por outra turma, dizendo que a maior aventura era aprender a observar antes de correr.${longExtra}`;
  }

  if (/\b(esporte|futebol|basquete|volei|natacao|corrida|jogo)\b/.test(key)) {
    return `No treino de esporte da escola, uma crianca de ${idade} anos queria marcar pontos rapidamente. O professor pediu que ela observasse primeiro a posicao dos colegas e esperasse o melhor momento para passar a bola. Na jogada seguinte, a crianca respirou, olhou para o lado e fez um passe que ajudou a equipe inteira a participar do jogo.${longExtra}`;
  }

  if (/\b(animal|animais|cachorro|gato|passaro|natureza|floresta)\b/.test(key)) {
    return `Durante uma atividade sobre natureza, uma crianca de ${idade} anos percebeu um passaro parado perto de uma arvore. Em vez de correr, ela ficou em silencio e observou o que acontecia. Depois de alguns minutos, viu que o passaro levava pequenos gravetos para construir um ninho, e entendeu que algumas descobertas aparecem quando a gente presta atencao com calma.${longExtra}`;
  }

  return `Durante uma conversa sobre ${assunto}, uma crianca de ${idade} anos recebeu uma tarefa de observacao. Primeiro, ela anotou o que ja sabia. Depois, ouviu as ideias dos colegas e comparou com as pistas do texto. No final, percebeu que entender bem um assunto exige olhar os detalhes, separar fatos de opinioes e explicar a resposta com suas proprias palavras.${longExtra}`;
}

function fallbackQuestions(texto) {
  const baseTags = ["segura", "baseada-no-texto"];
  const evidences = evidenceSentences(texto);
  const evidenceAt = (index) => evidences[Math.min(index, evidences.length - 1)] || cleanText(texto);
  return [
    {
      type: "open",
      prompt: "Qual é o assunto principal do texto? Responda usando uma informação que aparece na leitura.",
      evidence: evidenceAt(0),
      question_type: "main_idea",
      difficulty: "facil",
      expected_answer: evidenceAt(0),
      tags: baseTags
    },
    {
      type: "open",
      prompt: "Cite uma parte do texto que ajudou você a entender a história.",
      evidence: evidenceAt(1),
      question_type: "justification",
      difficulty: "media",
      expected_answer: evidenceAt(1),
      tags: baseTags
    },
    {
      type: "open",
      prompt: "O que você entendeu sobre a atitude ou a descoberta mais importante do texto?",
      evidence: evidenceAt(2),
      question_type: "inferential",
      difficulty: "media",
      expected_answer: evidenceAt(2),
      tags: baseTags
    },
    {
      type: "open",
      prompt: "Se você fosse contar esse texto para alguém, qual detalhe não poderia faltar?",
      evidence: evidenceAt(3),
      question_type: "literal",
      difficulty: "facil",
      expected_answer: evidenceAt(3),
      tags: baseTags
    }
  ];
}

async function generateText(params) {
  const profile = params.textProfile || resolveTextProfile(params.idade, params.tamanho);
  const prompt = `
Crie um texto curto em portugues do Brasil para uma atividade de interpretacao.
Nome do aluno, apenas para adaptar linguagem e faixa etaria, sem usar como personagem nesta atividade: ${params.aluno}
Idade: ${params.idade}
Tema: ${params.tema || "livre"}
Tamanho aplicado: ${profile.resolved}
Complexidade aplicada: ${profile.complexity}

Regras pedagogicas:
- Nao use o nome do aluno como personagem do texto nesta atividade.
- Varie personagens, lugares e situacoes de uma atividade para outra.
- Mantenha vocabulario adequado para a idade e fatos claros para gerar perguntas literais.
- Tamanho pedido pelo adulto ou sistema: ${profile.requested}.
- Se o tamanho pedido foi automatico, priorize conforto e clareza em vez de alongar demais o texto.

Responda apenas com o texto, sem titulo e sem markdown.
`.trim();

  const generated = await askOpenAI(prompt).catch((error) => {
    console.warn("OpenAI indisponivel em /api/leitura/start:", error.message);
    return "";
  });
  return generated || fallbackText({ ...params, tamanho: profile.resolved });
}

async function generateQuestions(texto) {
  const prompt = `
Crie 4 perguntas de interpretacao para o texto abaixo.
Regra obrigatoria: cada pergunta deve usar apenas fatos que aparecem literalmente no texto.
Nao invente personagem, animal, cor, lugar, objeto, sentimento, acao ou sequencia que nao esteja no texto.
Antes de responder, confira se cada pergunta pode ser respondida lendo somente o texto.
Para cada pergunta, inclua "evidence" com uma frase curta copiada exatamente do texto que prova que a pergunta esta correta.
Para cada pergunta, inclua "question_type" com um destes valores: literal, inferential, vocabulary_context, justification, sequence, main_idea, character_action, cause_consequence.
Para cada pergunta, inclua "difficulty" como facil, media ou dificil.
Para cada pergunta, inclua "expected_answer" com uma resposta esperada curta.
Nas perguntas de multipla escolha, "answer_key" deve ser exatamente igual a uma das opcoes.
Retorne somente JSON valido neste formato:
{"questions":[{"type":"mcq","prompt":"...","options":["A","B","C","D"],"answer_key":"A","expected_answer":"A","evidence":"frase copiada do texto","question_type":"literal","difficulty":"facil","tags":["literal"]},{"type":"open","prompt":"...","expected_answer":"...","evidence":"frase copiada do texto","question_type":"inferential","difficulty":"media","tags":["inferencia"]}]}

Texto:
${texto}
`.trim();

  const generated = await askOpenAI(prompt).catch((error) => {
    console.warn("OpenAI indisponivel em /api/leitura/finish-reading:", error.message);
    return "";
  });
  const parsed = parseJsonLoose(generated);
  const questions = Array.isArray(parsed?.questions) ? parsed.questions : fallbackQuestions(texto);
  const normalized = questions.map((q) => normalizeQuestion(q, texto)).filter(Boolean);
  const fallback = fallbackQuestions(texto);
  const normalizedFallback = fallback.map((q) => normalizeQuestion(q, texto)).filter(Boolean);
  const safeQuestions = normalized.length >= 3
    ? normalized
    : normalizedFallback.length >= 3
      ? normalizedFallback
      : fallback;
  return safeQuestions.slice(0, 5).map((question, index) => ({
    id: question.id || `q${index + 1}`,
    ...question
  }));
}

function computeMetrics(leitura) {
  const respostas = Array.isArray(leitura.respostas) ? leitura.respostas : [];
  const evaluated = respostas
    .map((answer) => normalizeStoredEvaluation(answer))
    .filter((answer) => answer && answer.score !== null);
  const questionsTotal = Array.isArray(leitura.questions) ? leitura.questions.length : respostas.length;
  const questionsAnswered = respostas.filter((r) => cleanText(r?.resposta)).length;
  const correct = evaluated.filter((answer) => answer.evaluation === "correct").length;
  const partial = evaluated.filter((answer) => answer.evaluation === "partial").length;
  const incorrect = evaluated.filter((answer) => ["incorrect", "blank"].includes(answer.evaluation)).length;
  const totalScore = evaluated.reduce((sum, answer) => sum + answer.score, 0);
  const accuracyPct = evaluated.length ? Math.round((totalScore / evaluated.length) * 100) : null;
  const typeScores = scoresByQuestionType(respostas);
  const mcq = respostas.filter((r) => r.correta !== null && r.correta !== undefined);
  const mcqScore = mcq.filter((r) => r.correta === true || r.correta === 1).length;
  const totalTempo = respostas.reduce((sum, r) => sum + (Number(r.tempo_ms) || 0), 0);
  const avgQ = respostas.length ? Math.round(totalTempo / respostas.length) : null;
  return {
    module_version: evaluated.length ? "interpretacao-structured-v1" : "interpretacao-legacy-v1",
    completed: true,
    read_ms: leitura.read_time_ms ?? null,
    avg_q_ms: avgQ,
    avg_q_time_ms: avgQ,
    questions_total: questionsTotal,
    questions_answered: questionsAnswered,
    questions_correct: correct,
    questions_partial: partial,
    questions_incorrect: incorrect,
    accuracy_pct: accuracyPct,
    comprehension_score: accuracyPct === null ? null : Math.round(accuracyPct) / 100,
    objective_scoring_available: evaluated.length > 0,
    structured_answers_total: evaluated.length,
    literal_accuracy_pct: typeScores.literal,
    inferential_accuracy_pct: typeScores.inferential,
    vocabulary_accuracy_pct: typeScores.vocabulary_context,
    justification_accuracy_pct: typeScores.justification,
    mcq_score: mcqScore,
    mcq_max: mcq.length,
    mcq_accuracy_pct: mcq.length ? Math.round((mcqScore / mcq.length) * 100) : null
  };
}

function numberOrNull(value) {
  const n = Number(value);
  return Number.isFinite(n) ? n : null;
}

function normalizeEvaluation(value) {
  const key = normalizeForMatch(value).replace(/[^a-z0-9]+/g, "_");
  const map = {
    correta: "correct",
    correto: "correct",
    correct: "correct",
    certo: "correct",
    certa: "correct",
    parcialmente_correta: "partial",
    parcialmente_correto: "partial",
    partial: "partial",
    parcial: "partial",
    incorreta: "incorrect",
    incorreto: "incorrect",
    incorrect: "incorrect",
    errado: "incorrect",
    errada: "incorrect",
    branco: "blank",
    em_branco: "blank",
    blank: "blank",
    not_evaluable: "not_evaluable",
    nao_avaliavel: "not_evaluable"
  };
  return map[key] || "not_evaluable";
}

function scoreForEvaluation(evaluation, explicitScore = null) {
  const score = numberOrNull(explicitScore);
  if (score !== null) return Math.max(0, Math.min(1, score));
  if (evaluation === "correct") return 1;
  if (evaluation === "partial") return 0.5;
  if (evaluation === "incorrect" || evaluation === "blank") return 0;
  return null;
}

function normalizeStoredEvaluation(answer) {
  if (!answer) return null;
  if (answer.evaluation) {
    const evaluation = normalizeEvaluation(answer.evaluation);
    return {
      evaluation,
      score: scoreForEvaluation(evaluation, answer.score)
    };
  }
  if (answer.correta !== null && answer.correta !== undefined) {
    const evaluation = answer.correta === true || answer.correta === 1 ? "correct" : "incorrect";
    return { evaluation, score: scoreForEvaluation(evaluation) };
  }
  return null;
}

function scoresByQuestionType(respostas) {
  const buckets = {};
  for (const answer of respostas) {
    const questionType = normalizeQuestionType(answer?.question_type || answer?.tags?.[0] || "");
    const evaluation = normalizeStoredEvaluation(answer);
    if (!evaluation || evaluation.score === null) continue;
    buckets[questionType] ??= [];
    buckets[questionType].push(evaluation.score);
  }
  const pct = (type) => {
    const values = buckets[type] || [];
    if (!values.length) return null;
    return Math.round((values.reduce((sum, value) => sum + value, 0) / values.length) * 100);
  };
  return {
    literal: pct("literal"),
    inferential: pct("inferential"),
    vocabulary_context: pct("vocabulary_context"),
    justification: pct("justification")
  };
}

function leituraFromRequest(body = {}) {
  return {
    id: Number(body.leitura_id) || 0,
    aluno: cleanText(body.aluno, "Aluno") || "Aluno",
    idade: clampNumber(body.idade, 11, 6, 18),
    texto: cleanText(body.texto),
    read_time_ms: Number(body.read_time_ms) || null,
    questions: Array.isArray(body.questions) ? body.questions : [],
    respostas: Array.isArray(body.respostas) ? body.respostas : [],
    feedback: ""
  };
}

function normalizeAnswerRecord(raw, resposta, question, index) {
  const fallbackEvaluation = resposta?.correta !== null && resposta?.correta !== undefined
    ? (resposta.correta === true || resposta.correta === 1 ? "correct" : "incorrect")
    : "not_evaluable";
  const evaluation = normalizeEvaluation(raw?.evaluation || fallbackEvaluation);
  const score = scoreForEvaluation(evaluation, raw?.score);
  return {
    ...resposta,
    question_id: cleanText(resposta?.question_id || raw?.question_id || question?.id || `q${index + 1}`),
    pergunta_index: Number(resposta?.pergunta_index) || index + 1,
    pergunta: cleanText(resposta?.pergunta || question?.prompt),
    resposta: cleanText(resposta?.resposta || raw?.answer),
    question_type: normalizeQuestionType(resposta?.question_type || question?.question_type || question?.tags?.[0]),
    difficulty: normalizeQuestionDifficulty(resposta?.difficulty || question?.difficulty),
    expected_answer: cleanText(resposta?.expected_answer || question?.expected_answer || question?.answer_key || question?.evidence),
    evidence: cleanText(resposta?.evidence || question?.evidence),
    evaluation,
    score,
    uses_text_evidence: typeof raw?.uses_text_evidence === "boolean" ? raw.uses_text_evidence : null,
    feedback_child: cleanText(raw?.feedback_child),
    feedback_adult: cleanText(raw?.feedback_adult)
  };
}

function deterministicAnswerRecord(resposta, question, index) {
  if (resposta?.correta !== null && resposta?.correta !== undefined) {
    return normalizeAnswerRecord({}, resposta, question, index);
  }
  return normalizeAnswerRecord({ evaluation: "not_evaluable", score: null }, resposta, question, index);
}

async function evaluateAnswers(leitura) {
  const perguntas = Array.isArray(leitura.questions) ? leitura.questions : [];
  const respostas = Array.isArray(leitura.respostas) ? leitura.respostas : [];
  if (!respostas.length) return respostas;

  const deterministic = respostas.map((resposta, index) => deterministicAnswerRecord(resposta, perguntas[index], index));
  const openAnswers = deterministic.filter((answer) => answer.type !== "mcq" && answer.tipo !== "mcq" && answer.resposta);
  if (!openAnswers.length) return deterministic;

  const prompt = `
Voce vai corrigir respostas abertas de uma atividade de interpretacao de texto.
Use somente o texto, as perguntas, as respostas esperadas e as evidencias informadas.
Nao use conhecimento externo.
Aceite respostas com palavras diferentes quando a ideia estiver correta.

Retorne somente JSON valido neste formato:
{"answers":[{"question_id":"q1","evaluation":"correct|partial|incorrect|blank|not_evaluable","score":1,"uses_text_evidence":true,"feedback_child":"frase curta para a crianca","feedback_adult":"observacao curta para o adulto"}]}

Regras:
- correct = ideia correta para a pergunta.
- partial = ideia em parte correta, mas incompleta.
- incorrect = ideia sem apoio no texto ou resposta errada.
- blank = sem resposta.
- not_evaluable = nao ha como avaliar.
- score deve ser 1, 0.5, 0 ou null.
- feedback_child deve ser gentil, curto e falar diretamente com a crianca.
- feedback_adult deve explicar a observacao sem diagnostico e sem alarme.

Texto:
${leitura.texto}

Perguntas e respostas:
${openAnswers.map((answer) => `
ID: ${answer.question_id}
Tipo: ${answer.question_type}
Pergunta: ${answer.pergunta}
Resposta esperada: ${answer.expected_answer}
Evidencia do texto: ${answer.evidence}
Resposta da crianca: ${answer.resposta}
`).join("\n")}
`.trim();

  const generated = await askOpenAI(prompt).catch((error) => {
    console.warn("OpenAI indisponivel em avaliacao estruturada:", error.message);
    return "";
  });
  const parsed = parseJsonLoose(generated);
  const aiAnswers = Array.isArray(parsed?.answers) ? parsed.answers : [];
  if (!aiAnswers.length) return deterministic;

  const byId = new Map(aiAnswers.map((answer) => [cleanText(answer?.question_id), answer]));
  return deterministic.map((answer, index) => {
    if (answer.type === "mcq" || answer.tipo === "mcq") return answer;
    const ai = byId.get(answer.question_id);
    if (!ai) return answer;
    return normalizeAnswerRecord(ai, answer, perguntas[index], index);
  });
}

function structuredAdultFeedback(leitura) {
  const metrics = computeMetrics(leitura);
  if (!metrics.objective_scoring_available) {
    return {
      summary: "A crianca concluiu a leitura e respondeu as perguntas. Ainda nao ha correcao estruturada suficiente para indicar percentual de compreensao com seguranca.",
      recipe: ["Leia um trecho curto.", "Faca uma pergunta por vez.", "Peca para a crianca apontar a pista no texto."],
      attention_points: ["Observar se a crianca justifica as respostas com base no texto."],
      avoid_saying: ["Voce nao entendeu o texto."],
      suggested_phrase: "Vamos procurar juntos a parte do texto que ajuda a responder."
    };
  }
  const weakTypes = [
    ["perguntas literais", metrics.literal_accuracy_pct],
    ["inferencias", metrics.inferential_accuracy_pct],
    ["vocabulario no contexto", metrics.vocabulary_accuracy_pct],
    ["justificativas", metrics.justification_accuracy_pct]
  ].filter(([, value]) => value !== null && value < 75);
  const focus = weakTypes[0]?.[0] || "justificar a resposta com pistas do texto";
  return {
    summary: `A atividade teve ${metrics.accuracy_pct}% de aproveitamento nas respostas avaliadas. O proximo passo e praticar ${focus} com perguntas curtas.`,
    recipe: ["Retome uma pergunta.", "Pergunte qual frase do texto ajudou.", "Elogie a pista encontrada antes de corrigir."],
    attention_points: weakTypes.length ? [`Vale observar ${focus} nas proximas leituras.`] : ["Manter leituras curtas para consolidar a seguranca."],
    avoid_saying: ["Isso esta facil demais para voce."],
    suggested_phrase: "Boa pista. Agora vamos ver se ela responde exatamente a pergunta."
  };
}

async function generateFeedback(leitura) {
  const metrics = computeMetrics(leitura);
  const scoreText = metrics.objective_scoring_available && metrics.accuracy_pct !== null
    ? `${metrics.accuracy_pct}% (${metrics.questions_correct} corretas, ${metrics.questions_partial} parciais, ${metrics.questions_incorrect} a revisar)`
    : "sem pontuacao estruturada confiavel";
  const respostas = (leitura.respostas || [])
    .map((r) => `Pergunta ${r.pergunta_index}: ${r.pergunta}\nResposta: ${r.resposta}`)
    .join("\n\n");
  const prompt = `
Crie um feedback curto, gentil e especifico para uma crianca sobre esta atividade de interpretacao.
Use portugues do Brasil e fale diretamente com a crianca.

Estrutura desejada:
1. Comece reconhecendo o esforco ou uma atitude positiva.
2. Cite uma coisa concreta que a crianca fez bem, usando pistas das respostas.
3. Diga apenas um proximo passo pratico para melhorar na proxima leitura.

Regras de cuidado:
- Nao use tom de bronca.
- Nao use diagnosticos, rotulos ou comparacoes com outras criancas.
- Nao diga que a crianca foi mal.
- Nao transforme a pontuacao em nota; use a pontuacao apenas como apoio interno.
- Se houver poucos dados, diga que foi uma boa tentativa e convide a procurar pistas no texto com calma.

Texto: ${leitura.texto}
Respostas:
${respostas}
Pontuacao de compreensao: ${scoreText}
Responda sem markdown, em ate 5 frases.
`.trim();

  const generated = await askOpenAI(prompt).catch((error) => {
    console.warn("OpenAI indisponivel em /api/leitura/finish:", error.message);
    return "";
  });
  return generated || "Bom trabalho! Voce concluiu a leitura e respondeu com atencao. Na proxima tentativa, procure voltar ao texto e apontar a parte que ajudou na resposta. Assim, cada resposta fica mais segura e mais facil de explicar.";
}

app.get(["/", "/index.html"], (_req, res) => {
  res.sendFile(path.join(__dirname, "index.html"));
});

app.get("/api", (_req, res) => {
  res.type("text/plain; charset=utf-8").send("OK - Interpretacao de Texto backend rodando");
});

app.get("/api/status", (_req, res) => {
  res.json({
    openai: Boolean(readOpenAIKey()),
    openai_model: process.env.OPENAI_MODEL || "gpt-4.1-mini",
    checked_at: new Date().toISOString()
  });
});

app.post("/api/leitura/start", async (req, res) => {
  try {
    const aluno = cleanText(req.body?.aluno, "Miguel") || "Miguel";
    const idade = clampNumber(req.body?.idade, 11, 6, 18);
    const tema = cleanText(req.body?.tema);
    const tamanhoPedido = cleanText(req.body?.tamanho);
    const textProfile = resolveTextProfile(idade, tamanhoPedido);
    const tamanho = textProfile.resolved;
    const texto = await generateText({ aluno, idade, tema, tamanho, textProfile });

    const store = await readStore();
    const leitura = {
      id: store.nextId++,
      aluno,
      idade,
      tema,
      tamanho,
      tamanho_pedido: textProfile.requested,
      complexidade: textProfile.complexity,
      titulo: "Interpretacao de texto",
      texto,
      created_at: new Date().toISOString(),
      read_time_ms: null,
      questions: [],
      respostas: [],
      feedback: ""
    };
    store.leituras.push(leitura);
    await writeStore(store);
    res.json({
      leitura_id: leitura.id,
      texto,
      config: {
        idade,
        tema,
        tamanho,
        tamanho_pedido: textProfile.requested,
        complexidade: textProfile.complexity
      }
    });
  } catch (error) {
    res.status(500).json({ error: "Erro ao preparar atividade", details: error.message });
  }
});

app.post("/api/leitura/finish-reading", async (req, res) => {
  try {
    const leituraId = Number(req.body?.leitura_id);
    const store = await readStore();
    let leitura = store.leituras.find((item) => item.id === leituraId);
    if (!leitura && req.body?.texto) {
      leitura = leituraFromRequest(req.body);
    }
    if (!leitura) return res.status(404).json({ error: "Sessao nao encontrada" });

    leitura.read_time_ms = Number(req.body?.read_time_ms) || null;
    leitura.questions = await generateQuestions(leitura.texto);
    if (store.leituras.some((item) => item.id === leituraId)) await writeStore(store);
    res.json({ questions: leitura.questions });
  } catch (error) {
    res.status(500).json({ error: "Erro ao gerar perguntas", details: error.message });
  }
});

app.post("/api/leitura/answer", async (req, res) => {
  const leituraId = Number(req.body?.leitura_id);
  const store = await readStore();
  const leitura = store.leituras.find((item) => item.id === leituraId);
  if (!leitura) return res.json({ ok: true, stored: false });

  leitura.respostas.push({
    question_id: cleanText(req.body?.question_id),
    pergunta_index: Number(req.body?.pergunta_index) || null,
    type: cleanText(req.body?.type || req.body?.tipo, "open"),
    tipo: cleanText(req.body?.tipo || req.body?.type, "open"),
    pergunta: cleanText(req.body?.pergunta),
    resposta: cleanText(req.body?.resposta),
    correta: req.body?.correta ?? null,
    tempo_ms: Number(req.body?.tempo_ms) || null,
    question_type: normalizeQuestionType(req.body?.question_type || req.body?.tags?.[0]),
    difficulty: normalizeQuestionDifficulty(req.body?.difficulty),
    expected_answer: cleanText(req.body?.expected_answer),
    evidence: cleanText(req.body?.evidence),
    tags: Array.isArray(req.body?.tags) ? req.body.tags.map(String) : []
  });
  await writeStore(store);
  res.json({ ok: true });
});

app.post("/api/leitura/finish", async (req, res) => {
  try {
    const leituraId = Number(req.body?.leitura_id);
    const store = await readStore();
    let leitura = store.leituras.find((item) => item.id === leituraId);
    if (!leitura && req.body?.texto) {
      leitura = leituraFromRequest(req.body);
    }
    if (!leitura) return res.status(404).json({ error: "Sessao nao encontrada" });

    leitura.respostas = await evaluateAnswers(leitura);
    leitura.feedback = await generateFeedback(leitura);
    leitura.feedback_adult = structuredAdultFeedback(leitura);
    if (store.leituras.some((item) => item.id === leituraId)) await writeStore(store);
    res.json({
      feedback: leitura.feedback,
      adult_feedback: leitura.feedback_adult,
      metrics: computeMetrics(leitura),
      answers: leitura.respostas
    });
  } catch (error) {
    res.status(500).json({ error: "Erro ao gerar feedback", details: error.message });
  }
});

app.get("/api/leitura/resumo", async (req, res) => {
  const aluno = cleanText(req.query?.aluno, "Miguel") || "Miguel";
  const idade = clampNumber(req.query?.idade, 11, 6, 18);
  const limit = clampNumber(req.query?.limit, 30, 1, 200);
  const store = await readStore();
  const sessoes = store.leituras
    .filter((item) => item.aluno === aluno && Number(item.idade) === idade)
    .slice(-limit)
    .reverse()
    .map((item) => ({
      id: item.id,
      created_at: item.created_at,
      read_time_ms: item.read_time_ms,
      total_questions: item.questions?.length ?? 0,
      feedback: item.feedback,
      ...computeMetrics(item)
    }));
  res.json({ aluno, idade, sessoes });
});

app.get("/api/leitura/detalhe", async (req, res) => {
  const leituraId = Number(req.query?.id);
  const store = await readStore();
  const leitura = store.leituras.find((item) => item.id === leituraId);
  if (!leitura) return res.status(404).json({ error: "Sessao nao encontrada" });
  res.json({
    leitura,
    respostas: leitura.respostas || [],
    metrics: computeMetrics(leitura)
  });
});

if (!isVercel) {
  const PORT = Number(process.env.PORT || 3001);
  app.listen(PORT, () => {
    console.log(`Servidor rodando em http://localhost:${PORT}`);
  });
}

export default app;
