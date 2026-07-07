import { createHmac, timingSafeEqual } from "node:crypto";
import { createClient } from "@supabase/supabase-js";

const allowedServices = new Set(["redacao", "interpretacao", "tabuada"]);

function json(res, status, body) {
  return res.status(status).json(body);
}

function verifyActivityToken(token, secret) {
  const [payload, signature] = String(token || "").split(".");
  if (!payload || !signature) return null;

  const expected = createHmac("sha256", secret).update(payload).digest("base64url");
  const expectedBuffer = Buffer.from(expected);
  const receivedBuffer = Buffer.from(signature);

  if (expectedBuffer.length !== receivedBuffer.length) return null;
  if (!timingSafeEqual(expectedBuffer, receivedBuffer)) return null;

  const data = JSON.parse(Buffer.from(payload, "base64url").toString("utf8"));
  if (!data.exp || data.exp < Math.floor(Date.now() / 1000)) return null;
  if (!data.child_id || !data.owner_id || !allowedServices.has(data.service)) return null;
  return data;
}

function normalizeFeedback(feedback) {
  const value = feedback && typeof feedback === "object" ? feedback : {};
  return {
    child: {
      tone: "positive",
      message: value.child?.message || "",
      next_step: value.child?.next_step || ""
    },
    adult: {
      summary: value.adult?.summary || "",
      strengths: Array.isArray(value.adult?.strengths) ? value.adult.strengths : [],
      attention_points: Array.isArray(value.adult?.attention_points) ? value.adult.attention_points : [],
      recipe: Array.isArray(value.adult?.recipe) ? value.adult.recipe : [],
      avoid_saying: Array.isArray(value.adult?.avoid_saying) ? value.adult.avoid_saying : []
    }
  };
}

export default async function handler(req, res) {
  if (req.method !== "POST") {
    res.setHeader("Allow", "POST");
    return json(res, 405, { ok: false, message: "Metodo nao permitido." });
  }

  const url = process.env.SUPABASE_URL;
  const anonKey = process.env.SUPABASE_ANON_KEY;
  const serviceRoleKey = process.env.SUPABASE_SERVICE_ROLE_KEY;
  const tokenSecret = process.env.PORTAL_ACTIVITY_TOKEN_SECRET || serviceRoleKey;

  if (!url || !anonKey || !serviceRoleKey || !tokenSecret) {
    return json(res, 500, { ok: false, message: "Variaveis do Supabase nao configuradas." });
  }

  const body = req.body || {};
  const portalToken = req.headers["x-portal-activity-token"] || body.portal_event_token;
  const bearer = String(req.headers.authorization || "").replace(/^Bearer\s+/i, "");

  let childId = body.child_id;
  let service = body.service;
  let ownerId = "";

  if (portalToken) {
    const tokenData = verifyActivityToken(portalToken, tokenSecret);
    if (!tokenData) return json(res, 401, { ok: false, message: "Token de atividade invalido." });
    childId = tokenData.child_id;
    service = tokenData.service;
    ownerId = tokenData.owner_id;
  } else {
    if (!bearer) return json(res, 401, { ok: false, message: "Sessao nao informada." });
    const userClient = createClient(url, anonKey, {
      global: { headers: { Authorization: `Bearer ${bearer}` } },
      auth: { persistSession: false }
    });
    const { data: userData, error: userError } = await userClient.auth.getUser(bearer);
    if (userError || !userData?.user) return json(res, 401, { ok: false, message: "Sessao invalida." });
    ownerId = userData.user.id;
  }

  if (!childId || !allowedServices.has(service)) {
    return json(res, 400, { ok: false, message: "Informe child_id e service valido." });
  }

  const admin = createClient(url, serviceRoleKey, { auth: { persistSession: false } });
  const { data: link, error: linkError } = await admin
    .from("child_guardians")
    .select("child_id")
    .eq("child_id", childId)
    .eq("guardian_id", ownerId)
    .maybeSingle();

  if (linkError) return json(res, 500, { ok: false, message: linkError.message });
  if (!link) return json(res, 403, { ok: false, message: "Crianca nao vinculada a esta conta." });

  const event = {
    child_id: childId,
    owner_id: ownerId,
    service,
    activity_type: body.activity_type || null,
    title: body.title || null,
    occurred_at: body.occurred_at || new Date().toISOString(),
    duration_ms: Number.isFinite(Number(body.duration_ms)) ? Number(body.duration_ms) : null,
    metrics: body.metrics && typeof body.metrics === "object" ? body.metrics : {},
    feedback: normalizeFeedback(body.feedback),
    artifacts: body.artifacts && typeof body.artifacts === "object" ? body.artifacts : {}
  };

  const { data, error } = await admin.from("activity_events").insert(event).select().single();
  if (error) return json(res, 500, { ok: false, message: error.message });
  return json(res, 200, { ok: true, event: data });
}
