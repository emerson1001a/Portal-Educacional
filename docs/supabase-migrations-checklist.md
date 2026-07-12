# Checklist de Migracoes Supabase

Este documento organiza as migracoes SQL do Portal Educacional para evitar confusao entre o que e obrigatorio, o que ja faz parte do fluxo atual e o que e apenas preparacao futura.

Use este checklist sempre que o banco do Supabase estiver novo, incompleto ou quando uma funcionalidade avisar que falta uma migracao.

## Regra geral

Rode os arquivos no SQL Editor do Supabase na ordem abaixo.

Antes de rodar:

- confirme que esta no projeto Supabase correto;
- leia o objetivo da migracao;
- rode uma por vez;
- se aparecer erro de objeto ja existente, verifique se a migracao tem `if not exists` ou `drop constraint if exists`.

## Base inicial

### 1. `supabase/schema.sql`

Status: obrigatorio para banco novo.

Cria a base principal:

- perfis;
- criancas;
- vinculos com responsaveis;
- metas;
- eventos de atividades;
- leituras de desenvolvimento;
- politicas basicas.

Quando rodar:

- ao criar um novo projeto Supabase;
- se o banco estiver vazio;
- se a tabela `profiles` ou `children` nao existir.

## Migracoes de acesso infantil e missoes

### 2. `supabase/migrations/20260709_access_control_foundation.sql`

Status: obrigatorio para o fluxo adulto/crianca atual.

Cria ou ajusta:

- papeis;
- professores;
- percepcoes adultas;
- tarefas/missoes;
- itens de missao;
- tokens infantis;
- sessoes de atividade;
- vinculos com eventos.

Quando rodar:

- se o link infantil nao funcionar;
- se a area da crianca nao listar missoes;
- se aparecer mensagem sobre migracao de controle de acesso.

### 3. `supabase/migrations/20260710_child_short_codes.sql`

Status: recomendado.

Adiciona suporte a codigo curto infantil temporario.

Quando rodar:

- se quisermos usar codigo curto alem do link infantil;
- em cenarios de sala de aula ou quando digitar o link completo for ruim.

### 4. `supabase/migrations/20260710_goals_assignments_alignment.sql`

Status: obrigatorio para o fluxo atual de metas e missoes.

Alinha:

- status de metas;
- campos de revisao;
- status de itens de missao;
- indices para acompanhamento.

Quando rodar:

- se metas ou missoes nao aceitarem os status usados pelo portal;
- se a parte de acompanhamento por meta estiver inconsistente.

## Configuracoes por modulo

### 5. `supabase/migrations/20260711_assignment_item_config.sql`

Status: obrigatorio para a configuracao avancada da Tabuada por missao.

Adiciona `assignment_items.config`, usado para guardar parametros por modulo.

Hoje a Tabuada usa esse campo para:

- tabuadas escolhidas pelo adulto;
- meta de respostas;
- modo de treino.

Quando rodar:

- se o portal avisar que a configuracao da Tabuada depende de migracao;
- antes de testar missoes de Tabuada configuradas pelo adulto.

Teste rapido:

```sql
select
  column_name,
  data_type,
  column_default
from information_schema.columns
where table_schema = 'public'
  and table_name = 'assignment_items'
  and column_name = 'config';
```

Resultado esperado: uma linha com `config` e tipo `jsonb`.

## Preparacao futura para Ingles

### 6. `supabase/migrations/20260712_learning_goals_english_area.sql`

Status: opcional por enquanto.

Permite que metas pedagogicas usem `area = 'ingles'`.

Quando rodar:

- somente quando o produto for permitir metas adultas de Ingles;
- antes de colocar Ingles como area selecionavel no formulario de metas;
- antes de implementar missoes reais do modulo de Ingles.

Nao precisa rodar apenas porque o modulo aparece como planejado no catalogo.

## Ordem recomendada para banco novo

```text
1. supabase/schema.sql
2. supabase/migrations/20260709_access_control_foundation.sql
3. supabase/migrations/20260710_child_short_codes.sql
4. supabase/migrations/20260710_goals_assignments_alignment.sql
5. supabase/migrations/20260711_assignment_item_config.sql
```

Opcional futuro:

```text
6. supabase/migrations/20260712_learning_goals_english_area.sql
```

## Como validar o minimo atual

Depois de rodar a base e as migracoes atuais, teste no navegador:

```text
/api/supabase-status
```

Resultado esperado para o fluxo atual:

```json
{
  "ok": true,
  "connected": true,
  "status": "ready"
}
```

O endpoint tambem devolve:

- `summary.required`: itens obrigatorios para o fluxo atual;
- `summary.recommended`: itens recomendados, mas tolerados quando ainda faltam;
- `checks`: lista detalhada de cada tabela ou coluna verificada;
- `next_actions`: o que fazer se alguma migracao estiver faltando.

Se `ok` vier `false`, priorize os itens em `summary.required.missing`.

Se apenas `summary.recommended.missing` tiver itens, o portal pode continuar funcionando, mas alguma melhoria pode ficar limitada. Exemplo: sem `assignment_items.config`, a Tabuada pode abrir, mas nao consegue obedecer a configuracao avancada definida pelo adulto.

Depois, no Portal:

- criar ou selecionar uma crianca;
- criar uma missao com Tabuada;
- configurar tabuadas e meta;
- abrir o link infantil;
- confirmar que a atividade mostra a configuracao;
- concluir e verificar se o historico adulto recebeu o registro.

## Decisao

As migracoes devem ser aplicadas com calma e em ordem.

O produto deve continuar tolerante quando uma migracao opcional ainda nao tiver sido aplicada, mas funcionalidades novas podem avisar claramente quando dependem de uma coluna ou tabela especifica.
