# Plano de Publicacao

## GitHub

Repositorio sugerido:

```text
PortalEducacional
```

Este repositorio deve conter a raiz `PortalEducacional/`, com `apps/portal`, `supabase`, `modules` e `docs`.

## Vercel

Criar um novo projeto apontando para:

```text
apps/portal
```

Framework preset:

```text
Other
```

Build command:

```text
npm run check
```

Output directory:

```text
.
```

## Supabase

Opcao recomendada:

1. Criar novo projeto Supabase apenas se quisermos uma base totalmente limpa.
2. Se o projeto atual `portal-educacional` estiver vazio ou pouco usado, reaproveitar e rodar `supabase/schema.sql`.

Decisao pratica:

- novo GitHub: sim;
- novo Vercel: sim;
- novo Supabase: somente se quisermos zerar schema/dados com seguranca.
