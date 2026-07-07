import { createClient } from "@supabase/supabase-js";

export default async function handler(_req, res) {
  const url = process.env.SUPABASE_URL;
  const serviceRoleKey = process.env.SUPABASE_SERVICE_ROLE_KEY;

  if (!url || !serviceRoleKey) {
    return res.status(500).json({
      ok: false,
      message: "SUPABASE_URL ou SUPABASE_SERVICE_ROLE_KEY não configurada."
    });
  }

  try {
    const supabase = createClient(url, serviceRoleKey, {
      auth: { persistSession: false }
    });

    const { error } = await supabase.from("profiles").select("id").limit(1);

    if (error) {
      return res.status(200).json({
        ok: false,
        connected: true,
        message: "Conectou ao Supabase, mas as tabelas ainda não parecem criadas.",
        details: error.message
      });
    }

    return res.status(200).json({
      ok: true,
      connected: true,
      message: "Supabase configurado e tabela profiles acessível."
    });
  } catch (error) {
    return res.status(500).json({
      ok: false,
      message: "Erro ao testar Supabase.",
      details: error.message
    });
  }
}
