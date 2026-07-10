import { createHash } from "node:crypto";
import { createClient } from "@supabase/supabase-js";

export const allowedServices = new Set(["redacao", "interpretacao", "tabuada"]);

export function json(res, status, body) {
  return res.status(status).json(body);
}

export function requiredConfig() {
  const url = process.env.SUPABASE_URL;
  const anonKey = process.env.SUPABASE_ANON_KEY;
  const serviceRoleKey = process.env.SUPABASE_SERVICE_ROLE_KEY;
  if (!url || !anonKey || !serviceRoleKey) {
    return { error: "Variaveis do Supabase nao configuradas." };
  }
  return { url, anonKey, serviceRoleKey };
}

export function adminClient(config) {
  return createClient(config.url, config.serviceRoleKey, { auth: { persistSession: false } });
}

export function userClient(config, bearer) {
  return createClient(config.url, config.anonKey, {
    global: { headers: { Authorization: `Bearer ${bearer}` } },
    auth: { persistSession: false }
  });
}

export function bearerFrom(req) {
  return String(req.headers.authorization || "").replace(/^Bearer\s+/i, "");
}

export async function authenticatedUser(config, bearer) {
  if (!bearer) return { error: "Sessao nao informada.", status: 401 };
  const client = userClient(config, bearer);
  const { data, error } = await client.auth.getUser(bearer);
  if (error || !data?.user) return { error: "Sessao invalida.", status: 401 };
  return { user: data.user };
}

export function hashToken(token) {
  return createHash("sha256").update(String(token)).digest("hex");
}

export function normalizeAccessCode(code) {
  return String(code || "")
    .toUpperCase()
    .replace(/[^A-Z0-9]/g, "");
}

export function hashAccessCode(code) {
  return hashToken(normalizeAccessCode(code));
}

export async function canManageChild(admin, childId, userId) {
  const { data: guardian, error: guardianError } = await admin
    .from("child_guardians")
    .select("child_id, can_manage_tasks, revoked_at")
    .eq("child_id", childId)
    .eq("guardian_id", userId)
    .maybeSingle();

  if (guardianError) {
    const missingColumns = /can_manage_tasks|revoked_at|schema cache/i.test(guardianError.message || "");
    if (!missingColumns) return { error: guardianError.message };

    const { data: legacyGuardian, error: legacyError } = await admin
      .from("child_guardians")
      .select("child_id")
      .eq("child_id", childId)
      .eq("guardian_id", userId)
      .maybeSingle();

    if (legacyError) return { error: legacyError.message };
    if (legacyGuardian) return { allowed: true, legacy: true };
  }

  if (guardian && guardian.revoked_at === null && guardian.can_manage_tasks !== false) {
    return { allowed: true };
  }

  const { data: teacher, error: teacherError } = await admin
    .from("child_teachers")
    .select("child_id, can_manage_tasks, revoked_at")
    .eq("child_id", childId)
    .eq("teacher_id", userId)
    .maybeSingle();

  if (teacherError) {
    const missingTable = /child_teachers|does not exist|schema cache/i.test(teacherError.message || "");
    if (missingTable) return { allowed: false };
    return { error: teacherError.message };
  }

  if (teacher && teacher.revoked_at === null && teacher.can_manage_tasks !== false) {
    return { allowed: true };
  }

  return { allowed: false };
}

export function publicOrigin(req) {
  const host = req.headers["x-forwarded-host"] || req.headers.host;
  const proto = req.headers["x-forwarded-proto"] || "https";
  return host ? `${proto}://${host}` : "";
}
