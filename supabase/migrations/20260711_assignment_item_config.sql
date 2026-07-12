-- Portal Educacional - configuracao por item de missao
--
-- Objetivo:
-- - permitir que cada modulo receba parametros proprios definidos pelo adulto;
-- - comecar pela Tabuada: tabuadas, modo e meta de respostas;
-- - manter compatibilidade com itens antigos.
--
-- Rode no SQL Editor do Supabase quando quiser ativar configuracoes por modulo.

alter table public.assignment_items
add column if not exists config jsonb not null default '{}'::jsonb;

create index if not exists idx_assignment_items_config_gin
on public.assignment_items using gin (config);
