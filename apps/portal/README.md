# Portal Web

Aplicacao principal do Portal Educacional.

## Variaveis

Configure na Vercel:

```text
SUPABASE_URL
SUPABASE_ANON_KEY
SUPABASE_SERVICE_ROLE_KEY
PORTAL_ACTIVITY_TOKEN_SECRET
PORTAL_MODULES_JSON
OPENAI_API_KEY
OPENAI_MODEL
```

`PORTAL_ACTIVITY_TOKEN_SECRET` pode ser uma frase longa aleatoria. Se ficar vazio, as APIs usam `SUPABASE_SERVICE_ROLE_KEY` como segredo de assinatura.

`OPENAI_MODEL` é opcional. Se ficar vazio, o portal usa `gpt-4.1-mini` para organizar percepções pedagógicas.

## Desenvolvimento

```cmd
npm install
npm run check
```

## Supabase

Rode o arquivo:

```text
../../supabase/schema.sql
```

no SQL Editor do Supabase.
