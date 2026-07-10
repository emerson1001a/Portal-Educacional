# Analise do Schema Para a Etapa 5

Data: 2026-07-10  
Base analisada:

- `supabase/schema.sql`
- `supabase/migrations/20260709_access_control_foundation.sql`

PRD de referencia:

- `docs/prd-metas-e-tarefas.md`

## Resumo

A fundacao criada na Etapa 2 ja cobre a maior parte do fluxo de metas e tarefas:

- `learning_goals` guarda metas pedagogicas;
- `adult_perceptions` guarda percepcoes adultas;
- `assignments` guarda tarefas/missoes;
- `assignment_items` guarda itens por modulo;
- `child_access_tokens` protege a area infantil;
- `activity_sessions` prepara sessoes;
- `activity_events` ja pode receber `assignment_id` e `assignment_item_id`.

A Etapa 5 nao precisa refazer a estrutura. Ela precisa apenas alinhar detalhes do banco ao PRD de metas e tarefas.

## O que ja atende ao PRD

### Percepcao adulta

Atendido por:

- `adult_perceptions.raw_text`
- `adult_perceptions.structured_summary`
- `adult_perceptions.visibility`
- `adult_perceptions.suggested_goal_id`

Ponto importante:

A percepcao adulta fica separada da experiencia infantil.

### Meta pedagogica

Atendido por:

- `learning_goals.child_id`
- `learning_goals.owner_id`
- `learning_goals.area`
- `learning_goals.title`
- `learning_goals.description`
- `learning_goals.status`
- `learning_goals.created_from_perception_id`
- `learning_goals.child_safe_title`
- `learning_goals.child_safe_description`

Ponderacao:

O PRD usa o conceito `created_by`. O schema atual usa `owner_id` e o app ja depende desse campo. Nao devemos renomear agora.

### Tarefa e missao

Atendido por:

- `assignments.goal_id`
- `assignments.title`
- `assignments.adult_notes`
- `assignments.child_title`
- `assignments.child_instructions`
- `assignments.status`
- `assignments.release_at`
- `assignments.due_at`

Ponto importante:

`adult_notes` nao deve aparecer no Portal da Crianca.

### Itens por modulo

Atendido por:

- `assignment_items.assignment_id`
- `assignment_items.module_id`
- `assignment_items.activity_type`
- `assignment_items.title`
- `assignment_items.child_instructions`
- `assignment_items.required`
- `assignment_items.status`

### Evidencias

Atendido por:

- `activity_events.assignment_id`
- `activity_events.assignment_item_id`
- `activity_events.session_id`
- `activity_events.metrics`
- `activity_events.feedback`
- `activity_events.artifacts`
- `activity_events.visibility`
- `activity_events.evidence_level`

## Lacunas encontradas

### 1. Revisao futura da meta

O PRD recomenda controlar quando revisar uma meta.

Campos faltantes em `learning_goals`:

- `target_skill`
- `confidence`
- `review_after_events`
- `review_after_days`
- `completed_at`
- `source_type`

Proposta:

Adicionar os campos sem remover os atuais.

### 2. Status de meta incompleto

O schema inicial permite:

- `active`
- `paused`
- `done`

O PRD recomenda tambem:

- `archived`

Proposta:

Atualizar o check constraint de `learning_goals.status`.

### 3. Status de item precisa ser mais flexivel

A migracao de fundacao usa:

- `pending`
- `in_progress`
- `done`
- `skipped`

O PRD recomenda:

- `pending`
- `started`
- `done`
- `skipped`
- `blocked`

Ponderacao:

Como o app atual pode usar `in_progress`, a migracao deve aceitar `started` e `in_progress` por compatibilidade.

### 4. Smoke test especifico da Etapa 5

O teste da Etapa 2 verifica fundacao de acesso, mas nao verifica os novos campos de metas e tarefas.

Proposta:

Criar `supabase/tests/20260710_goals_assignments_smoke.sql`.

## Migracao proposta

Arquivo:

- `supabase/migrations/20260710_goals_assignments_alignment.sql`

Ela deve:

- adicionar metadados de revisao em `learning_goals`;
- permitir `archived` em metas;
- permitir `started` e `blocked` em itens de tarefa;
- criar indices simples para consultas futuras.

## Riscos

### Check constraints em bancos ja migrados

Se o Supabase tiver constraints com nomes diferentes, a migracao pode precisar ser ajustada.

Mitigacao:

Usar os nomes padrao criados pelas migrations atuais:

- `learning_goals_status_check`
- `assignment_items_status_check`

### App atual

O app atual usa:

- `learning_goals.owner_id`;
- `learning_goals.status = active/done`;
- `assignments.status = released/in_progress`;
- `assignment_items.status = pending`.

A migracao preserva esses valores.

## Decisao

Seguir com migracao incremental pequena, sem alterar o app nesta etapa.

A implementacao visual de metas e tarefas completas deve vir depois que a migracao for revisada e rodada no Supabase.
