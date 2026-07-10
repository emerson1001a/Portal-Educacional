-- Smoke test da Etapa 5: metas e tarefas.
-- Rode depois de executar:
-- supabase/migrations/20260710_goals_assignments_alignment.sql
--
-- Este arquivo nao altera dados. Ele apenas verifica estrutura esperada.

with expected_columns(table_name, column_name) as (
  values
    ('learning_goals', 'source_type'),
    ('learning_goals', 'target_skill'),
    ('learning_goals', 'confidence'),
    ('learning_goals', 'review_after_events'),
    ('learning_goals', 'review_after_days'),
    ('learning_goals', 'completed_at'),
    ('assignments', 'goal_id'),
    ('assignments', 'adult_notes'),
    ('assignments', 'child_title'),
    ('assignments', 'child_instructions'),
    ('assignment_items', 'module_id'),
    ('assignment_items', 'child_instructions'),
    ('activity_events', 'assignment_id'),
    ('activity_events', 'assignment_item_id')
)
select
  'column' as check_type,
  table_name || '.' || column_name as item,
  case when exists (
    select 1
    from information_schema.columns
    where table_schema = 'public'
      and table_name = expected_columns.table_name
      and column_name = expected_columns.column_name
  ) then 'ok' else 'missing' end as status
from expected_columns
order by item;

with expected_constraints(table_name, constraint_name) as (
  values
    ('learning_goals', 'learning_goals_status_check'),
    ('learning_goals', 'learning_goals_source_type_check'),
    ('learning_goals', 'learning_goals_confidence_check'),
    ('learning_goals', 'learning_goals_review_after_events_check'),
    ('learning_goals', 'learning_goals_review_after_days_check'),
    ('assignment_items', 'assignment_items_status_check')
)
select
  'constraint' as check_type,
  table_name || '.' || constraint_name as item,
  case when exists (
    select 1
    from information_schema.table_constraints
    where table_schema = 'public'
      and table_name = expected_constraints.table_name
      and constraint_name = expected_constraints.constraint_name
  ) then 'ok' else 'missing' end as status
from expected_constraints
order by item;

with expected_indexes(index_name) as (
  values
    ('idx_learning_goals_child_status'),
    ('idx_learning_goals_target_skill'),
    ('idx_assignments_goal_status'),
    ('idx_activity_events_assignment_item')
)
select
  'index' as check_type,
  index_name as item,
  case when exists (
    select 1
    from pg_indexes
    where schemaname = 'public'
      and indexname = expected_indexes.index_name
  ) then 'ok' else 'missing' end as status
from expected_indexes
order by item;
