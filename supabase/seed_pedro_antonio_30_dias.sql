-- Massa de teste longitudinal para Pedro Antonio.
--
-- Cria 32 evidencias simuladas:
-- - 4 semanas;
-- - 2 atividades por modulo em cada semana;
-- - modulos: interpretacao, redacao, tabuada e ingles;
-- - leitura, tabuada e ingles melhoram gradualmente;
-- - redacao fica sem evolucao clara, para testar o alerta longitudinal.
--
-- Seguro para rodar mais de uma vez:
-- antes de inserir, apaga todos os eventos do Pedro Antonio.
-- Use apenas para aluno de teste.

do $$
declare
  v_child_id uuid;
  v_owner_id uuid;
  v_week integer;
  v_attempt integer;
  v_service_order integer;
  v_event_number integer;
  v_age_days integer;
  v_event_at timestamptz;
  v_service text;
  v_activity_type text;
  v_title text;
  v_accuracy numeric;
  v_structure numeric;
  v_duration integer;
  v_metrics jsonb;
  v_feedback jsonb;
  v_artifacts jsonb;
begin
  select c.id
    into v_child_id
    from public.children c
   where lower(c.full_name) like '%pedro%'
     and lower(c.full_name) like '%ant%nio%'
   order by c.created_at desc
   limit 1;

  if v_child_id is null then
    raise exception 'Crianca Pedro Antonio nao encontrada.';
  end if;

  select cg.guardian_id
    into v_owner_id
    from public.child_guardians cg
   where cg.child_id = v_child_id
     and coalesce(cg.revoked_at, 'infinity'::timestamptz) > now()
   order by cg.created_at asc
   limit 1;

  if v_owner_id is null then
    select c.created_by
      into v_owner_id
      from public.children c
     where c.id = v_child_id;
  end if;

  if v_owner_id is null then
    raise exception 'Pedro Antonio nao tem adulto responsavel vinculado.';
  end if;

  delete from public.activity_events
   where child_id = v_child_id;

  for v_week in 1..4 loop
    for v_attempt in 1..2 loop
      for v_service_order in 1..4 loop
        v_event_number := ((v_attempt - 1) * 4) + v_service_order - 1;
        v_age_days := greatest(0, (34 - (v_week * 7)) - least(v_event_number, 6));
        v_event_at := (current_date - v_age_days) + make_interval(hours => 9 + v_service_order, mins => 10 * v_attempt);

        v_service := case v_service_order
          when 1 then 'interpretacao'
          when 2 then 'redacao'
          when 3 then 'tabuada'
          else 'ingles'
        end;

        v_activity_type := case v_service
          when 'interpretacao' then 'reading_comprehension'
          when 'redacao' then 'guided_writing'
          when 'tabuada' then 'treino_finalizado'
          else 'grammar_practice'
        end;

        v_title := case v_service
          when 'interpretacao' then format('Leitura %s.%s: pistas no texto', v_week, v_attempt)
          when 'redacao' then format('Redacao %s.%s: historia guiada', v_week, v_attempt)
          when 'tabuada' then format('Tabuada %s.%s: treino curto', v_week, v_attempt)
          else format('Ingles %s.%s: pratica curta', v_week, v_attempt)
        end;

        v_accuracy := case v_service
          when 'interpretacao' then least(0.86, 0.55 + ((v_week - 1) * 0.08) + ((v_attempt - 1) * 0.03))
          when 'tabuada' then least(0.91, 0.64 + ((v_week - 1) * 0.08) + ((v_attempt - 1) * 0.04))
          when 'ingles' then least(0.84, 0.52 + ((v_week - 1) * 0.07) + ((v_attempt - 1) * 0.04))
          else null
        end;

        -- Redacao deliberadamente sem curva de melhora.
        v_structure := case v_week
          when 1 then 0.53
          when 2 then 0.52
          when 3 then 0.54
          else 0.53
        end + case when v_attempt = 2 then 0.01 else 0 end;

        v_duration := case v_service
          when 'interpretacao' then (8 + v_week) * 60 * 1000
          when 'redacao' then (18 + v_week) * 60 * 1000
          when 'tabuada' then (5 + v_week) * 60 * 1000
          else (6 + v_week) * 60 * 1000
        end;

        v_metrics := case v_service
          when 'interpretacao' then jsonb_build_object(
            'week', v_week,
            'attempt', v_attempt,
            'questions_total', 5,
            'questions_correct', round(v_accuracy * 5),
            'accuracy', v_accuracy,
            'complexity', case when v_week <= 2 then 'curto' else 'medio' end,
            'support_level', case when v_week <= 2 then 'medio' else 'baixo' end
          )
          when 'redacao' then jsonb_build_object(
            'week', v_week,
            'attempt', v_attempt,
            'steps_total', 6,
            'steps_completed', case when v_week <= 2 then 4 else 5 end,
            'revision_rounds', 1,
            'word_count', 70 + (v_week * 4) + (v_attempt * 3),
            'structure_score', v_structure,
            'beginning_middle_end', 'inconsistente'
          )
          when 'tabuada' then jsonb_build_object(
            'week', v_week,
            'attempt', v_attempt,
            'total_attempts', 12 + (v_week * 2),
            'correct_attempts', round(v_accuracy * (12 + (v_week * 2))),
            'accuracy', v_accuracy,
            'median_seconds', greatest(2.1, 4.1 - (v_week * 0.45) - (v_attempt * 0.1)),
            'target_attempts', 12 + (v_week * 2),
            'tabs', jsonb_build_array(2, 3, least(6, 3 + v_week)),
            'completed', true
          )
          else jsonb_build_object(
            'week', v_week,
            'attempt', v_attempt,
            'skill', case
              when v_week = 1 then 'verb_to_be'
              when v_week = 2 then 'simple_present'
              when v_week = 3 then 'present_continuous'
              else 'question_words'
            end,
            'support_level', case when v_week <= 2 then 'high' when v_week = 3 then 'medium' else 'low' end,
            'items_total', 10,
            'correct', round(v_accuracy * 10),
            'accuracy', v_accuracy
          )
        end;

        v_feedback := case v_service
          when 'redacao' then jsonb_build_object(
            'child', jsonb_build_object(
              'tone', 'positive',
              'message', 'Voce esta treinando a redacao por partes. Hoje vamos cuidar de uma parte pequena.',
              'next_step', 'Na proxima, vamos tentar deixar o comeco mais claro antes de continuar.'
            ),
            'adult', jsonb_build_object(
              'summary', 'Mesmo com pratica frequente, a redacao ainda nao mostra evolucao consistente em estrutura. O caminho agora e reduzir a tarefa, manter começo-meio-fim como roteiro fixo e observar mais algumas tentativas antes de aumentar a exigencia.',
              'strengths', jsonb_build_array('Aceita iniciar a atividade', 'Consegue produzir algumas ideias'),
              'attention_points', jsonb_build_array('Estrutura segue oscilando', 'Comeco e meio ainda se misturam', 'Final costuma ficar pouco fechado'),
              'recipe', jsonb_build_array(
                'Trabalhe uma etapa por vez, sem pedir a redacao inteira de novo.',
                'Antes de escrever, pergunte: onde começa? qual foi o problema? como terminou?',
                'Elogie a tentativa e escolha apenas um ajuste pequeno.'
              ),
              'avoid_saying', jsonb_build_array('Voce nao evoluiu.', 'Esta tudo errado.', 'De novo o mesmo problema.')
            )
          )
          when 'interpretacao' then jsonb_build_object(
            'child', jsonb_build_object(
              'tone', 'positive',
              'message', 'Voce esta encontrando mais pistas no texto.',
              'next_step', 'Continue procurando a frase que ajuda na resposta.'
            ),
            'adult', jsonb_build_object(
              'summary', 'Leitura apresenta melhora gradual em localizacao de informacoes e autonomia.',
              'strengths', jsonb_build_array('Mais busca por pistas', 'Melhor continuidade'),
              'attention_points', jsonb_build_array('Inferencias ainda precisam de pergunta-guia'),
              'recipe', jsonb_build_array('Pergunte: que frase do texto ajudou?', 'Use uma pergunta profunda por vez.'),
              'avoid_saying', jsonb_build_array('Voce chutou.')
            )
          )
          when 'tabuada' then jsonb_build_object(
            'child', jsonb_build_object(
              'tone', 'positive',
              'message', 'Voce concluiu mais um treino curto de tabuada.',
              'next_step', 'A repeticao vai deixando as respostas mais automaticas.'
            ),
            'adult', jsonb_build_object(
              'summary', 'Tabuada mostra evolucao gradual em acertos e tempo, com boa resposta a doses curtas.',
              'strengths', jsonb_build_array('Conclui metas curtas', 'Acuracia em melhora'),
              'attention_points', jsonb_build_array('Evitar aumentar carga rapido demais'),
              'recipe', jsonb_build_array('Manter meta curta.', 'Encerrar quando a missao for cumprida.'),
              'avoid_saying', jsonb_build_array('Agora nao pode errar.')
            )
          )
          else jsonb_build_object(
            'child', jsonb_build_object(
              'tone', 'positive',
              'message', 'Voce praticou ingles em uma parte pequena.',
              'next_step', 'Vamos continuar com frases curtas.'
            ),
            'adult', jsonb_build_object(
              'summary', 'Ingles mostra melhora gradual com reducao de apoio ao longo das semanas.',
              'strengths', jsonb_build_array('Mais reconhecimento de padroes', 'Aceita pistas curtas'),
              'attention_points', jsonb_build_array('Manter revisoes para nao esquecer'),
              'recipe', jsonb_build_array('Use exemplos curtos.', 'Corrija com uma frase-modelo positiva.'),
              'avoid_saying', jsonb_build_array('Voce ja deveria saber isso.')
            )
          )
        end;

        v_artifacts := jsonb_build_object(
          'demo_dataset', 'pedro_antonio_30_dias',
          'demo', true,
          'week', v_week,
          'attempt', v_attempt,
          'profile_note', case
            when v_service = 'redacao' then 'redacao_sem_evolucao_clara'
            else 'evolucao_gradual'
          end
        ) || case
          when v_service = 'redacao' then jsonb_build_object(
            'title', v_title,
            'theme', 'historia guiada',
            'type', 'historia',
            'text', format(
              'Pedro começou uma história sobre um menino na escola. Ele teve uma ideia interessante, mas o começo, o meio e o final ficaram misturados. Na semana %s, tentativa %s, ele contou que algo aconteceu, passou rápido pelo problema e terminou sem explicar bem como tudo se resolveu.',
              v_week,
              v_attempt
            )
          )
          else '{}'::jsonb
        end;

        insert into public.activity_events
          (
            child_id,
            owner_id,
            service,
            activity_type,
            title,
            occurred_at,
            duration_ms,
            metrics,
            feedback,
            artifacts,
            visibility,
            evidence_level,
            created_at
          )
        values
          (
            v_child_id,
            v_owner_id,
            v_service,
            v_activity_type,
            v_title,
            v_event_at,
            v_duration,
            v_metrics,
            v_feedback,
            v_artifacts,
            'adult',
            'pedagogical',
            v_event_at
          );
      end loop;
    end loop;
  end loop;

  raise notice 'Massa demo criada para Pedro Antonio: 32 eventos em 4 semanas. Redacao sem evolucao clara.';
end $$;

-- Conferencia: deve retornar 8 eventos por semana e 8 eventos por modulo.
select
  artifacts ->> 'week' as semana,
  service as modulo,
  count(*) as atividades,
  min(occurred_at)::date as primeira_data,
  max(occurred_at)::date as ultima_data,
  round(avg(coalesce((metrics ->> 'accuracy')::numeric, (metrics ->> 'structure_score')::numeric)), 2) as media_indicador
from public.activity_events
where artifacts ->> 'demo_dataset' = 'pedro_antonio_30_dias'
group by artifacts ->> 'week', service
order by (artifacts ->> 'week')::int, service;

-- Conferencia especifica da redacao: a estrutura deve ficar quase parada.
select
  occurred_at::date as data,
  title,
  metrics ->> 'structure_score' as estrutura,
  feedback #>> '{adult,summary}' as resumo_adulto
from public.activity_events
where artifacts ->> 'demo_dataset' = 'pedro_antonio_30_dias'
  and service = 'redacao'
order by occurred_at;
