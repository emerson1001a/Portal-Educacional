-- Portal Educacional - fundacao de controle de acesso
-- Etapa 2: roles, vinculos, tarefas, acesso infantil e evidencias.
--
-- Objetivo:
-- - evoluir o schema atual sem remover tabelas existentes;
-- - permitir multiplos papeis por adulto;
-- - preparar professor/turma;
-- - separar percepcao adulta de conteudo infantil;
-- - criar tarefas e tokens infantis com escopo;
-- - preparar evidencias ligadas a tarefas.
--
-- Rode no SQL Editor do Supabase somente depois de revisar.

create extension if not exists "pgcrypto";

-- 1. Multiplos papeis por adulto.

create table if not exists public.profile_roles (
  profile_id uuid not null references public.profiles(id) on delete cascade,
  role text not null check (role in ('guardian', 'teacher', 'admin')),
  created_at timestamptz not null default now(),
  primary key (profile_id, role)
);

insert into public.profile_roles (profile_id, role)
select id, role
from public.profiles
where role in ('guardian', 'teacher', 'admin')
on conflict (profile_id, role) do nothing;

-- 2. Evolucao do vinculo responsavel-crianca.

alter table public.child_guardians
add column if not exists permission_level text not null default 'manager'
  check (permission_level in ('viewer', 'manager')),
add column if not exists can_view_reports boolean not null default true,
add column if not exists can_manage_goals boolean not null default true,
add column if not exists can_manage_tasks boolean not null default true,
add column if not exists revoked_at timestamptz;

-- 3. Professor, turmas e alunos.

create table if not exists public.child_teachers (
  child_id uuid not null references public.children(id) on delete cascade,
  teacher_id uuid not null references public.profiles(id) on delete cascade,
  scope text not null default 'individual' check (scope in ('individual', 'classroom', 'tutoring')),
  can_view_evidence boolean not null default true,
  can_view_reports boolean not null default true,
  can_manage_goals boolean not null default true,
  can_manage_tasks boolean not null default true,
  shared_by uuid references public.profiles(id) on delete set null,
  created_at timestamptz not null default now(),
  revoked_at timestamptz,
  primary key (child_id, teacher_id, scope)
);

