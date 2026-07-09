const defaultModules = [
  {
    id: "interpretacao",
    name: "Interpretação de Texto",
    short_name: "Interpretação",
    area: "leitura",
    description: "Leitura, perguntas e feedback para compreensão.",
    url: "https://interpretacao-de-texto.vercel.app",
    status: "available",
    accent: "reading",
    icon: "L"
  },
  {
    id: "redacao",
    name: "Missão Redação",
    short_name: "Redação",
    area: "escrita",
    description: "Planejamento, escrita e análise da redação.",
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
    description: "Treino de multiplicação com acompanhamento.",
    url: "/tabuada.html",
    status: "available",
    accent: "math",
    icon: "T"
  }
];

export function readModulesFromEnv() {
  if (!process.env.PORTAL_MODULES_JSON) return defaultModules;
  try {
    const parsed = JSON.parse(process.env.PORTAL_MODULES_JSON);
    return Array.isArray(parsed) ? parsed : defaultModules;
  } catch {
    return defaultModules;
  }
}

export function moduleById(moduleId) {
  return readModulesFromEnv().find((module) => module.id === moduleId) || null;
}
