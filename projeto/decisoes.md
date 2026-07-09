# Decisoes do Projeto

## 2026-07-09

### Criar pasta de projeto

Decisao:

- criar `projeto/` como painel de acompanhamento;
- manter `docs/` como fonte oficial de PRDs, arquitetura e regras.

Motivo:

- facilitar retomada em janelas sucessivas do Codex;
- evitar que o trabalho fique espalhado;
- separar gestao do trabalho de documentacao formal.

### Etapa 1 com PRD proprio

Decisao:

- fechar a matriz de papeis em `docs/prd-matriz-de-papeis.md`.

Motivo:

- a matriz precisa virar base da Etapa 2;
- permissoes devem ser decididas antes de banco, telas e endpoints.

### Etapa 2 começa por PRD tecnico

Decisao:

- antes de alterar `supabase/schema.sql`, criar `docs/prd-controle-de-acesso-supabase.md`.

Motivo:

- o schema atual funciona para o portal inicial, mas ainda nao cobre professor, turma, token infantil, classificacao de informacao e compartilhamento;
- mudar banco sem PRD aumentaria risco de quebrar o portal atual.

### Migracao incremental em vez de reescrever schema

Decisao:

- criar `supabase/migrations/20260709_access_control_foundation.sql`;
- manter `supabase/schema.sql` como base inicial por enquanto.

Motivo:

- evitar quebrar o portal ja publicado;
- permitir revisar e rodar a migracao manualmente no Supabase;
- preservar dados existentes.

### Token infantil com hash

Decisao:

- a tabela `child_access_tokens` guarda `token_hash`, nao o token puro.

Motivo:

- se houver vazamento de banco, o link/codigo infantil nao fica exposto diretamente;
- a validacao do token deve acontecer em endpoint server-side.
