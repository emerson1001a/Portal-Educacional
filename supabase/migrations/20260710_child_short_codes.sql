-- Portal Educacional - codigo curto infantil
-- Etapa 7: preparacao de banco para acesso por codigo temporario.
--
-- Objetivo:
-- - permitir codigo curto como alias humano de um token infantil;
-- - nao salvar o codigo puro;
-- - manter compatibilidade com os links infantis atuais.
--
-- Rode no SQL Editor do Supabase somente depois de revisar.

alter table public.child_access_tokens
add column if not exists access_code_hash text,
add column if not exists access_code_prefix text,
add column if not exists access_code_created_at timestamptz,
add column if not exists access_code_attempts integer not null default 0;

alter table public.child_access_tokens
drop constraint if exists child_access_tokens_access_code_attempts_check;

alter table public.child_access_tokens
add constraint child_access_tokens_access_code_attempts_check
check (access_code_attempts >= 0);

create unique index if not exists idx_child_access_tokens_access_code_hash
on public.child_access_tokens(access_code_hash)
where access_code_hash is not null;

create index if not exists idx_child_access_tokens_code_active
on public.child_access_tokens(access_code_hash, expires_at)
where access_code_hash is not null and revoked_at is null;
