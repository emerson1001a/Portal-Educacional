# Setup Externo

## Estado atual

A base limpa já existe localmente em:

```text
C:\Users\Emerson\Documents\Codex\PortalEducacional
```

O Git local já está inicializado, com branch `main` e remoto configurado para:

```text
https://github.com/emerson1001a/Portal-Educacional.git
```

O push da base limpa já foi feito preservando o histórico anterior do repositório.

Para atualizar novamente:

```cmd
cd /d "C:\Users\Emerson\Documents\Codex\PortalEducacional"
git push
```

## Criar projeto Vercel

Use o projeto Vercel conectado ao repositório `Portal-Educacional`.

Configuração:

```text
Root Directory: apps/portal
Framework Preset: Other
Build Command: npm run check
Output Directory: .
```

Variáveis:

```text
SUPABASE_URL
SUPABASE_ANON_KEY
SUPABASE_SERVICE_ROLE_KEY
PORTAL_ACTIVITY_TOKEN_SECRET
PORTAL_MODULES_JSON
```

## Supabase

Decisão recomendada:

- se quiser começar totalmente limpo, crie um novo projeto Supabase;
- se quiser ganhar tempo, use o projeto `portal-educacional` atual e rode `supabase/schema.sql`.

Em qualquer caso, rode:

```text
supabase/schema.sql
```

no SQL Editor.
