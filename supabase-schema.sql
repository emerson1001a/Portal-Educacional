-- Portal Educacional - schema inicial
-- Rode este arquivo no Supabase SQL Editor.

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
  full_name text not null,
  birth_date date,
  grade text,
  notes text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.child_guardians (
  child_id uuid not null references public.children(id) on delete cascade,
  guardian_id uuid not null references public.profiles(id) on delete cascade,
  relationship text,
  created_at timestamptz not null default now(),
  primary key (child_id, guardian_id)
);

create table if not exists public.interpretation_sessions (
  id uuid primary key default gen_random_uuid(),
  child_id uuid references public.children(id) on delete set null,
  student_name text,
  student_age integer,
  theme text,
  text_content text,
  questions jsonb not null default '[]'::jsonb,
  answers jsonb not null default '[]'::jsonb,
  metrics jsonb not null default '{}'::jsonb,
  feedback text,
  created_at timestamptz not null default now()
);

create table if not exists public.writing_sessions (
  id uuid primary key default gen_random_uuid(),
  child_id uuid references public.children(id) on delete set null,
  student_name text,
  student_age integer,
  theme text,
  steps jsonb not null default '{}'::jsonb,
  final_text text,
  metrics jsonb not null default '{}'::jsonb,
  feedback text,
  created_at timestamptz not null default now()
);

create table if not exists public.development_notes (
  id uuid primary key default gen_random_uuid(),
  child_id uuid not null references public.children(id) on delete cascade,
  author_id uuid references public.profiles(id) on delete set null,
  note text not null,
  source text,
  created_at timestamptz not null default now()
);

create table if not exists public.activity_events (
  id uuid primary key default gen_random_uuid(),
  child_id uuid not null references public.children(id) on delete cascade,
  owner_id uuid not null references public.profiles(id) on delete cascade,
  service text not null check (service in ('redacao', 'interpretacao', 'tabuada')),
  activity_type text,
  title text,
  occurred_at timestamptz not null default now(),
  duration_ms integer,
  metrics jsonb not null default '{}'::jsonb,
  feedback jsonb not null default '{}'::jsonb,
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

alter table public.profiles enable row level security;
alter table public.children enable row level security;
alter table public.child_guardians enable row level security;
alter table public.interpretation_sessions enable row level security;
alter table public.writing_sessions enable row level security;
alter table public.development_notes enable row level security;
alter table public.activity_events enable row level security;
alter table public.progress_snapshots enable row level security;

create or replace function public.is_admin()
returns boolean
language sql
stable
as $$
  select exists (
    select 1
    from public.profiles
    where id = auth.uid()
      and role = 'admin'
  );
$$;

create or replace function public.can_access_child(target_child_id uuid)
returns boolean
language sql
stable
as $$
  select public.is_admin()
    or exists (
      select 1
      from public.child_guardians
      where child_id = target_child_id
        and guardian_id = auth.uid()
    );
$$;

drop policy if exists "profiles_select_own_or_admin" on public.profiles;
create policy "profiles_select_own_or_admin"
on public.profiles for select
using (id = auth.uid() or public.is_admin());

drop policy if exists "profiles_update_own" on public.profiles;
create policy "profiles_update_own"
on public.profiles for update
using (id = auth.uid())
with check (id = auth.uid());

drop policy if exists "profiles_insert_own" on public.profiles;
create policy "profiles_insert_own"
on public.profiles for insert
with check (id = auth.uid());

drop policy if exists "children_select_linked" on public.children;
create policy "children_select_linked"
on public.children for select
using (public.can_access_child(id));

drop policy if exists "children_insert_authenticated" on public.children;
create policy "children_insert_authenticated"
on public.children for insert
to authenticated
with check (true);

drop policy if exists "children_update_linked" on public.children;
create policy "children_update_linked"
on public.children for update
using (public.can_access_child(id))
with check (public.can_access_child(id));

drop policy if exists "child_guardians_select_linked" on public.child_guardians;
create policy "child_guardians_select_linked"
on public.child_guardians for select
using (guardian_id = auth.uid() or public.can_access_child(child_id));

drop policy if exists "child_guardians_insert_own" on public.child_guardians;
create policy "child_guardians_insert_own"
on public.child_guardians for insert
with check (guardian_id = auth.uid());

drop policy if exists "interpretation_select_linked" on public.interpretation_sessions;
create policy "interpretation_select_linked"
on public.interpretation_sessions for select
using (child_id is not null and public.can_access_child(child_id));

drop policy if exists "writing_select_linked" on public.writing_sessions;
create policy "writing_select_linked"
on public.writing_sessions for select
using (child_id is not null and public.can_access_child(child_id));

drop policy if exists "notes_select_linked" on public.development_notes;
create policy "notes_select_linked"
on public.development_notes for select
using (public.can_access_child(child_id));

drop policy if exists "events_select_linked" on public.activity_events;
create policy "events_select_linked"
on public.activity_events for select
using (owner_id = auth.uid() and public.can_access_child(child_id));

drop policy if exists "events_insert_own" on public.activity_events;
create policy "events_insert_own"
on public.activity_events for insert
with check (owner_id = auth.uid() and public.can_access_child(child_id));

drop policy if exists "events_update_own" on public.activity_events;
create policy "events_update_own"
on public.activity_events for update
using (owner_id = auth.uid() and public.can_access_child(child_id))
with check (owner_id = auth.uid() and public.can_access_child(child_id));

drop policy if exists "snapshots_select_linked" on public.progress_snapshots;
create policy "snapshots_select_linked"
on public.progress_snapshots for select
using (owner_id = auth.uid() and public.can_access_child(child_id));

drop policy if exists "snapshots_insert_own" on public.progress_snapshots;
create policy "snapshots_insert_own"
on public.progress_snapshots for insert
with check (owner_id = auth.uid() and public.can_access_child(child_id));

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
