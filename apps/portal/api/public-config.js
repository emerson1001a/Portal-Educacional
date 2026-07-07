export default function handler(_req, res) {
  const supabaseUrl = process.env.SUPABASE_URL || "";
  const supabaseAnonKey = process.env.SUPABASE_ANON_KEY || "";

  if (!supabaseUrl || !supabaseAnonKey) {
    return res.status(500).json({
      ok: false,
      message: "SUPABASE_URL ou SUPABASE_ANON_KEY nao configurada."
    });
  }

  return res.status(200).json({
    ok: true,
    supabaseUrl,
    supabaseAnonKey
  });
}
