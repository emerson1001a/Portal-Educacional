import { createHmac } from "node:crypto";
import { createClient } from "@supabase/supabase-js";

const allowedServices = new Set(["redacao", "interpretacao", "tabuada"]);

function json(res, status, body) {
  return res.status(status).json(body);
}

function sign(payload, secret) {
  return createHmac("sha256", secret).update(payload).digest("base64url");
}

function encode(value) {
  return Buffer.from(JSON.stringify(value)).toString("base64url");
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

  const bearer = String(req.headers.authorization || "").replace(/^Bearer\s+/i, "");
  if (!bearer) return json(res, 401, { ok: false, message: "Sessao nao informada." });

  const body = req.body || {};
  const childId = body.child_id;
  const service = body.service;

  if (!childId || !allowedServices.has(service)) {
    return json(res, 400, { ok: false, message: "Informe child_id e service valido." });
  }

  const userClient = createClient(url, anonKey, {
    global: { headers: { Authorization: `Bearer ${bearer}` } },
    auth: { persistSession: false }
  });
  const { data: userData, error: userError } = await userClient.auth.getUser(bearer);
  if (userError || !userData?.user) {
    return json(res, 401, { ok: false, message: "Sessao invalida." });
  }

  const admin = createClient(url, serviceRoleKey, { auth: { persistSession: false } });
  const { data: link, error: linkError } = await admin
    .from("child_guardians")
    .select("child_id")
    .eq("child_id", childId)
    .eq("guardian_id", userData.user.id)
    .maybeSingle();

  if (linkError) return json(res, 500, { ok: false, message: linkError.message });
  if (!link) return json(res, 403, { ok: false, message: "Crianca nao vinculada a esta conta." });

  const now = Math.floor(Date.now() / 1000);
  const payload = encode({
    child_id: childId,
    owner_id: userData.user.id,
    service,
    iat: now,
    exp: now + 60 * 60 * 2
  });

  return json(res, 200, {
    ok: true,
    token: `${payload}.${sign(payload, tokenSecret)}`,
    expires_in: 60 * 60 * 2
  });
}
