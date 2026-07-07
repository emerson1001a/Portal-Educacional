# Setup Externo

## Estado atual

A base limpa ja existe localmente em:

```text
C:\Users\Emerson\Documents\Codex\PortalEducacional
```

O Git local ja esta inicializado, com branch `main` e remoto configurado para:

```text
https://github.com/emerson1001a/Portal-Educacional.git
```

O push da base limpa ja foi feito preservando o historico anterior do repositorio.

Para atualizar novamente:

```cmd
cd /d "C:\Users\Emerson\Documents\Codex\PortalEducacional"
git push
```

## Criar projeto Vercel

Use o projeto Vercel conectado ao repositorio `Portal-Educacional`.

Configuracao:

```text
Root Directory: apps/portal
Framework Preset: Other
Build Command: npm run check
Output Directory: .
```

Variaveis:

```text
SUPABASE_URL
SUPABASE_ANON_KEY
SUPABASE_SERVICE_ROLE_KEY
PORTAL_ACTIVITY_TOKEN_SECRET
PORTAL_MODULES_JSON
```

## Supabase

Decisao recomendada:

- se quiser comecar totalmente limpo, crie um novo projeto Supabase;
- se quiser ganhar tempo, use o projeto `portal-educacional` atual e rode `supabase/schema.sql`.

Em qualquer caso, rode:

```text
supabase/schema.sql
```

no SQL Editor.
