-- Portal Educacional - area de Ingles para metas pedagogicas
--
-- Objetivo:
-- - preparar o banco para metas adultas ligadas ao futuro modulo de Ingles;
-- - manter os valores atuais de area;
-- - nao habilita o modulo por si so.
--
-- Rode no SQL Editor do Supabase apenas quando o produto for permitir metas de Ingles.

alter table public.learning_goals
drop constraint if exists learning_goals_area_check;

alter table public.learning_goals
add constraint learning_goals_area_check
check (area in ('leitura', 'escrita', 'matematica', 'ingles', 'organizacao', 'outro'));
