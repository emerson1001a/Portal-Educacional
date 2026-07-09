-- Smoke test da migracao de controle de acesso.
-- Rode depois de executar:
-- supabase/migrations/20260709_access_control_foundation.sql
--
-- Este arquivo nao altera dados. Ele apenas verifica estrutura esperada.

with expected_tables(name) as (
  values
    ('profile_roles'),
    ('child_teachers'),
    ('classrooms'),
    ('classroom_students'),
    ('adult_perceptions'),
    ('assignments'),
    ('assignment_items'),
    ('child_access_tokens'),
    ('activity_sessions')
)
select
  'table' as check_type,
  name as item,
  case when exists (
    select 1
    from information_schema.tables
    where table_schema = 'public'
      and table_name = expected_tables.name
  ) then 'ok' else 'missing' end as status
from expected_tables
order by item;

with expected_columns(table_name, column_name) as (
  values
    ('child_guardians', 'permission_level'),
    ('child_guardians', 'can_view_reports'),
    ('child_guardians', 'can_manage_goals'),
    ('child_guardians', 'can_manage_tasks'),
    ('child_guardians', 'revoked_at'),
    ('learning_goals', 'created_from_perception_id'),
    ('learning_goals', 'created_by_role'),
    ('learning_goals', 'visibility'),
    ('learning_goals', 'child_safe_title'),
    ('learning_goals', 'child_safe_description'),
    ('activity_events', 'assignment_id'),
    ('activity_events', 'assignment_item_id'),
    ('activity_events', 'session_id'),
    ('activity_events', 'visibility'),
    ('activity_events', 'evidence_level')
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

with expected_functions(name) as (
  values
    ('has_role'),
    ('is_admin'),
    ('can_access_child'),
    ('can_manage_child_tasks'),
    ('can_view_child_reports')
)
select
  'function' as check_type,
  name as item,
  case when exists (
    select 1
    from pg_proc p
    join pg_namespace n on n.oid = p.pronamespace
    where n.nspname = 'public'
      and p.proname = expected_functions.name
  ) then 'ok' else 'missing' end as status
from expected_functions
order by item;

with expected_policies(table_name, policy_name) as (
  values
    ('profile_roles', 'profile_roles_select_own_or_admin'),
    ('profile_roles', 'profile_roles_admin_all'),
    ('child_teachers', 'child_teachers_select_related'),
    ('child_teachers', 'child_teachers_insert_manager'),
    ('classrooms', 'classrooms_select_own'),
    ('classrooms', 'classrooms_insert_own'),
    ('classrooms', 'classrooms_update_own'),
    ('classroom_students', 'classroom_students_select_teacher'),
    ('classroom_students', 'classroom_students_insert_teacher'),
    ('adult_perceptions', 'adult_perceptions_select_allowed'),
    ('adult_perceptions', 'adult_perceptions_insert_author'),
    ('adult_perceptions', 'adult_perceptions_update_author'),
    ('assignments', 'assignments_select_adult'),
    ('assignments', 'assignments_insert_manager'),
    ('assignments', 'assignments_update_manager'),
    ('assignment_items', 'assignment_items_select_adult'),
    ('assignment_items', 'assignment_items_insert_manager'),
    ('assignment_items', 'assignment_items_update_manager'),
    ('child_access_tokens', 'child_access_tokens_select_creator'),
    ('child_access_tokens', 'child_access_tokens_insert_manager'),
    ('activity_sessions', 'activity_sessions_select_adult'),
    ('activity_sessions', 'activity_sessions_insert_adult_or_service')
)
select
  'policy' as check_type,
  table_name || '.' || policy_name as item,
  case when exists (
    select 1
    from pg_policies
    where schemaname = 'public'
      and tablename = expected_policies.table_name
      and policyname = expected_policies.policy_name
  ) then 'ok' else 'missing' end as status
from expected_policies
order by item;
