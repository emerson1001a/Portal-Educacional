-- Massa de teste longitudinal para Pedro dos Santos.
--
-- Cria 24 redacoes simuladas:
-- - 6 meses;
-- - 4 redacoes por mes;
-- - evolucao gradual em estrutura, tamanho e fechamento do texto;
-- - feedback sempre positivo para a crianca e pratico para o adulto.
--
-- Seguro para rodar mais de uma vez:
-- antes de inserir, apaga apenas eventos demo marcados com:
-- artifacts.demo_dataset = "pedro_dos_santos_6_meses_redacao"
--
-- Use apenas para aluno de teste.

do $$
declare
  v_child_id uuid;
  v_owner_id uuid;
  v_month integer;
  v_item integer;
  v_idx integer;
  v_month_start date;
  v_event_day integer;
  v_event_at timestamptz;
  v_structure numeric;
  v_word_count integer;
  v_steps_completed integer;
  v_title text;
  v_theme text;
  v_text text;
  v_child_message text;
  v_adult_summary text;
  v_attention text[];
  v_recipe text[];
begin
  select c.id
    into v_child_id
    from public.children c
   where lower(c.full_name) like '%pedro%'
     and lower(c.full_name) like '%santos%'
   order by c.created_at desc
   limit 1;

  if v_child_id is null then
    raise exception 'Crianca Pedro dos Santos nao encontrada.';
  end if;

  select cg.guardian_id
    into v_owner_id
    from public.child_guardians cg
   where cg.child_id = v_child_id
   order by cg.created_at asc
   limit 1;

  if v_owner_id is null then
    select c.created_by
      into v_owner_id
      from public.children c
     where c.id = v_child_id;
  end if;

  if v_owner_id is null then
    raise exception 'Pedro dos Santos nao tem adulto responsavel vinculado.';
  end if;

  delete from public.activity_events
   where child_id = v_child_id
     and artifacts ->> 'demo_dataset' = 'pedro_dos_santos_6_meses_redacao';

  for v_month in 1..6 loop
    v_month_start := (date_trunc('month', current_date)::date - make_interval(months => 6 - v_month))::date;

    for v_item in 1..4 loop
      v_idx := ((v_month - 1) * 4) + v_item;
      v_event_day := case v_item when 1 then 3 when 2 then 8 when 3 then 13 else 18 end;
      v_event_at := (v_month_start + (v_event_day - 1)) + make_interval(hours => 16, mins => v_item * 7);

      v_structure := round((0.40 + (v_idx * 0.0175))::numeric, 2);
      v_word_count := 48 + (v_idx * 4) + case when v_item in (2, 4) then 3 else 0 end;
      v_steps_completed := case
        when v_idx <= 4 then 3
        when v_idx <= 10 then 4
        when v_idx <= 17 then 5
        else 6
      end;

      v_theme := case
        when v_idx <= 4 then 'amizade'
        when v_idx <= 8 then 'aventura na escola'
        when v_idx <= 12 then 'familia e rotina'
        when v_idx <= 16 then 'coragem'
        when v_idx <= 20 then 'descoberta'
        else 'superacao'
      end;

      v_title := case v_idx
        when 1 then 'O recreio confuso'
        when 2 then 'A bola perdida'
        when 3 then 'O colega novo'
        when 4 then 'A brincadeira no patio'
        when 5 then 'O mapa da escola'
        when 6 then 'A porta misteriosa'
        when 7 then 'O aviso no mural'
        when 8 then 'A turma investigadora'
        when 9 then 'O domingo em casa'
        when 10 then 'A visita da avo'
        when 11 then 'O bolo de aniversario'
        when 12 then 'A manha diferente'
        when 13 then 'O medo da apresentacao'
        when 14 then 'A primeira tentativa'
        when 15 then 'O amigo que ajudou'
        when 16 then 'A escolha corajosa'
        when 17 then 'A caixa de lembrancas'
        when 18 then 'O jardim escondido'
        when 19 then 'O bilhete antigo'
        when 20 then 'A pista no livro'
        when 21 then 'O desafio do grupo'
        when 22 then 'A ponte do parque'
        when 23 then 'O plano que deu certo'
        else 'A conquista de Pedro'
      end;

      v_text := case
        when v_idx <= 4 then
          format(
            'Pedro estava no recreio e teve uma ideia para brincar com os colegas. No comeco, ele contou quem estava la, mas ainda misturou um pouco o lugar e o que aconteceu depois. Mesmo assim, a historia mostrou uma ideia propria: a turma queria resolver um pequeno problema antes de voltar para a sala. No final, Pedro tentou terminar dizendo que todos ficaram bem, mas ainda faltou explicar melhor como a situacao se resolveu. Esta redacao mostra inicio de autoria e precisa de ajuda para separar comeco, meio e fim.'
          )
        when v_idx <= 8 then
          format(
            'Na escola de Pedro, a turma encontrou uma pista perto da biblioteca. No comeco, Pedro explicou melhor onde a cena acontecia e quem participava. Depois, contou que os amigos seguiram a pista e descobriram que ela levava ao patio. O meio ainda ficou um pouco rapido, mas ja apareceu um problema mais claro: eles precisavam decidir se chamavam a professora ou continuavam investigando. No final, Pedro escreveu que a turma contou tudo para a professora e aprendeu a trabalhar em grupo.'
          )
        when v_idx <= 12 then
          format(
            'Pedro acordou cedo em um domingo e percebeu que a familia preparava uma surpresa. Primeiro, ele mostrou a casa, a mae na cozinha e o irmao arrumando a mesa. No meio da historia, Pedro contou que quase estragou a surpresa quando perguntou em voz alta para quem era o bolo. A familia riu, explicou que era para a avo e pediu ajuda para terminar a decoracao. No final, a avo chegou feliz, todos cantaram parabens e Pedro percebeu que participar da preparacao tambem era uma forma de demonstrar carinho.'
          )
        when v_idx <= 16 then
          format(
            'Pedro precisava apresentar um trabalho para a turma e ficou inseguro. No comeco, ele explicou que estava com as maos frias e que tinha medo de esquecer as palavras. No meio, um amigo o ajudou a separar a fala em tres partes: apresentar o tema, contar o exemplo e agradecer. Pedro treinou no intervalo e conseguiu lembrar da primeira frase. No final, ele apresentou com calma, errou uma palavra, respirou e continuou. A turma bateu palmas, e Pedro entendeu que coragem nao e nao sentir medo, mas tentar mesmo assim.'
          )
        when v_idx <= 20 then
          format(
            'Durante uma atividade de leitura, Pedro encontrou um bilhete antigo dentro de um livro da biblioteca. No comeco, ele descreveu o livro, a mesa onde estava sentado e a curiosidade que sentiu. No meio, mostrou melhor a sequencia dos acontecimentos: chamou dois colegas, leu o bilhete e descobriu que era uma mensagem deixada por alunos antigos sobre cuidar dos livros. A turma decidiu criar novos bilhetes para os proximos leitores. No final, Pedro escreveu sua propria mensagem e ficou orgulhoso por participar de uma corrente de cuidado.'
          )
        else
          format(
            'Pedro e seu grupo receberam um desafio: construir uma ponte pequena com palitos para uma feira da escola. No comeco, Pedro apresentou o grupo, o material e a dificuldade principal, que era fazer a ponte ficar em pe. No meio, contou que a primeira tentativa caiu, mas eles observaram o erro e decidiram reforcar a base. Pedro sugeriu dividir as tarefas, e cada colega ajudou em uma parte. No final, a ponte ficou firme o suficiente para a apresentacao. Pedro percebeu que melhorar aos poucos tambem e uma conquista, porque cada tentativa ensinou uma parte do caminho.'
          )
      end;

      v_child_message := case
        when v_idx <= 4 then 'Voce colocou uma ideia propria no texto. Agora vamos organizar uma parte por vez.'
        when v_idx <= 8 then 'Seu comeco ficou mais claro. O proximo passo e contar melhor o que acontece no meio.'
        when v_idx <= 12 then 'Sua historia ja tem mais sequencia. Continue mostrando o que acontece primeiro, depois e no final.'
        when v_idx <= 16 then 'Hoje apareceu uma historia mais completa. Voce esta usando melhor comeco, meio e fim.'
        when v_idx <= 20 then 'Seu texto ficou mais organizado e com mais detalhes. Bom trabalho.'
        else 'Sua redacao mostrou progresso real: ideia, sequencia e final ficaram mais claros.'
      end;

      v_adult_summary := case
        when v_idx <= 4 then 'Pedro apresenta ideias proprias, mas ainda precisa de apoio forte para separar comeco, meio e fim. O melhor caminho e manter a tarefa curta e pedir apenas uma organizacao por vez.'
        when v_idx <= 8 then 'Ha melhora inicial na abertura do texto. O comeco aparece com mais clareza, enquanto o desenvolvimento ainda precisa de perguntas-guia.'
        when v_idx <= 12 then 'A sequencia narrativa esta ficando mais visivel. Pedro ja consegue sustentar a historia por mais tempo, ainda com apoio para fechar melhor o final.'
        when v_idx <= 16 then 'A estrutura de comeco, meio e fim aparece com mais consistencia. O foco agora pode ser fortalecer o problema e a solucao sem aumentar a carga.'
        when v_idx <= 20 then 'Pedro mostra evolucao gradual em organizacao textual e detalhamento. Vale manter revisao curta, escolhendo apenas um ponto de melhora por redacao.'
        else 'Pedro apresenta progresso longitudinal consistente em redacao. A orientacao pode migrar para refinamento de frases e vocabulario, preservando a confianca construida.'
      end;

      v_attention := case
        when v_idx <= 4 then array['Separar onde a historia comeca', 'Evitar pedir a redacao inteira de novo', 'Fechar o final com uma frase simples']
        when v_idx <= 8 then array['Desenvolver o meio com uma pergunta-guia', 'Evitar muitas correcoes ao mesmo tempo']
        when v_idx <= 12 then array['Melhorar a transicao entre meio e final', 'Manter apoio leve na revisao']
        when v_idx <= 16 then array['Fortalecer o problema central', 'Consolidar a solucao no final']
        when v_idx <= 20 then array['Refinar vocabulario aos poucos', 'Preservar autoria da crianca']
        else array['Aumentar a exigencia apenas de forma gradual', 'Trabalhar uma frase por revisao']
      end;

      v_recipe := case
        when v_idx <= 4 then array['Pergunte: onde a historia comeca?', 'Peca uma frase para explicar o que aconteceu.', 'Elogie a ideia antes de sugerir ajuste.']
        when v_idx <= 8 then array['Pergunte: qual foi o problema principal?', 'Peca uma frase a mais para o meio.', 'Nao reescreva pela crianca.']
        when v_idx <= 12 then array['Leia com ele a sequencia: primeiro, depois, no final.', 'Escolha apenas um ponto de revisao.', 'Celebre quando ele fechar a historia.']
        when v_idx <= 16 then array['Mantenha o roteiro fixo de comeco, meio e fim.', 'Depois da escrita, revise uma unica frase.', 'Mostre o progresso comparando com textos anteriores.']
        when v_idx <= 20 then array['Peça que ele escolha uma frase para melhorar.', 'Sugira uma palavra mais precisa.', 'Preserve a ideia original.']
        else array['Trabalhe refinamento sem aumentar demais o tamanho.', 'Compare o texto atual com um texto antigo para mostrar evolucao.', 'Mantenha feedback positivo e uma meta pequena.']
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
          created_at
        )
      values
        (
          v_child_id,
          v_owner_id,
          'redacao',
          'guided_writing',
          format('Redacao %s: %s', v_idx, v_title),
          v_event_at,
          (14 + v_month + v_item) * 60 * 1000,
          jsonb_build_object(
            'schema_version', '1.0',
            'module_version', 'redacao-demo-longitudinal-1.0',
            'month_index', v_month,
            'attempt_in_month', v_item,
            'sequence', v_idx,
            'steps_total', 6,
            'steps_completed', v_steps_completed,
            'revision_rounds', 1,
            'word_count', v_word_count,
            'structure_score', v_structure,
            'beginning_middle_end', case
              when v_idx <= 4 then 'inicial'
              when v_idx <= 10 then 'em_formacao'
              when v_idx <= 17 then 'mais_consistente'
              else 'consistente'
            end,
            'adult_support_level', case
              when v_idx <= 4 then 'alto'
              when v_idx <= 12 then 'medio'
              else 'baixo'
            end
          ),
          jsonb_build_object(
            'child', jsonb_build_object(
              'tone', 'positive',
              'message', v_child_message,
              'next_step', case
                when v_idx <= 8 then 'Na proxima, vamos cuidar de uma parte pequena.'
                when v_idx <= 16 then 'Na proxima, vamos deixar uma parte ainda mais clara.'
                else 'Na proxima, vamos melhorar uma frase sem mexer no texto todo.'
              end
            ),
            'adult', jsonb_build_object(
              'summary', v_adult_summary,
              'strengths', case
                when v_idx <= 4 then jsonb_build_array('Tem ideias proprias', 'Aceita iniciar a escrita')
                when v_idx <= 8 then jsonb_build_array('Comeco mais claro', 'Mantem participacao')
                when v_idx <= 12 then jsonb_build_array('Sequencia mais visivel', 'Mais detalhes')
                when v_idx <= 16 then jsonb_build_array('Estrutura em consolidacao', 'Melhor desenvolvimento')
                when v_idx <= 20 then jsonb_build_array('Mais organizacao', 'Texto mais completo')
                else jsonb_build_array('Progresso consistente', 'Final mais claro', 'Aceita revisao curta')
              end,
              'attention_points', to_jsonb(v_attention),
              'recipe', to_jsonb(v_recipe),
              'avoid_saying', jsonb_build_array(
                'Sua redacao esta ruim.',
                'Voce nao evoluiu.',
                'Vamos refazer tudo.'
              )
            )
          ),
          jsonb_build_object(
            'demo_dataset', 'pedro_dos_santos_6_meses_redacao',
            'demo', true,
            'sequence', v_idx,
            'month_index', v_month,
            'attempt_in_month', v_item,
            'theme', v_theme,
            'title', v_title,
            'type', 'historia',
            'text', v_text,
            'draft_parts', jsonb_build_object(
              'beginning', case
                when v_idx <= 4 then 'Inicio com ideia, ainda pouco separado.'
                when v_idx <= 12 then 'Inicio mais claro, com personagem e lugar.'
                else 'Inicio com personagem, lugar e situacao definidos.'
              end,
              'middle', case
                when v_idx <= 8 then 'Meio ainda rapido.'
                when v_idx <= 16 then 'Meio com problema mais visivel.'
                else 'Meio com problema e tentativa de solucao.'
              end,
              'ending', case
                when v_idx <= 10 then 'Final simples e ainda curto.'
                when v_idx <= 18 then 'Final mais compreensivel.'
                else 'Final conectado ao problema da historia.'
              end
            )
          ),
          v_event_at
        );
    end loop;
  end loop;

  raise notice 'Massa demo criada para Pedro dos Santos: 24 redacoes em 6 meses, com evolucao gradual.';
end $$;

-- Conferencia geral: deve retornar 4 redacoes por mes.
select
  artifacts ->> 'month_index' as mes_demo,
  count(*) as redacoes,
  min(occurred_at)::date as primeira_data,
  max(occurred_at)::date as ultima_data,
  round(avg((metrics ->> 'structure_score')::numeric), 2) as estrutura_media,
  round(avg((metrics ->> 'word_count')::numeric), 0) as palavras_media
from public.activity_events
where artifacts ->> 'demo_dataset' = 'pedro_dos_santos_6_meses_redacao'
group by artifacts ->> 'month_index'
order by (artifacts ->> 'month_index')::int;

-- Conferencia detalhada da curva de evolucao.
select
  occurred_at::date as data,
  title,
  metrics ->> 'structure_score' as estrutura,
  metrics ->> 'word_count' as palavras,
  feedback #>> '{adult,summary}' as resumo_adulto
from public.activity_events
where artifacts ->> 'demo_dataset' = 'pedro_dos_santos_6_meses_redacao'
order by occurred_at;
