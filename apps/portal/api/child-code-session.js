import { randomBytes } from "node:crypto";
import { adminClient, hashAccessCode, hashToken, json, publicOrigin, requiredConfig } from "../lib/portal-api.js";
import { moduleById, readModulesFromEnv } from "../lib/modules.js";

function allowCors(res) {
  res.setHeader("Access-Control-Allow-Origin", "*");
  res.setHeader("Access-Control-Allow-Methods", "POST, OPTIONS");
  res.setHeader("Access-Control-Allow-Headers", "Content-Type");
}

function databaseMessage(error) {
  const text = String(error?.message || error || "");
  if (/child_access_tokens|access_code|schema cache|does not exist|Could not find/i.test(text)) {
    return "A migracao de codigo curto infantil ainda precisa ser aplicada no Supabase.";
  }
  return text || "Nao foi possivel validar o codigo.";
}

function safeAssignment(assignment, items) {
  return {
    id: assignment.id,
    child_id: assignment.child_id,
    title: assignment.child_title || assignment.title,
    instructions: assignment.child_instructions || "",
    status: assignment.status,
    due_at: assignment.due_at,
    items: items.map((item) => ({
      id: item.id,
      module_id: item.module_id,
      module: moduleById(item.module_id),
      activity_type: item.activity_type,
      title: item.title,
      child_instructions: item.child_instructions || "",
      config: item.config || {},
      sort_order: item.sort_order,
      required: item.required,
      status: item.status
    }))
  };
}

function ageFromBirthDate(value) {
  if (!value) return null;
  const birth = new Date(`${value}T00:00:00`);
  if (Number.isNaN(birth.getTime())) return null;
  const today = new Date();
  let age = today.getFullYear() - birth.getFullYear();
  const monthDelta = today.getMonth() - birth.getMonth();
  if (monthDelta < 0 || (monthDelta === 0 && today.getDate() < birth.getDate())) age -= 1;
  return age > 0 && age < 25 ? age : null;
}

function sessionExpiresAt(accessExpiresAt) {
  const accessTime = new Date(accessExpiresAt).getTime();
  const twoHours = Date.now() + 2 * 60 * 60 * 1000;
  const expiresAt = Math.min(accessTime, twoHours);
  return new Date(expiresAt).toISOString();
}

export default async function handler(req, res) {
  allowCors(res);

  if (req.method === "OPTIONS") return res.status(204).end();
  if (req.method !== "POST") {
    res.setHeader("Allow", "POST");
    return json(res, 405, { ok: false, message: "Metodo nao permitido." });
  }

  const code = String(req.body?.code || "");
  if (!code.trim()) return json(res, 400, { ok: false, message: "Codigo infantil nao informado." });

  const config = requiredConfig();
  if (config.error) return json(res, 500, { ok: false, message: config.error });

  const admin = adminClient(config);
  const { data: access, error: accessError } = await admin
    .from("child_access_tokens")
    .select("id, child_id, created_by, purpose, assignment_id, expires_at, revoked_at")
    .eq("access_code_hash", hashAccessCode(code))
    .maybeSingle();

  if (accessError) return json(res, 500, { ok: false, message: databaseMessage(accessError) });
  if (!access) return json(res, 401, { ok: false, message: "Codigo nao disponivel agora. Peca ajuda para um adulto." });
  if (access.revoked_at) return json(res, 401, { ok: false, message: "Codigo nao disponivel agora. Peca ajuda para um adulto." });
  if (new Date(access.expires_at).getTime() <= Date.now()) {
    return json(res, 401, { ok: false, message: "Codigo expirado. Peca ajuda para um adulto." });
  }

  const { data: child, error: childError } = await admin
    .from("children")
    .select("id, full_name, birth_date, grade")
    .eq("id", access.child_id)
    .maybeSingle();

  if (childError) return json(res, 500, { ok: false, message: childError.message });
  if (!child) return json(res, 404, { ok: false, message: "Crianca nao encontrada." });

  const rawToken = randomBytes(32).toString("base64url");
  const childSessionExpiresAt = sessionExpiresAt(access.expires_at);
  const { error: tokenError } = await admin
    .from("child_access_tokens")
    .insert({
      child_id: access.child_id,
      created_by: access.created_by,
      token_hash: hashToken(rawToken),
      purpose: access.purpose,
      assignment_id: access.assignment_id,
      expires_at: childSessionExpiresAt
    });

  if (tokenError) return json(res, 500, { ok: false, message: databaseMessage(tokenError) });

  let assignmentsQuery = admin
    .from("assignments")
    .select("id, child_id, title, child_title, child_instructions, status, due_at, created_at")
    .eq("child_id", access.child_id)
    .in("status", access.assignment_id ? ["released", "in_progress", "done"] : ["released", "in_progress"])
    .order("due_at", { ascending: true, nullsFirst: false })
    .order("created_at", { ascending: true });

  if (access.assignment_id) assignmentsQuery = assignmentsQuery.eq("id", access.assignment_id);

  const { data: assignments, error: assignmentsError } = await assignmentsQuery;
  if (assignmentsError) return json(res, 500, { ok: false, message: assignmentsError.message });

  const assignmentIds = (assignments || []).map((assignment) => assignment.id);
  let items = [];
  if (assignmentIds.length) {
    let { data: itemRows, error: itemsError } = await admin
      .from("assignment_items")
      .select("id, assignment_id, module_id, activity_type, title, child_instructions, config, sort_order, required, status")
      .in("assignment_id", assignmentIds)
      .order("sort_order", { ascending: true });

    if (itemsError && /config|schema cache|column/i.test(String(itemsError.message || ""))) {
      const retry = await admin
        .from("assignment_items")
        .select("id, assignment_id, module_id, activity_type, title, child_instructions, sort_order, required, status")
        .in("assignment_id", assignmentIds)
        .order("sort_order", { ascending: true });
      itemRows = retry.data;
      itemsError = retry.error;
    }

    if (itemsError) return json(res, 500, { ok: false, message: itemsError.message });
    items = itemRows || [];
  }

  const grouped = new Map();
  items.forEach((item) => {
    const list = grouped.get(item.assignment_id) || [];
    list.push(item);
    grouped.set(item.assignment_id, list);
  });

  return json(res, 200, {
    ok: true,
    token: rawToken,
    child_url: `${publicOrigin(req)}/child.html?token=${encodeURIComponent(rawToken)}`,
    child: {
      ...child,
      age: ageFromBirthDate(child.birth_date)
    },
    access: {
      id: access.id,
      purpose: access.purpose,
      assignment_id: access.assignment_id,
      expires_at: access.expires_at,
      session_expires_at: childSessionExpiresAt
    },
    assignments: (assignments || []).map((assignment) => safeAssignment(assignment, grouped.get(assignment.id) || [])),
    free_modules: readModulesFromEnv().filter((module) => module.status === "available" && module.url)
  });
}
