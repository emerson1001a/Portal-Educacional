import { randomBytes } from "node:crypto";
import {
  adminClient,
  authenticatedUser,
  bearerFrom,
  canManageChild,
  hashAccessCode,
  hashToken,
  json,
  publicOrigin,
  requiredConfig
} from "../lib/portal-api.js";

const EXPIRATION_BY_PURPOSE = {
  child_area: { defaultHours: 24, maxHours: 72 },
  assignment: { defaultHours: 72, maxHours: 168 }
};
const purposes = new Set(["child_area", "assignment"]);

function normalizeHours(value, purpose) {
  const rule = EXPIRATION_BY_PURPOSE[purpose] || EXPIRATION_BY_PURPOSE.child_area;
  const hours = Number(value || rule.defaultHours);
  if (!Number.isFinite(hours) || hours <= 0) return rule.defaultHours;
  return Math.min(Math.ceil(hours), rule.maxHours);
}

function databaseMessage(error) {
  const text = String(error?.message || error || "");
  if (/child_access_tokens|assignments|access_code|schema cache|does not exist|Could not find/i.test(text)) {
    return "A migracao de controle de acesso ainda precisa ser aplicada no Supabase.";
  }
  return text || "Nao foi possivel gerar o acesso infantil.";
}

function normalizePrefix(value, purpose) {
  const fallback = purpose === "assignment" ? "MIS" : "CRI";
  const prefix = String(value || fallback)
    .toUpperCase()
    .replace(/[^A-Z]/g, "")
    .slice(0, 3);
  return prefix || fallback;
}

function generateAccessCode(prefix) {
  const alphabet = "23456789ABCDEFGHJKLMNPQRSTUVWXYZ";
  let suffix = "";
  while (suffix.length < 4) {
    suffix += alphabet[randomBytes(1)[0] % alphabet.length];
  }
  return `${prefix}-${suffix}`;
}

export default async function handler(req, res) {
  if (req.method !== "POST") {
    res.setHeader("Allow", "POST");
    return json(res, 405, { ok: false, message: "Metodo nao permitido." });
  }

  const config = requiredConfig();
  if (config.error) return json(res, 500, { ok: false, message: config.error });

  const auth = await authenticatedUser(config, bearerFrom(req));
  if (auth.error) return json(res, auth.status, { ok: false, message: auth.error });

  const body = req.body || {};
  const childId = body.child_id;
  const assignmentId = body.assignment_id || null;
  const purpose = assignmentId ? "assignment" : (body.purpose || "child_area");
  if (!childId || !purposes.has(purpose)) {
    return json(res, 400, { ok: false, message: "Informe child_id e purpose valido." });
  }

  const admin = adminClient(config);
  const access = await canManageChild(admin, childId, auth.user.id);
  if (access.error) return json(res, 500, { ok: false, message: access.error });
  if (!access.allowed) {
    return json(res, 403, { ok: false, message: "Adulto sem permissao para liberar acesso infantil." });
  }

  if (assignmentId) {
    const { data: assignment, error: assignmentError } = await admin
      .from("assignments")
      .select("id, child_id, status")
      .eq("id", assignmentId)
      .eq("child_id", childId)
      .maybeSingle();

    if (assignmentError) return json(res, 500, { ok: false, message: databaseMessage(assignmentError) });
    if (!assignment) return json(res, 404, { ok: false, message: "Tarefa nao encontrada para esta crianca." });
  }

  const rawToken = randomBytes(32).toString("base64url");
  const expiresInHours = normalizeHours(body.expires_in_hours, purpose);
  const expiresAt = new Date(Date.now() + expiresInHours * 60 * 60 * 1000).toISOString();
  const includeAccessCode = body.include_access_code === true || body.include_access_code === "true";
  const accessCode = includeAccessCode ? generateAccessCode(normalizePrefix(body.access_code_prefix, purpose)) : null;

  const insertPayload = {
    child_id: childId,
    created_by: auth.user.id,
    token_hash: hashToken(rawToken),
    purpose,
    assignment_id: assignmentId,
    expires_at: expiresAt
  };

  if (accessCode) {
    insertPayload.access_code_hash = hashAccessCode(accessCode);
    insertPayload.access_code_prefix = accessCode.split("-")[0];
    insertPayload.access_code_created_at = new Date().toISOString();
  }

  const { data, error } = await admin
    .from("child_access_tokens")
    .insert(insertPayload)
    .select(
      accessCode
        ? "id, child_id, purpose, assignment_id, expires_at, created_at, access_code_prefix"
        : "id, child_id, purpose, assignment_id, expires_at, created_at"
    )
    .single();

  if (error) return json(res, 500, { ok: false, message: databaseMessage(error) });

  const origin = publicOrigin(req);
  const childUrl = origin ? `${origin}/child.html?token=${encodeURIComponent(rawToken)}` : "";

  return json(res, 200, {
    ok: true,
    token: rawToken,
    child_url: childUrl,
    access_code: accessCode,
    access: data
  });
}
