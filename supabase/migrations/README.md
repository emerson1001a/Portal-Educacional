# Migracoes Supabase

Esta pasta guarda migracoes incrementais e revisaveis.

## Como usar

1. Leia o arquivo inteiro antes de rodar.
2. Rode no SQL Editor do Supabase em ambiente controlado.
3. Depois de rodar, execute os testes manuais indicados no PRD correspondente.

## Migracoes

- `20260709_access_control_foundation.sql`: fundacao da Etapa 2 para multiplos papeis, professor/turma, tarefas, tokens infantis e evidencias.

## Observacao

O arquivo `supabase/schema.sql` continua sendo a base inicial. As migracoes desta pasta evoluem essa base sem apagar o que ja funciona.
