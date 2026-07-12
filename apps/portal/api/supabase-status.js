import { createClient } from "@supabase/supabase-js";

const CHECKS = [
  {
    id: "base_profiles",
    requirement: "required",
    label: "Base: perfis",
    migration: "supabase/schema.sql",
    run: (client) => client.from("profiles").select("id").limit(1)
  },
  {
    id: "base_children",
    requirement: "required",
    label: "Base: criancas",
    migration: "supabase/schema.sql",
    run: (client) => client.from("children").select("id, birth_date").limit(1)
  },
  {
    id: "base_guardians",
    requirement: "required",
    label: "Base: vinculos adulto-crianca",
    migration: "supabase/schema.sql",
    run: (client) => client.from("child_guardians").select("child_id, guardian_id").limit(1)
  },
  {
    id: "base_activity_events",
    requirement: "required",
    label: "Base: historico de atividades",
    migration: "supabase/schema.sql",
    run: (client) => client.from("activity_events").select("id, child_id, service").limit(1)
  },
  {
    id: "access_assignments",
    requirement: "required",
    label: "Missoes: tarefas",
    migration: "20260709_access_control_foundation.sql",
    run: (client) => client.from("assignments").select("id, child_id, status").limit(1)
  },
  {
    id: "access_assignment_items",
    requirement: "required",
    label: "Missoes: itens por modulo",
    migration: "20260709_access_control_foundation.sql",
    run: (client) => client.from("assignment_items").select("id, assignment_id, module_id, status").limit(1)
  },
  {
    id: "access_child_tokens",
    requirement: "required",
    label: "Acesso infantil por link",
    migration: "20260709_access_control_foundation.sql",
    run: (client) => client.from("child_access_tokens").select("id, child_id, token_hash, expires_at").limit(1)
  },
  {
    id: "access_activity_sessions",
    requirement: "required",
    label: "Sessoes de atividade",
    migration: "20260709_access_control_foundation.sql",
    run: (client) => client.from("activity_sessions").select("id, child_id, module_id, status").limit(1)
  },
  {
    id: "goal_alignment",
    requirement: "required",
    label: "Metas: acompanhamento e revisao",
    migration: "20260710_goals_assignments_alignment.sql",
    run: (client) => client.from("learning_goals").select("id, source_type, confidence, review_after_events, completed_at").limit(1)
  },
  {
    id: "assignment_item_config",
    requirement: "recommended",
    label: "Configuracao por modulo",
    migration: "20260711_assignment_item_config.sql",
    run: (client) => client.from("assignment_items").select("id, config").limit(1)
  },
  {
    id: "child_short_codes",
    requirement: "recommended",
    label: "Codigo infantil curto",
    migration: "20260710_child_short_codes.sql",
    run: (client) => client.from("child_access_tokens").select("id, access_code_hash, access_code_prefix").limit(1)
  }
];

function emptySummary() {
  return {
    required: { ok: 0, total: 0, missing: [] },
    recommended: { ok: 0, total: 0, missing: [] },
    future: { ok: 0, total: 0, missing: [] }
  };
}

function safeDetails(error) {
  return String(error?.message || "Erro nao informado.").replace(/\s+/g, " ").trim();
}

function resultFor(check, error) {
  if (!error) {
    return {
      id: check.id,
      label: check.label,
      requirement: check.requirement,
      status: "ok",
      migration: check.migration,
      message: "Disponivel."
    };
  }

  return {
    id: check.id,
    label: check.label,
    requirement: check.requirement,
    status: "missing",
    migration: check.migration,
    message: "Nao disponivel neste banco. Rode ou revise a migracao indicada.",
    details: safeDetails(error)
  };
}

function buildSummary(checks) {
  const summary = emptySummary();

  checks.forEach((check) => {
    const bucket = summary[check.requirement] || summary.future;
    bucket.total += 1;
    if (check.status === "ok") {
      bucket.ok += 1;
    } else {
      bucket.missing.push({
        id: check.id,
        label: check.label,
        migration: check.migration
      });
    }
  });

  return summary;
}

function nextActions(summary) {
  const actions = [];

  if (summary.required.missing.length) {
    actions.push("Rode as migracoes obrigatorias indicadas antes de testar missoes e acesso infantil.");
  }

  if (summary.recommended.missing.some((item) => item.id === "assignment_item_config")) {
    actions.push("Rode a migracao de configuracao por modulo para a Tabuada obedecer as escolhas do adulto.");
  }

  if (summary.recommended.missing.some((item) => item.id === "child_short_codes")) {
    actions.push("O codigo infantil curto e recomendado, mas o link infantil continua funcionando sem ele.");
  }

  if (!actions.length) {
    actions.push("Banco pronto para o fluxo atual do portal.");
  }

  return actions;
}

export default async function handler(_req, res) {
  const url = process.env.SUPABASE_URL;
  const serviceRoleKey = process.env.SUPABASE_SERVICE_ROLE_KEY;

  if (!url || !serviceRoleKey) {
    return res.status(500).json({
      ok: false,
      connected: false,
      status: "missing_env",
      message: "SUPABASE_URL ou SUPABASE_SERVICE_ROLE_KEY nao configurada."
    });
  }

  try {
    const supabase = createClient(url, serviceRoleKey, {
      auth: { persistSession: false }
    });

    const checks = [];

    for (const check of CHECKS) {
      const { error } = await check.run(supabase);
      checks.push(resultFor(check, error));
    }

    const summary = buildSummary(checks);
    const ok = summary.required.missing.length === 0;

    return res.status(200).json({
      ok,
      connected: true,
      status: ok ? "ready" : "needs_migration",
      message: ok
        ? "Supabase configurado para o fluxo atual do portal."
        : "Supabase conectou, mas ainda faltam migracoes obrigatorias.",
      summary,
      checks,
      next_actions: nextActions(summary)
    });
  } catch (error) {
    return res.status(500).json({
      ok: false,
      connected: false,
      status: "error",
      message: "Erro ao testar Supabase.",
      details: error.message
    });
  }
}
