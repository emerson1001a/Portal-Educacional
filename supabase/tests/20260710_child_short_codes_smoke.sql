-- Smoke test - codigo curto infantil
-- Rode depois de aplicar supabase/migrations/20260710_child_short_codes.sql.
--
-- Resultado esperado: todos os itens com status `ok`.

with expected_columns(table_name, column_name) as (
  values
    ('child_access_tokens', 'access_code_hash'),
    ('child_access_tokens', 'access_code_prefix'),
    ('child_access_tokens', 'access_code_created_at'),
    ('child_access_tokens', 'access_code_attempts')
),
expected_indexes(index_name) as (
  values
    ('idx_child_access_tokens_access_code_hash'),
    ('idx_child_access_tokens_code_active')
),
expected_constraints(constraint_name) as (
  values
    ('child_access_tokens_access_code_attempts_check')
)
select
  'column' as check_type,
  column_name as item,
  case when exists (
    select 1
    from information_schema.columns
    where table_schema = 'public'
      and table_name = expected_columns.table_name
      and column_name = expected_columns.column_name
  ) then 'ok' else 'missing' end as status
from expected_columns

union all

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

union all

select
  'constraint' as check_type,
  constraint_name as item,
  case when exists (
    select 1
    from information_schema.table_constraints
    where table_schema = 'public'
      and table_name = 'child_access_tokens'
      and constraint_name = expected_constraints.constraint_name
  ) then 'ok' else 'missing' end as status
from expected_constraints

order by check_type, item;
