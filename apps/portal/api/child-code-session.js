import { adminClient, hashAccessCode, json, requiredConfig } from "../lib/portal-api.js";
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
      sort_order: item.sort_order,
      required: item.required,
      status: item.status
    }))
  };
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
    .select("id, child_id, purpose, assignment_id, expires_at, revoked_at")
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
    .select("id, full_name, grade")
    .eq("id", access.child_id)
    .maybeSingle();

  if (childError) return json(res, 500, { ok: false, message: childError.message });
  if (!child) return json(res, 404, { ok: false, message: "Crianca nao encontrada." });

  let assignmentsQuery = admin
    .from("assignments")
    .select("id, child_id, title, child_title, child_instructions, status, due_at, created_at")
    .eq("child_id", access.child_id)
    .eq("status", "released")
    .order("due_at", { ascending: true, nullsFirst: false })
    .order("created_at", { ascending: true });

  if (access.assignment_id) assignmentsQuery = assignmentsQuery.eq("id", access.assignment_id);

  const { data: assignments, error: assignmentsError } = await assignmentsQuery;
  if (assignmentsError) return json(res, 500, { ok: false, message: assignmentsError.message });

  const assignmentIds = (assignments || []).map((assignment) => assignment.id);
  let items = [];
  if (assignmentIds.length) {
    const { data: itemRows, error: itemsError } = await admin
      .from("assignment_items")
      .select("id, assignment_id, module_id, activity_type, title, child_instructions, sort_order, required, status")
      .in("assignment_id", assignmentIds)
      .order("sort_order", { ascending: true });

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
    child,
    access: {
      id: access.id,
      purpose: access.purpose,
      expires_at: access.expires_at
    },
    assignments: (assignments || []).map((assignment) => safeAssignment(assignment, grouped.get(assignment.id) || [])),
    free_modules: readModulesFromEnv().filter((module) => module.status === "available" && module.url)
  });
}
