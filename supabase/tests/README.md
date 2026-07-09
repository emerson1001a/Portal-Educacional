# Testes Supabase

Esta pasta guarda scripts e roteiros de teste para o banco.

## Testes disponiveis

- `20260709_access_control_smoke.sql`: verifica se a migracao da Etapa 2 criou as tabelas, colunas, funcoes e policies esperadas.

## Como usar

1. Rode a migracao correspondente no SQL Editor.
2. Abra o teste SQL.
3. Execute no SQL Editor.
4. Confira se todos os resultados aparecem com status `ok`.

## Importante

Smoke tests de estrutura nao substituem testes reais de permissao.

Depois do smoke test, ainda e necessario validar:

- adulto logado;
- crianca vinculada;
- professor vinculado;
- percepcao privada;
- area infantil;
- relatorio adulto.
