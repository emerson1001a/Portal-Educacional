-- Portal Educacional - alinhamento de metas e tarefas
-- Etapa 5: ajustes incrementais baseados em docs/prd-metas-e-tarefas.md.
--
-- Objetivo:
-- - preservar o schema atual e a migracao de fundacao;
-- - adicionar metadados para revisao de metas;
-- - ampliar status de metas e itens sem quebrar valores atuais;
-- - preparar consultas de acompanhamento longitudinal por meta.
--
-- Rode no SQL Editor do Supabase somente depois de revisar.

-- 1. Campos adicionais para metas pedagogicas.

alter table public.learning_goals
add column if not exists source_type text not null default 'manual',
add column if not exists target_skill text,
add column if not exists confidence text not null default 'low',
add column if not exists review_after_events integer not null default 3,
add column if not exists review_after_days integer not null default 7,
add column if not exists completed_at timestamptz;

-- 2. Check constraints de metas.
-- Mantem os valores atuais e adiciona `archived`.

alter table public.learning_goals
drop constraint if exists learning_goals_status_check;

alter table public.learning_goals
add constraint learning_goals_status_check
check (status in ('active', 'paused', 'done', 'archived'));

alter table public.learning_goals
drop constraint if exists learning_goals_source_type_check;

alter table public.learning_goals
add constraint learning_goals_source_type_check
check (source_type in ('manual', 'adult_perception', 'ai_suggested', 'module_evidence'));

alter table public.learning_goals
drop constraint if exists learning_goals_confidence_check;

alter table public.learning_goals
add constraint learning_goals_confidence_check
check (confidence in ('low', 'medium', 'high'));

alter table public.learning_goals
drop constraint if exists learning_goals_review_after_events_check;

alter table public.learning_goals
add constraint learning_goals_review_after_events_check
check (review_after_events > 0);

alter table public.learning_goals
drop constraint if exists learning_goals_review_after_days_check;

alter table public.learning_goals
add constraint learning_goals_review_after_days_check
check (review_after_days > 0);

-- 3. Status de itens de tarefa.
-- Aceita `in_progress` para compatibilidade com a fundacao atual
-- e `started` para o vocabulário do PRD.

alter table public.assignment_items
drop constraint if exists assignment_items_status_check;

alter table public.assignment_items
add constraint assignment_items_status_check
check (status in ('pending', 'started', 'in_progress', 'done', 'skipped', 'blocked'));

-- 4. Indices para leitura de acompanhamento.

create index if not exists idx_learning_goals_child_status
on public.learning_goals(child_id, status);

create index if not exists idx_learning_goals_target_skill
on public.learning_goals(target_skill)
where target_skill is not null;

create index if not exists idx_assignments_goal_status
on public.assignments(goal_id, status)
where goal_id is not null;

create index if not exists idx_activity_events_assignment_item
on public.activity_events(assignment_item_id)
where assignment_item_id is not null;