create table if not exists public.classrooms (
  id uuid primary key default gen_random_uuid(),
  teacher_id uuid not null references public.profiles(id) on delete cascade,
  name text not null,
  description text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.classroom_students (
  classroom_id uuid not null references public.classrooms(id) on delete cascade,
  child_id uuid not null references public.children(id) on delete cascade,
  created_at timestamptz not null default now(),
  primary key (classroom_id, child_id)
);

-- 4. Percepcoes adultas. Conteudo privado por padrao.

create table if not exists public.adult_perceptions (
  id uuid primary key default gen_random_uuid(),
  child_id uuid not null references public.children(id) on delete cascade,
  author_id uuid not null references public.profiles(id) on delete cascade,
  author_context text not null default 'family' check (author_context in ('family', 'school', 'tutoring')),
  visibility text not null default 'private'
    check (visibility in ('private', 'shared_with_guardians', 'shared_with_teachers')),
  raw_text text not null,
  structured_summary jsonb not null default '{}'::jsonb,
  suggested_goal_id uuid references public.learning_goals(id) on delete set null,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

-- 5. Metas com versao segura para crianca.

alter table public.learning_goals
add column if not exists created_from_perception_id uuid references public.adult_perceptions(id) on delete set null,
add column if not exists created_by_role text check (created_by_role in ('guardian', 'teacher', 'admin')),
add column if not exists visibility text not null default 'adult'
  check (visibility in ('adult', 'shared_adults', 'child_safe')),
add column if not exists child_safe_title text,
add column if not exists child_safe_description text;

-- 6. Tarefas atribuidas pelo adulto.

create table if not exists public.assignments (
  id uuid primary key default gen_random_uuid(),
  child_id uuid not null references public.children(id) on delete cascade,
  created_by uuid not null references public.profiles(id) on delete cascade,
  created_by_role text not null default 'guardian' check (created_by_role in ('guardian', 'teacher', 'admin')),
  goal_id uuid references public.learning_goals(id) on delete set null,
  title text not null,
  adult_notes text,
  child_title text not null,
  child_instructions text,
  status text not null default 'draft'
    check (status in ('draft', 'released', 'in_progress', 'done', 'archived')),
  release_at timestamptz,
  due_at timestamptz,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.assignment_items (
  id uuid primary key default gen_random_uuid(),
  assignment_id uuid not null references public.assignments(id) on delete cascade,
  module_id text not null,
  activity_type text,
  title text not null,
  child_instructions text,
  sort_order integer not null default 0,
  required boolean not null default true,
  status text not null default 'pending'
    check (status in ('pending', 'in_progress', 'done', 'skipped')),
  created_at timestamptz not null default now()
);

-- 7. Tokens de acesso infantil. Guardar apenas hash do token.

create table if not exists public.child_access_tokens (
  id uuid primary key default gen_random_uuid(),
  child_id uuid not null references public.children(id) on delete cascade,
  created_by uuid not null references public.profiles(id) on delete cascade,
  token_hash text not null unique,
  purpose text not null default 'child_area'
    check (purpose in ('child_area', 'assignment', 'module_return')),
  assignment_id uuid references public.assignments(id) on delete cascade,
  expires_at timestamptz not null,
  used_at timestamptz,
  revoked_at timestamptz,
  created_at timestamptz not null default now()
);

-- 8. Sessoes e eventos ligados a tarefas.

create table if not exists public.activity_sessions (
  id uuid primary key default gen_random_uuid(),
  child_id uuid not null references public.children(id) on delete cascade,
  assignment_id uuid references public.assignments(id) on delete set null,
  assignment_item_id uuid references public.assignment_items(id) on delete set null,
  module_id text not null,
  started_at timestamptz not null default now(),
  finished_at timestamptz,
  duration_ms integer,
  status text not null default 'started'
    check (status in ('started', 'finished', 'abandoned', 'error')),
  child_access_token_id uuid references public.child_access_tokens(id) on delete set null,
  created_at timestamptz not null default now()
);

alter table public.activity_events
add column if not exists assignment_id uuid references public.assignments(id) on delete set null,
add column if not exists assignment_item_id uuid references public.assignment_items(id) on delete set null,
add column if not exists session_id uuid references public.activity_sessions(id) on delete set null,
add column if not exists visibility text not null default 'adult'
  check (visibility in ('child_safe', 'adult', 'shared_adults')),
add column if not exists evidence_level text not null default 'pedagogical'
  check (evidence_level in ('child_safe', 'pedagogical', 'private_adult', 'operational'));

-- 9. RLS nas novas tabelas.

alter table public.profile_roles enable row level security;
alter table public.child_teachers enable row level security;
alter table public.classrooms enable row level security;
alter table public.classroom_students enable row level security;
alter table public.adult_perceptions enable row level security;
alter table public.assignments enable row level security;
alter table public.assignment_items enable row level security;
alter table public.child_access_tokens enable row level security;
alter table public.activity_sessions enable row level security;

-- 10. Funcoes auxiliares para policies.

create or replace function public.has_role(target_role text)
returns boolean
language sql
stable
security definer
set search_path = public
as $$
  select exists (
    select 1
    from public.profile_roles
    where profile_id = auth.uid()
      and role = target_role
  )
  or exists (
    select 1
    from public.profiles
    where id = auth.uid()
      and role = target_role
  );
$$;

create or replace function public.is_admin()
returns boolean
language sql
stable
security definer
set search_path = public
as $$
  select public.has_role('admin');
$$;

create or replace function public.can_access_child(target_child_id uuid)
returns boolean
language sql
stable
security definer
set search_path = public
as $$
  select public.is_admin()
    or exists (
      select 1
      from public.child_guardians
      where child_id = target_child_id
        and guardian_id = auth.uid()
        and revoked_at is null
    )
    or exists (
      select 1
      from public.child_teachers
      where child_id = target_child_id
        and teacher_id = auth.uid()
        and revoked_at is null
    )
    or exists (
      select 1
      from public.classrooms c
      join public.classroom_students cs on cs.classroom_id = c.id
      where c.teacher_id = auth.uid()
        and cs.child_id = target_child_id
    );
$$;

create or replace function public.can_manage_child_tasks(target_child_id uuid)
returns boolean
language sql
stable
security definer
set search_path = public
as $$
  select public.is_admin()
    or exists (
      select 1
      from public.child_guardians
      where child_id = target_child_id
        and guardian_id = auth.uid()
        and revoked_at is null
        and can_manage_tasks
    )
    or exists (
      select 1
      from public.child_teachers
      where child_id = target_child_id
        and teacher_id = auth.uid()
        and revoked_at is null
        and can_manage_tasks
    )
    or exists (
      select 1
      from public.classrooms c
      join public.classroom_students cs on cs.classroom_id = c.id
      where c.teacher_id = auth.uid()
        and cs.child_id = target_child_id
    );
$$;

create or replace function public.can_view_child_reports(target_child_id uuid)
returns boolean
language sql
stable
security definer
set search_path = public
as $$
  select public.is_admin()
    or exists (
      select 1
      from public.child_guardians
      where child_id = target_child_id
        and guardian_id = auth.uid()
        and revoked_at is null
        and can_view_reports
    )
    or exists (
      select 1
      from public.child_teachers
      where child_id = target_child_id
        and teacher_id = auth.uid()
        and revoked_at is null
        and can_view_reports
    );
$$;

-- 11. Policies novas e ajustes seguros.

drop policy if exists "profile_roles_select_own_or_admin" on public.profile_roles;
create policy "profile_roles_select_own_or_admin" on public.profile_roles
for select using (profile_id = auth.uid() or public.is_admin());

drop policy if exists "profile_roles_admin_all" on public.profile_roles;
create policy "profile_roles_admin_all" on public.profile_roles
for all using (public.is_admin()) with check (public.is_admin());

drop policy if exists "child_teachers_select_related" on public.child_teachers;
create policy "child_teachers_select_related" on public.child_teachers
for select using (
  teacher_id = auth.uid()
  or public.is_admin()
  or exists (
    select 1
    from public.child_guardians cg
    where cg.child_id = child_teachers.child_id
      and cg.guardian_id = auth.uid()
      and cg.revoked_at is null
  )
);

drop policy if exists "child_teachers_insert_manager" on public.child_teachers;
create policy "child_teachers_insert_manager" on public.child_teachers
for insert with check (public.can_manage_child_tasks(child_id));

drop policy if exists "classrooms_select_own" on public.classrooms;
create policy "classrooms_select_own" on public.classrooms
for select using (teacher_id = auth.uid() or public.is_admin());

drop policy if exists "classrooms_insert_own" on public.classrooms;
create policy "classrooms_insert_own" on public.classrooms
for insert with check (teacher_id = auth.uid() or public.is_admin());

drop policy if exists "classrooms_update_own" on public.classrooms;
create policy "classrooms_update_own" on public.classrooms
for update using (teacher_id = auth.uid() or public.is_admin())
with check (teacher_id = auth.uid() or public.is_admin());

drop policy if exists "classroom_students_select_teacher" on public.classroom_students;
create policy "classroom_students_select_teacher" on public.classroom_students
for select using (
  public.is_admin()
  or exists (
    select 1
    from public.classrooms c
    where c.id = classroom_students.classroom_id
      and c.teacher_id = auth.uid()
  )
);

drop policy if exists "classroom_students_insert_teacher" on public.classroom_students;
create policy "classroom_students_insert_teacher" on public.classroom_students
for insert with check (
  public.is_admin()
  or exists (
    select 1
    from public.classrooms c
    where c.id = classroom_students.classroom_id
      and c.teacher_id = auth.uid()
  )
);

drop policy if exists "adult_perceptions_select_allowed" on public.adult_perceptions;
create policy "adult_perceptions_select_allowed" on public.adult_perceptions
for select using (
  author_id = auth.uid()
  or public.is_admin()
  or (
    visibility = 'shared_with_guardians'
    and exists (
      select 1
      from public.child_guardians cg
      where cg.child_id = adult_perceptions.child_id
        and cg.guardian_id = auth.uid()
        and cg.revoked_at is null
    )
  )
  or (
    visibility = 'shared_with_teachers'
    and exists (
      select 1
      from public.child_teachers ct
      where ct.child_id = adult_perceptions.child_id
        and ct.teacher_id = auth.uid()
        and ct.revoked_at is null
    )
  )
);

drop policy if exists "adult_perceptions_insert_author" on public.adult_perceptions;
create policy "adult_perceptions_insert_author" on public.adult_perceptions
for insert with check (
  author_id = auth.uid()
  and public.can_access_child(child_id)
);

drop policy if exists "adult_perceptions_update_author" on public.adult_perceptions;
create policy "adult_perceptions_update_author" on public.adult_perceptions
for update using (author_id = auth.uid())
with check (author_id = auth.uid());

drop policy if exists "assignments_select_adult" on public.assignments;
create policy "assignments_select_adult" on public.assignments
for select using (public.can_access_child(child_id));

drop policy if exists "assignments_insert_manager" on public.assignments;
create policy "assignments_insert_manager" on public.assignments
for insert with check (
  created_by = auth.uid()
  and public.can_manage_child_tasks(child_id)
);

drop policy if exists "assignments_update_manager" on public.assignments;
create policy "assignments_update_manager" on public.assignments
for update using (public.can_manage_child_tasks(child_id))
with check (public.can_manage_child_tasks(child_id));

drop policy if exists "assignment_items_select_adult" on public.assignment_items;
create policy "assignment_items_select_adult" on public.assignment_items
for select using (
  exists (
    select 1
    from public.assignments a
    where a.id = assignment_items.assignment_id
      and public.can_access_child(a.child_id)
  )
);

drop policy if exists "assignment_items_insert_manager" on public.assignment_items;
create policy "assignment_items_insert_manager" on public.assignment_items
for insert with check (
  exists (
    select 1
    from public.assignments a
    where a.id = assignment_items.assignment_id
      and public.can_manage_child_tasks(a.child_id)
  )
);

drop policy if exists "assignment_items_update_manager" on public.assignment_items;
create policy "assignment_items_update_manager" on public.assignment_items
for update using (
  exists (
    select 1
    from public.assignments a
    where a.id = assignment_items.assignment_id
      and public.can_manage_child_tasks(a.child_id)
  )
)
with check (
  exists (
    select 1
    from public.assignments a
    where a.id = assignment_items.assignment_id
      and public.can_manage_child_tasks(a.child_id)
  )
);

drop policy if exists "child_access_tokens_select_creator" on public.child_access_tokens;
create policy "child_access_tokens_select_creator" on public.child_access_tokens
for select using (created_by = auth.uid() or public.is_admin());

drop policy if exists "child_access_tokens_insert_manager" on public.child_access_tokens;
create policy "child_access_tokens_insert_manager" on public.child_access_tokens
for insert with check (
  created_by = auth.uid()
  and public.can_manage_child_tasks(child_id)
);

drop policy if exists "activity_sessions_select_adult" on public.activity_sessions;
create policy "activity_sessions_select_adult" on public.activity_sessions
for select using (public.can_access_child(child_id));

drop policy if exists "activity_sessions_insert_adult_or_service" on public.activity_sessions;
create policy "activity_sessions_insert_adult_or_service" on public.activity_sessions
for insert with check (public.can_access_child(child_id));

-- Ajustes nas policies existentes para considerar professor/turma via can_access_child.

drop policy if exists "children_select_linked" on public.children;
create policy "children_select_linked" on public.children
for select using (public.can_access_child(id));

drop policy if exists "children_update_linked" on public.children;
create policy "children_update_linked" on public.children
for update using (public.can_access_child(id)) with check (public.can_access_child(id));

drop policy if exists "goals_select_linked" on public.learning_goals;
create policy "goals_select_linked" on public.learning_goals
for select using (public.can_access_child(child_id));

drop policy if exists "goals_insert_own" on public.learning_goals;
create policy "goals_insert_own" on public.learning_goals
for insert with check (owner_id = auth.uid() and public.can_manage_child_tasks(child_id));

drop policy if exists "goals_update_own" on public.learning_goals;
create policy "goals_update_own" on public.learning_goals
for update using (public.can_manage_child_tasks(child_id))
with check (public.can_manage_child_tasks(child_id));

drop policy if exists "events_select_linked" on public.activity_events;
create policy "events_select_linked" on public.activity_events
for select using (public.can_access_child(child_id));

drop policy if exists "snapshots_select_linked" on public.progress_snapshots;
create policy "snapshots_select_linked" on public.progress_snapshots
for select using (public.can_view_child_reports(child_id));

drop policy if exists "reviews_select_linked" on public.learning_reviews;
create policy "reviews_select_linked" on public.learning_reviews
for select using (public.can_view_child_reports(child_id));

-- 12. Indices para consultas de permissao.

create index if not exists idx_profile_roles_profile on public.profile_roles(profile_id);
create index if not exists idx_child_guardians_guardian on public.child_guardians(guardian_id) where revoked_at is null;
create index if not exists idx_child_teachers_teacher on public.child_teachers(teacher_id) where revoked_at is null;
create index if not exists idx_classrooms_teacher on public.classrooms(teacher_id);
create index if not exists idx_classroom_students_child on public.classroom_students(child_id);
create index if not exists idx_adult_perceptions_child on public.adult_perceptions(child_id);
create index if not exists idx_assignments_child_status on public.assignments(child_id, status);
create index if not exists idx_assignment_items_assignment on public.assignment_items(assignment_id);
create index if not exists idx_child_access_tokens_hash on public.child_access_tokens(token_hash);
create index if not exists idx_activity_sessions_child on public.activity_sessions(child_id);
create index if not exists idx_activity_events_assignment on public.activity_events(assignment_id);
