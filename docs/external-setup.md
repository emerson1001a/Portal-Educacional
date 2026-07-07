# Setup Externo

## Estado atual

A base limpa ja existe localmente em:

```text
C:\Users\Emerson\Documents\Codex\PortalEducacional
```

O Git local ja esta inicializado, com branch `main` e remoto configurado para:

```text
https://github.com/emerson1001a/PortalEducacional.git
```

O push ainda nao foi feito porque o repositorio remoto ainda nao existe no GitHub.

## Criar repositorio GitHub

Crie um repositorio novo no GitHub:

```text
Nome: PortalEducacional
Visibilidade: Public ou Private, conforme preferir
README: nao marcar
.gitignore: nao marcar
License: nao marcar
```

Depois rode:

```cmd
cd /d "C:\Users\Emerson\Documents\Codex\PortalEducacional"
git push -u origin main
```

## Criar projeto Vercel

Crie um projeto novo na Vercel conectado ao repositorio `PortalEducacional`.

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
