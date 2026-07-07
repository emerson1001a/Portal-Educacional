const defaultModules = [
  {
    id: "interpretacao",
    name: "Interpretacao de Texto",
    short_name: "Interpretacao",
    area: "leitura",
    description: "Leitura, perguntas e feedback para compreensao.",
    url: "https://interpretacao-de-texto.vercel.app",
    status: "available",
    accent: "reading",
    icon: "L"
  },
  {
    id: "redacao",
    name: "Missao Redacao",
    short_name: "Redacao",
    area: "escrita",
    description: "Planejamento, escrita e analise da redacao.",
    url: "https://missao-redacao.vercel.app/",
    status: "available",
    accent: "writing",
    icon: "R"
  },
  {
    id: "tabuada",
    name: "Tabuada Inteligente",
    short_name: "Tabuada",
    area: "matematica",
    description: "Treino de multiplicacao com acompanhamento.",
    url: "",
    status: "planned",
    accent: "math",
    icon: "T"
  }
];

function readModulesFromEnv() {
  if (!process.env.PORTAL_MODULES_JSON) return defaultModules;
  try {
    const parsed = JSON.parse(process.env.PORTAL_MODULES_JSON);
    return Array.isArray(parsed) ? parsed : defaultModules;
  } catch {
    return defaultModules;
  }
}

export default function handler(_req, res) {
  return res.status(200).json({
    ok: true,
    modules: readModulesFromEnv()
  });
}
