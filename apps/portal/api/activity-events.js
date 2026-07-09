import { createHash, createHmac, timingSafeEqual } from "node:crypto";
import { createClient } from "@supabase/supabase-js";

const allowedServices = new Set(["redacao", "interpretacao", "tabuada"]);

function json(res, status, body) {
  res.setHeader("Access-Control-Allow-Origin", "*");
  res.setHeader("Access-Control-Allow-Methods", "POST, OPTIONS");
  res.setHeader("Access-Control-Allow-Headers", "Content-Type, Authorization, X-Portal-Activity-Token, X-Portal-Child-Token");
  return res.status(status).json(body);
}

function hashToken(token) {
  return createHash("sha256").update(String(token)).digest("hex");
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

async function verifyChildToken(admin, token, body) {
  if (!token) return null;
  const { data: access, error } = await admin
    .from("child_access_tokens")
    .select("id, child_id, created_by, assignment_id, expires_at, revoked_at")
    .eq("token_hash", hashToken(token))
    .maybeSingle();

  if (error) return { error: error.message, status: 500 };
  if (!access) return { error: "Acesso infantil invalido.", status: 401 };
  if (access.revoked_at) return { error: "Acesso infantil revogado.", status: 401 };
  if (new Date(access.expires_at).getTime() <= Date.now()) {
    return { error: "Acesso infantil expirado.", status: 401 };
  }
  if (body.child_id && body.child_id !== access.child_id) {
    return { error: "Acesso infantil nao pertence a esta crianca.", status: 403 };
  }

  return {
    child_id: access.child_id,
    owner_id: access.created_by,
    assignment_id: access.assignment_id || body.assignment_id || null
  };
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
  if (req.method === "OPTIONS") {
    res.setHeader("Access-Control-Allow-Origin", "*");
    res.setHeader("Access-Control-Allow-Methods", "POST, OPTIONS");
    res.setHeader("Access-Control-Allow-Headers", "Content-Type, Authorization, X-Portal-Activity-Token, X-Portal-Child-Token");
    return res.status(204).end();
  }

  if (req.method !== "POST") {
    res.setHeader("Allow", "POST");
    return json(res, 405, { ok: false, message: "Método não permitido." });
  }

  const url = process.env.SUPABASE_URL;
  const anonKey = process.env.SUPABASE_ANON_KEY;
  const serviceRoleKey = process.env.SUPABASE_SERVICE_ROLE_KEY;
  const tokenSecret = process.env.PORTAL_ACTIVITY_TOKEN_SECRET || serviceRoleKey;

  if (!url || !anonKey || !serviceRoleKey || !tokenSecret) {
    return json(res, 500, { ok: false, message: "Variáveis do Supabase não configuradas." });
  }

  const body = req.body || {};
  const portalToken = req.headers["x-portal-activity-token"] || body.portal_event_token;
  const childToken = req.headers["x-portal-child-token"] || body.portal_child_token;
  const bearer = String(req.headers.authorization || "").replace(/^Bearer\s+/i, "");

  let childId = body.child_id;
  let service = body.service;
  let ownerId = "";
  let assignmentId = body.assignment_id || null;
  let skipGuardianCheck = false;
  const admin = createClient(url, serviceRoleKey, { auth: { persistSession: false } });

  if (portalToken) {
    const tokenData = verifyActivityToken(portalToken, tokenSecret);
    if (!tokenData) return json(res, 401, { ok: false, message: "Token de atividade inválido." });
    childId = tokenData.child_id;
    service = tokenData.service;
    ownerId = tokenData.owner_id;
  } else if (childToken) {
    const tokenData = await verifyChildToken(admin, childToken, body);
    if (!tokenData || tokenData.error) {
      return json(res, tokenData?.status || 401, { ok: false, message: tokenData?.error || "Acesso infantil invalido." });
    }
    childId = tokenData.child_id;
    ownerId = tokenData.owner_id;
    assignmentId = tokenData.assignment_id;
    skipGuardianCheck = true;
  } else {
    if (!bearer) return json(res, 401, { ok: false, message: "Sessão não informada." });
    const userClient = createClient(url, anonKey, {
      global: { headers: { Authorization: `Bearer ${bearer}` } },
      auth: { persistSession: false }
    });
    const { data: userData, error: userError } = await userClient.auth.getUser(bearer);
    if (userError || !userData?.user) return json(res, 401, { ok: false, message: "Sessão inválida." });
    ownerId = userData.user.id;
  }

  if (!childId || !allowedServices.has(service)) {
    return json(res, 400, { ok: false, message: "Informe child_id e service válido." });
  }

  if (!skipGuardianCheck) {
    const { data: link, error: linkError } = await admin
    .from("child_guardians")
    .select("child_id")
    .eq("child_id", childId)
    .eq("guardian_id", ownerId)
    .maybeSingle();

  if (linkError) return json(res, 500, { ok: false, message: linkError.message });
  if (!link) return json(res, 403, { ok: false, message: "Criança não vinculada a esta conta." });

  }

  const event = {
    child_id: childId,
    owner_id: ownerId,
    service,
    assignment_id: assignmentId,
    assignment_item_id: body.assignment_item_id || null,
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
