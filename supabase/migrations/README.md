# Migracoes Supabase

Esta pasta guarda migracoes incrementais e revisaveis.

## Como usar

1. Leia o arquivo inteiro antes de rodar.
2. Rode no SQL Editor do Supabase em ambiente controlado.
3. Depois de rodar, execute os testes manuais indicados no PRD correspondente.

## Migracoes

- `20260709_access_control_foundation.sql`: fundacao da Etapa 2 para multiplos papeis, professor/turma, tarefas, tokens infantis e evidencias.
- `20260710_goals_assignments_alignment.sql`: alinhamento da Etapa 5 para metas, tarefas, status e revisao futura.
- `20260710_child_short_codes.sql`: preparo para codigo curto infantil temporario ligado ao token de acesso.

## Teste relacionado

Depois de rodar a migracao, execute:

```text
supabase/tests/20260709_access_control_smoke.sql
supabase/tests/20260710_goals_assignments_smoke.sql
supabase/tests/20260710_child_short_codes_smoke.sql
```

## Observacao

O arquivo `supabase/schema.sql` continua sendo a base inicial. As migracoes desta pasta evoluem essa base sem apagar o que ja funciona.
