-- Portal Educacional - schema limpo
-- Rode este arquivo no SQL Editor do Supabase.

create extension if not exists "pgcrypto";

create table if not exists public.profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  full_name text,
  role text not null default 'guardian' check (role in ('guardian', 'teacher', 'admin')),
  phone text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.children (
  id uuid primary key default gen_random_uuid(),
  created_by uuid references public.profiles(id) on delete set null,
  full_name text not null,
  birth_date date,
  grade text,
  notes text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

alter table public.children
add column if not exists created_by uuid references public.profiles(id) on delete set null;

create table if not exists public.child_guardians (
  child_id uuid not null references public.children(id) on delete cascade,
  guardian_id uuid not null references public.profiles(id) on delete cascade,
  relationship text,
  created_at timestamptz not null default now(),
  primary key (child_id, guardian_id)
);

create table if not exists public.learning_goals (
  id uuid primary key default gen_random_uuid(),
  child_id uuid not null references public.children(id) on delete cascade,
  owner_id uuid not null references public.profiles(id) on delete cascade,
  area text not null check (area in ('leitura', 'escrita', 'matematica', 'organizacao', 'outro')),
  title text not null,
  description text,
  status text not null default 'active' check (status in ('active', 'paused', 'done')),
  target_level text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.activity_events (
  id uuid primary key default gen_random_uuid(),
  child_id uuid not null references public.children(id) on delete cascade,
  owner_id uuid not null references public.profiles(id) on delete cascade,
  service text not null,
  activity_type text,
  title text,
  occurred_at timestamptz not null default now(),
  duration_ms integer,
  metrics jsonb not null default '{}'::jsonb,
  feedback jsonb not null default '{
    "child": {"tone": "positive", "message": "", "next_step": ""},
    "adult": {"summary": "", "strengths": [], "attention_points": [], "recipe": [], "avoid_saying": []}
  }'::jsonb,
  artifacts jsonb not null default '{}'::jsonb,
  created_at timestamptz not null default now()
);

create table if not exists public.progress_snapshots (
  id uuid primary key default gen_random_uuid(),
  child_id uuid not null references public.children(id) on delete cascade,
  owner_id uuid not null references public.profiles(id) on delete cascade,
  period_start date not null,
  period_end date not null,
  summary jsonb not null default '{}'::jsonb,
  created_at timestamptz not null default now()
);

create table if not exists public.learning_reviews (
  id uuid primary key default gen_random_uuid(),
  child_id uuid not null references public.children(id) on delete cascade,
  owner_id uuid not null references public.profiles(id) on delete cascade,
  period_start date,
  period_end date,
  summary text not null,
  strengths jsonb not null default '[]'::jsonb,
  attention_points jsonb not null default '[]'::jsonb,
  home_recipe jsonb not null default '[]'::jsonb,
  evidence_refs jsonb not null default '[]'::jsonb,
  confidence text not null default 'low' check (confidence in ('low', 'medium', 'high')),
  created_at timestamptz not null default now()
);

alter table public.profiles enable row level security;
alter table public.children enable row level security;
alter table public.child_guardians enable row level security;
alter table public.learning_goals enable row level security;
alter table public.activity_events enable row level security;
alter table public.progress_snapshots enable row level security;
alter table public.learning_reviews enable row level security;

create or replace function public.is_admin()
returns boolean
language sql
stable
as $$
  select exists (
    select 1 from public.profiles
    where id = auth.uid() and role = 'admin'
  );
$$;

create or replace function public.can_access_child(target_child_id uuid)
returns boolean
language sql
stable
as $$
  select public.is_admin()
    or exists (
      select 1 from public.child_guardians
      where child_id = target_child_id
        and guardian_id = auth.uid()
    );
$$;

create or replace function public.create_child_for_current_user(
  child_full_name text,
  child_birth_date date default null,
  child_grade text default null,
  child_notes text default null
)
returns public.children
language plpgsql
security definer
set search_path = public
as $$
declare
  created_child public.children;
begin
  if auth.uid() is null then
    raise exception 'Usuário não autenticado.';
  end if;

  if nullif(trim(child_full_name), '') is null then
    raise exception 'Nome da criança é obrigatório.';
  end if;

  insert into public.profiles (id, full_name)
  values (auth.uid(), coalesce(auth.jwt()->>'email', 'Responsável'))
  on conflict (id) do nothing;

  insert into public.children (created_by, full_name, birth_date, grade, notes)
  values (
    auth.uid(),
    trim(child_full_name),
    child_birth_date,
    nullif(trim(coalesce(child_grade, '')), ''),
    nullif(trim(coalesce(child_notes, '')), '')
  )
  returning * into created_child;

  insert into public.child_guardians (child_id, guardian_id, relationship)
  values (created_child.id, auth.uid(), 'responsavel')
  on conflict (child_id, guardian_id) do nothing;

  return created_child;
end;
$$;

grant execute on function public.create_child_for_current_user(text, date, text, text) to authenticated;

drop policy if exists "profiles_select_own_or_admin" on public.profiles;
create policy "profiles_select_own_or_admin" on public.profiles
for select using (id = auth.uid() or public.is_admin());

drop policy if exists "profiles_insert_own" on public.profiles;
create policy "profiles_insert_own" on public.profiles
for insert with check (id = auth.uid());

drop policy if exists "profiles_update_own" on public.profiles;
create policy "profiles_update_own" on public.profiles
for update using (id = auth.uid()) with check (id = auth.uid());

drop policy if exists "children_select_linked" on public.children;
create policy "children_select_linked" on public.children
for select using (public.can_access_child(id));

drop policy if exists "children_insert_own" on public.children;
create policy "children_insert_own" on public.children
for insert to authenticated with check (created_by = auth.uid());

drop policy if exists "children_update_linked" on public.children;
create policy "children_update_linked" on public.children
for update using (public.can_access_child(id)) with check (public.can_access_child(id));

drop policy if exists "child_guardians_select_linked" on public.child_guardians;
create policy "child_guardians_select_linked" on public.child_guardians
for select using (guardian_id = auth.uid() or public.is_admin());

drop policy if exists "child_guardians_insert_own" on public.child_guardians;
create policy "child_guardians_insert_own" on public.child_guardians
for insert with check (guardian_id = auth.uid());

drop policy if exists "goals_select_linked" on public.learning_goals;
create policy "goals_select_linked" on public.learning_goals
for select using (owner_id = auth.uid() and public.can_access_child(child_id));

drop policy if exists "goals_insert_own" on public.learning_goals;
create policy "goals_insert_own" on public.learning_goals
for insert with check (owner_id = auth.uid() and public.can_access_child(child_id));

drop policy if exists "goals_update_own" on public.learning_goals;
create policy "goals_update_own" on public.learning_goals
for update using (owner_id = auth.uid() and public.can_access_child(child_id))
with check (owner_id = auth.uid() and public.can_access_child(child_id));

drop policy if exists "events_select_linked" on public.activity_events;
create policy "events_select_linked" on public.activity_events
for select using (owner_id = auth.uid() and public.can_access_child(child_id));

drop policy if exists "events_insert_own" on public.activity_events;
create policy "events_insert_own" on public.activity_events
for insert with check (owner_id = auth.uid() and public.can_access_child(child_id));

drop policy if exists "snapshots_select_linked" on public.progress_snapshots;
create policy "snapshots_select_linked" on public.progress_snapshots
for select using (owner_id = auth.uid() and public.can_access_child(child_id));

drop policy if exists "snapshots_insert_own" on public.progress_snapshots;
create policy "snapshots_insert_own" on public.progress_snapshots
for insert with check (owner_id = auth.uid() and public.can_access_child(child_id));

drop policy if exists "reviews_select_linked" on public.learning_reviews;
create policy "reviews_select_linked" on public.learning_reviews
for select using (owner_id = auth.uid() and public.can_access_child(child_id));

drop policy if exists "reviews_insert_own" on public.learning_reviews;
create policy "reviews_insert_own" on public.learning_reviews
for insert with check (owner_id = auth.uid() and public.can_access_child(child_id));

create or replace function public.handle_new_user()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
  insert into public.profiles (id, full_name)
  values (new.id, coalesce(new.raw_user_meta_data->>'full_name', new.email))
  on conflict (id) do nothing;
  return new;
end;
$$;

drop trigger if exists on_auth_user_created on auth.users;
create trigger on_auth_user_created
after insert on auth.users
for each row execute function public.handle_new_user();
