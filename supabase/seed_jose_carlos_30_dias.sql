-- Massa de teste longitudinal para Jose Carlos.
--
-- Cria 32 evidencias simuladas nos ultimos 30 dias:
-- - 4 semanas;
-- - 2 atividades por modulo em cada semana;
-- - modulos: interpretacao, redacao, tabuada e ingles;
-- - perfil evolutivo gradual, para testar a analise longitudinal.
--
-- Seguro para rodar mais de uma vez:
-- antes de inserir, apaga apenas eventos demo marcados com:
-- artifacts.demo_dataset = "jose_carlos_30_dias"

do $$
declare
  v_child_id uuid;
  v_owner_id uuid;
begin
  select c.id
    into v_child_id
    from public.children c
   where lower(c.full_name) like '%carlos%'
     and (
       lower(c.full_name) like 'jose%'
       or lower(c.full_name) like 'josé%'
     )
   order by c.created_at desc
   limit 1;

  if v_child_id is null then
    raise exception 'Crianca Jose Carlos nao encontrada.';
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
    raise exception 'Jose Carlos nao tem adulto responsavel vinculado.';
  end if;

  delete from public.activity_events
   where child_id = v_child_id
     and artifacts ->> 'demo_dataset' = 'jose_carlos_30_dias';

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
  select
    v_child_id,
    v_owner_id,
    item.service,
    item.activity_type,
    item.title,
    item.event_at,
    item.duration_ms,
    item.metrics,
    item.feedback,
    item.artifacts,
    'adult',
    'pedagogical',
    item.event_at
  from (
    values
      -- Semana 1, mais antiga: inicio com mais apoio e acerto menor.
      ('interpretacao','reading_comprehension','Leitura 1: aventura no quintal', now() - interval '29 days', 8*60*1000,
        '{"week":1,"attempt":1,"questions_total":4,"questions_correct":2,"accuracy":0.50,"reading_seconds":230,"complexity":"curto","support_level":"alto"}'::jsonb,
        '{"child":{"tone":"positive","message":"Voce leu ate o fim e tentou responder com calma.","next_step":"Na proxima leitura, procure uma pista no texto."},"adult":{"summary":"Inicio com participacao, ainda precisando voltar ao texto antes de responder.","strengths":["Terminou a atividade","Aceitou tentar"],"attention_points":["Voltar ao texto","Separar detalhe importante"],"recipe":["Pergunte: onde esta a pista?","Elogie a tentativa antes de corrigir."],"avoid_saying":["Voce nao prestou atencao."]}}'::jsonb,
        '{"demo_dataset":"jose_carlos_30_dias","demo":true,"week":1,"attempt":1}'::jsonb),
      ('interpretacao','reading_comprehension','Leitura 2: escolha no recreio', now() - interval '26 days', 8*60*1000,
        '{"week":1,"attempt":2,"questions_total":4,"questions_correct":2,"accuracy":0.55,"reading_seconds":220,"complexity":"curto","support_level":"alto"}'::jsonb,
        '{"child":{"tone":"positive","message":"Voce encontrou algumas respostas importantes.","next_step":"Vamos treinar achar a frase que ajuda."},"adult":{"summary":"Ainda em formacao, com pequena melhora na localizacao de informacoes.","strengths":["Manteve a leitura","Tentou justificar"],"attention_points":["Justificar a escolha"],"recipe":["Peça: mostre a frase que ajudou.","Uma pergunta boa vale mais que muitas."],"avoid_saying":["Voce chutou."]}}'::jsonb,
        '{"demo_dataset":"jose_carlos_30_dias","demo":true,"week":1,"attempt":2}'::jsonb),
      ('redacao','guided_writing','Redacao 1: o mapa perdido', now() - interval '28 days', 16*60*1000,
        '{"week":1,"attempt":1,"steps_total":6,"steps_completed":4,"revision_rounds":1,"word_count":72,"structure_score":0.52}'::jsonb,
        '{"child":{"tone":"positive","message":"Sua ideia apareceu. Agora vamos organizar em começo, meio e fim.","next_step":"Comece contando onde tudo acontece."},"adult":{"summary":"Ideia presente, estrutura ainda inicial. Melhor reforcar metodo sem reescrever pela crianca.","strengths":["Criou uma ideia propria"],"attention_points":["Inicio curto","Final pouco fechado"],"recipe":["Pergunte: onde começou? o que mudou? como terminou?","Corrija uma coisa por vez."],"avoid_saying":["Esta confuso."]}}'::jsonb,
        '{"demo_dataset":"jose_carlos_30_dias","demo":true,"week":1,"attempt":1,"text":"Um menino achou um mapa e procurou um tesouro no quintal."}'::jsonb),
      ('redacao','guided_writing','Redacao 2: o recreio diferente', now() - interval '25 days', 17*60*1000,
        '{"week":1,"attempt":2,"steps_total":6,"steps_completed":4,"revision_rounds":1,"word_count":80,"structure_score":0.56}'::jsonb,
        '{"child":{"tone":"positive","message":"Voce colocou mais detalhes no começo.","next_step":"Agora vamos contar melhor o que aconteceu no meio."},"adult":{"summary":"Pequeno ganho no inicio, com meio ainda rapido demais.","strengths":["Comeco um pouco mais claro"],"attention_points":["Desenvolver o problema"],"recipe":["Peça uma frase a mais para o meio.","Preserve a ideia original."],"avoid_saying":["Falta muita coisa."]}}'::jsonb,
        '{"demo_dataset":"jose_carlos_30_dias","demo":true,"week":1,"attempt":2,"text":"No recreio, a turma encontrou uma caixa misteriosa perto da quadra."}'::jsonb),
      ('tabuada','treino_finalizado','Tabuada 1: do 2', now() - interval '27 days', 5*60*1000,
        '{"week":1,"attempt":1,"total_attempts":12,"correct_attempts":8,"accuracy":0.67,"median_seconds":3.8,"target_attempts":12,"tabs":[2],"completed":true}'::jsonb,
        '{"child":{"tone":"positive","message":"Voce completou a missao da tabuada do 2.","next_step":"Repetir em outro dia ajuda a ficar automatico."},"adult":{"summary":"Boa entrada em matematica, com dose curta e persistencia.","strengths":["Concluiu a meta"],"attention_points":["Velocidade irregular"],"recipe":["Poucos itens e fim claro.","Celebrar a conclusao."],"avoid_saying":["Isso e facil demais."]}}'::jsonb,
        '{"demo_dataset":"jose_carlos_30_dias","demo":true,"week":1,"attempt":1,"tabs":[2]}'::jsonb),
      ('tabuada','treino_finalizado','Tabuada 2: do 2 e 3', now() - interval '24 days', 6*60*1000,
        '{"week":1,"attempt":2,"total_attempts":12,"correct_attempts":9,"accuracy":0.72,"median_seconds":3.5,"target_attempts":12,"tabs":[2,3],"completed":true}'::jsonb,
        '{"child":{"tone":"positive","message":"Voce acertou mais respostas do que no treino anterior.","next_step":"Vamos manter repeticao leve."},"adult":{"summary":"Melhora inicial com pequena variacao de tabuadas.","strengths":["Mais acertos"],"attention_points":["Tabuada do 3 ainda oscila"],"recipe":["Misture pouco, sem alongar.","Encerrar ao bater a meta."],"avoid_saying":["Demorou demais."]}}'::jsonb,
        '{"demo_dataset":"jose_carlos_30_dias","demo":true,"week":1,"attempt":2,"tabs":[2,3]}'::jsonb),
      ('ingles','grammar_practice','Ingles 1: verb to be', now() - interval '28 days', 6*60*1000,
        '{"week":1,"attempt":1,"skill":"verb_to_be","support_level":"high","items_total":10,"correct":5,"accuracy":0.50,"common_errors":["they_am","you_is"]}'::jsonb,
        '{"child":{"tone":"positive","message":"Voce comecou a reconhecer am, is e are.","next_step":"Vamos treinar: I am, you are, they are."},"adult":{"summary":"Duvida esperada no verbo to be. Precisa de exemplos curtos e repetidos.","strengths":["Tentou mesmo errando"],"attention_points":["They combina com are"],"recipe":["Diga: quase. They combina com are.","Poucos exemplos por vez."],"avoid_saying":["Voce ja deveria saber."]}}'::jsonb,
        '{"demo_dataset":"jose_carlos_30_dias","demo":true,"week":1,"attempt":1,"english_skill":"verb_to_be"}'::jsonb),
      ('ingles','grammar_practice','Ingles 2: verb to be', now() - interval '23 days', 6*60*1000,
        '{"week":1,"attempt":2,"skill":"verb_to_be","support_level":"high","items_total":10,"correct":6,"accuracy":0.60,"common_errors":["you_is"]}'::jsonb,
        '{"child":{"tone":"positive","message":"Hoje voce reconheceu mais frases corretas.","next_step":"Continuar com you are e they are."},"adult":{"summary":"Pequena melhora no mesmo conteudo, ainda com apoio alto.","strengths":["Mais reconhecimento"],"attention_points":["You are"],"recipe":["Repetir padroes simples.","Nao explicar demais."],"avoid_saying":["Voce sempre erra isso."]}}'::jsonb,
        '{"demo_dataset":"jose_carlos_30_dias","demo":true,"week":1,"attempt":2,"english_skill":"verb_to_be"}'::jsonb),

      -- Semana 2: mais consistencia, apoio ainda presente.
      ('interpretacao','reading_comprehension','Leitura 3: o clube dos curiosos', now() - interval '21 days', 9*60*1000,
        '{"week":2,"attempt":1,"questions_total":5,"questions_correct":3,"accuracy":0.65,"reading_seconds":250,"complexity":"medio","support_level":"medio"}'::jsonb,
        '{"child":{"tone":"positive","message":"Voce leu um texto um pouco maior e continuou tentando.","next_step":"Procure o comeco, o problema e a solucao."},"adult":{"summary":"Aumento de complexidade com manutencao de engajamento.","strengths":["Sustentou texto maior"],"attention_points":["Inferencia ainda precisa de guia"],"recipe":["Pergunte: o que estava escondido na historia?","Escolha uma pergunta boa."],"avoid_saying":["Voce nao entendeu nada."]}}'::jsonb,
        '{"demo_dataset":"jose_carlos_30_dias","demo":true,"week":2,"attempt":1}'::jsonb),
      ('interpretacao','reading_comprehension','Leitura 4: a decisao do grupo', now() - interval '18 days', 9*60*1000,
        '{"week":2,"attempt":2,"questions_total":5,"questions_correct":4,"accuracy":0.75,"reading_seconds":235,"complexity":"medio","support_level":"medio"}'::jsonb,
        '{"child":{"tone":"positive","message":"Voce encontrou mais pistas no texto.","next_step":"Explique qual frase te ajudou."},"adult":{"summary":"Melhora clara na compreensao literal e inicio de justificativa.","strengths":["Localizou informacoes principais"],"attention_points":["Justificativa ainda curta"],"recipe":["Pergunte: que pedaco do texto ajudou?","Elogie quando apontar a pista."],"avoid_saying":["Chutou de novo."]}}'::jsonb,
        '{"demo_dataset":"jose_carlos_30_dias","demo":true,"week":2,"attempt":2}'::jsonb),
      ('redacao','guided_writing','Redacao 3: a ponte da escola', now() - interval '20 days', 18*60*1000,
        '{"week":2,"attempt":1,"steps_total":6,"steps_completed":5,"revision_rounds":1,"word_count":92,"structure_score":0.64}'::jsonb,
        '{"child":{"tone":"positive","message":"O começo ficou mais claro desta vez.","next_step":"Agora vamos fortalecer o meio."},"adult":{"summary":"Evolucao na abertura da historia. O foco agora e desenvolver o conflito.","strengths":["Comeco mais claro"],"attention_points":["Meio passa rapido"],"recipe":["Pergunte: qual foi o problema principal?","Peça uma frase a mais no meio."],"avoid_saying":["Falta muita coisa."]}}'::jsonb,
        '{"demo_dataset":"jose_carlos_30_dias","demo":true,"week":2,"attempt":1,"text":"Na escola havia uma ponte pequena perto do jardim. Um dia ela quebrou."}'::jsonb),
      ('redacao','guided_writing','Redacao 4: o campeonato surpresa', now() - interval '17 days', 18*60*1000,
        '{"week":2,"attempt":2,"steps_total":6,"steps_completed":5,"revision_rounds":1,"word_count":104,"structure_score":0.69}'::jsonb,
        '{"child":{"tone":"positive","message":"Sua historia teve mais meio e ficou mais facil de acompanhar.","next_step":"Vamos fechar melhor o final."},"adult":{"summary":"Ganho no desenvolvimento do meio, com final ainda a refinar.","strengths":["Mais detalhes no meio"],"attention_points":["Final pode fechar melhor"],"recipe":["Peça uma frase final: o que ele aprendeu?","Nao reescreva o texto."],"avoid_saying":["Agora refaz tudo."]}}'::jsonb,
        '{"demo_dataset":"jose_carlos_30_dias","demo":true,"week":2,"attempt":2,"text":"A turma descobriu um campeonato surpresa e treinou no recreio."}'::jsonb),
      ('tabuada','treino_finalizado','Tabuada 3: do 3', now() - interval '20 days', 6*60*1000,
        '{"week":2,"attempt":1,"total_attempts":14,"correct_attempts":11,"accuracy":0.79,"median_seconds":3.1,"target_attempts":14,"tabs":[3],"completed":true}'::jsonb,
        '{"child":{"tone":"positive","message":"Voce acertou mais e completou a missao.","next_step":"Repetir com calma vai deixando mais rapido."},"adult":{"summary":"Acuracia melhorou com dose curta.","strengths":["Mais acertos"],"attention_points":["Velocidade ainda varia"],"recipe":["Manter 10 a 15 tentativas.","Parar no combinado."],"avoid_saying":["Agora tem que ser rapido."]}}'::jsonb,
        '{"demo_dataset":"jose_carlos_30_dias","demo":true,"week":2,"attempt":1,"tabs":[3]}'::jsonb),
      ('tabuada','treino_finalizado','Tabuada 4: do 3 e 4', now() - interval '16 days', 7*60*1000,
        '{"week":2,"attempt":2,"total_attempts":14,"correct_attempts":12,"accuracy":0.83,"median_seconds":2.9,"target_attempts":14,"tabs":[3,4],"completed":true}'::jsonb,
        '{"child":{"tone":"positive","message":"Voce misturou tabuadas e continuou acertando bastante.","next_step":"Vamos manter assim, sem pressa."},"adult":{"summary":"Boa resposta a pequena mistura de fatos.","strengths":["Acuracia consistente"],"attention_points":["Erros pontuais no 4"],"recipe":["Misturar pouco.","Celebrar a meta batida."],"avoid_saying":["Precisa ser perfeito."]}}'::jsonb,
        '{"demo_dataset":"jose_carlos_30_dias","demo":true,"week":2,"attempt":2,"tabs":[3,4]}'::jsonb),
      ('ingles','grammar_practice','Ingles 3: simple present', now() - interval '19 days', 7*60*1000,
        '{"week":2,"attempt":1,"skill":"simple_present","support_level":"high","items_total":10,"correct":6,"accuracy":0.60,"common_errors":["he_play","she_cook"]}'::jsonb,
        '{"child":{"tone":"positive","message":"Voce entendeu varias frases. Agora falta lembrar do s com he e she.","next_step":"Treinar: he plays, she cooks."},"adult":{"summary":"Erro esperado: esquecimento do s na terceira pessoa.","strengths":["Entendeu parte do sentido"],"attention_points":["He/she + verbo com s"],"recipe":["Diga: com he ou she, o verbo ganha s.","Use poucos exemplos."],"avoid_saying":["Voce sempre esquece."]}}'::jsonb,
        '{"demo_dataset":"jose_carlos_30_dias","demo":true,"week":2,"attempt":1,"english_skill":"simple_present"}'::jsonb),
      ('ingles','grammar_practice','Ingles 4: simple present', now() - interval '15 days', 7*60*1000,
        '{"week":2,"attempt":2,"skill":"simple_present","support_level":"medium","items_total":10,"correct":7,"accuracy":0.70,"common_errors":["he_play"]}'::jsonb,
        '{"child":{"tone":"positive","message":"Voce lembrou mais vezes do s em he e she.","next_step":"Continuar praticando com frases curtas."},"adult":{"summary":"Melhora no simple present com apoio medio.","strengths":["Mais acertos com he/she"],"attention_points":["Ainda esquecer o s em alguns casos"],"recipe":["Repetir o padrao em voz baixa.","Elogiar quando ele se autocorrigir."],"avoid_saying":["Era so colocar s."]}}'::jsonb,
        '{"demo_dataset":"jose_carlos_30_dias","demo":true,"week":2,"attempt":2,"english_skill":"simple_present"}'::jsonb),

      -- Semana 3: mais autonomia.
      ('interpretacao','reading_comprehension','Leitura 5: o grupo da biblioteca', now() - interval '14 days', 9*60*1000,
        '{"week":3,"attempt":1,"questions_total":5,"questions_correct":4,"accuracy":0.80,"reading_seconds":225,"complexity":"medio","support_level":"medio"}'::jsonb,
        '{"child":{"tone":"positive","message":"Voce respondeu bem um texto medio.","next_step":"Continue explicando a resposta com uma pista."},"adult":{"summary":"Desempenho melhor e mais estavel em leitura media.","strengths":["Boa localizacao de pistas"],"attention_points":["Aprofundar inferencia"],"recipe":["Peça: por que voce acha isso?","Uma justificativa curta basta."],"avoid_saying":["Resposta incompleta."]}}'::jsonb,
        '{"demo_dataset":"jose_carlos_30_dias","demo":true,"week":3,"attempt":1}'::jsonb),
      ('interpretacao','reading_comprehension','Leitura 6: uma escolha dificil', now() - interval '11 days', 10*60*1000,
        '{"week":3,"attempt":2,"questions_total":5,"questions_correct":4,"accuracy":0.82,"reading_seconds":215,"complexity":"medio","support_level":"baixo"}'::jsonb,
        '{"child":{"tone":"positive","message":"Voce manteve o resultado com menos ajuda.","next_step":"Vamos continuar nessa autonomia."},"adult":{"summary":"Sinal importante: manutencao de desempenho com menor apoio.","strengths":["Mais autonomia"],"attention_points":["Justificativa oral ainda curta"],"recipe":["Reforce: voce encontrou sozinho.","Peça uma frase de justificativa."],"avoid_saying":["Agora nao precisa de ajuda."]}}'::jsonb,
        '{"demo_dataset":"jose_carlos_30_dias","demo":true,"week":3,"attempt":2}'::jsonb),
      ('redacao','guided_writing','Redacao 5: a viagem imaginaria', now() - interval '13 days', 19*60*1000,
        '{"week":3,"attempt":1,"steps_total":6,"steps_completed":6,"revision_rounds":1,"word_count":118,"structure_score":0.75}'::jsonb,
        '{"child":{"tone":"positive","message":"Hoje sua redacao teve começo, meio e fim.","next_step":"Na proxima, vamos deixar o final mais bonito."},"adult":{"summary":"Marco positivo: estrutura completa apareceu.","strengths":["Estrutura completa","Mais detalhes"],"attention_points":["Fechamento pode melhorar"],"recipe":["Elogie a estrutura antes do ajuste.","Sugira uma frase final."],"avoid_saying":["Finalmente saiu."]}}'::jsonb,
        '{"demo_dataset":"jose_carlos_30_dias","demo":true,"week":3,"attempt":1,"text":"Jose imaginou uma viagem de barco e contou o problema no caminho."}'::jsonb),
      ('redacao','guided_writing','Redacao 6: o presente perdido', now() - interval '10 days', 20*60*1000,
        '{"week":3,"attempt":2,"steps_total":6,"steps_completed":6,"revision_rounds":1,"word_count":124,"structure_score":0.79}'::jsonb,
        '{"child":{"tone":"positive","message":"Sua historia ficou completa e mais detalhada.","next_step":"Agora podemos escolher palavras melhores."},"adult":{"summary":"Estrutura se manteve; proximo refinamento pode ser vocabulario.","strengths":["Comeco, meio e fim presentes"],"attention_points":["Escolha de palavras"],"recipe":["Escolha uma palavra para melhorar.","Preserve o texto da crianca."],"avoid_saying":["Vamos corrigir tudo."]}}'::jsonb,
        '{"demo_dataset":"jose_carlos_30_dias","demo":true,"week":3,"attempt":2,"text":"A turma procurou um presente perdido e resolveu o problema conversando."}'::jsonb),
      ('tabuada','treino_finalizado','Tabuada 5: mista curta', now() - interval '13 days', 6*60*1000,
        '{"week":3,"attempt":1,"total_attempts":16,"correct_attempts":14,"accuracy":0.86,"median_seconds":2.6,"target_attempts":16,"tabs":[2,3,4],"completed":true}'::jsonb,
        '{"child":{"tone":"positive","message":"Voce fez uma tabuada mista e terminou muito bem.","next_step":"Continuar em doses curtas."},"adult":{"summary":"Acuracia e tempo melhores em treino misto.","strengths":["Acuracia alta","Tempo melhor"],"attention_points":["Cuidar para nao aumentar demais"],"recipe":["Manter 15 a 20 tentativas.","Aumentar so se terminar leve."],"avoid_saying":["Agora vamos dobrar tudo."]}}'::jsonb,
        '{"demo_dataset":"jose_carlos_30_dias","demo":true,"week":3,"attempt":1,"tabs":[2,3,4]}'::jsonb),
      ('tabuada','treino_finalizado','Tabuada 6: do 4 e 5', now() - interval '9 days', 7*60*1000,
        '{"week":3,"attempt":2,"total_attempts":16,"correct_attempts":14,"accuracy":0.88,"median_seconds":2.5,"target_attempts":16,"tabs":[4,5],"completed":true}'::jsonb,
        '{"child":{"tone":"positive","message":"Voce manteve bons acertos mesmo com tabuadas novas.","next_step":"Vamos repetir para ganhar confianca."},"adult":{"summary":"Boa transferencia para novas tabuadas com carga moderada.","strengths":["Manteve acuracia"],"attention_points":["Consolidar antes de ampliar"],"recipe":["Repetir a mesma combinacao.","Nao trocar tudo de uma vez."],"avoid_saying":["Agora ja sabe todas."]}}'::jsonb,
        '{"demo_dataset":"jose_carlos_30_dias","demo":true,"week":3,"attempt":2,"tabs":[4,5]}'::jsonb),
      ('ingles','grammar_practice','Ingles 5: present continuous', now() - interval '12 days', 8*60*1000,
        '{"week":3,"attempt":1,"skill":"present_continuous","support_level":"medium","items_total":10,"correct":7,"accuracy":0.70,"common_errors":["missing_ing"]}'::jsonb,
        '{"child":{"tone":"positive","message":"Voce entendeu que a acao esta acontecendo agora.","next_step":"Treinar: is playing, are running."},"adult":{"summary":"Boa resposta inicial ao present continuous.","strengths":["Reconheceu a ideia de agora"],"attention_points":["Esquece o ing"],"recipe":["Diga: acontecendo agora pede ing.","Use acoes reais."],"avoid_saying":["Isso e basico."]}}'::jsonb,
        '{"demo_dataset":"jose_carlos_30_dias","demo":true,"week":3,"attempt":1,"english_skill":"present_continuous"}'::jsonb),
      ('ingles','grammar_practice','Ingles 6: present continuous', now() - interval '8 days', 8*60*1000,
        '{"week":3,"attempt":2,"skill":"present_continuous","support_level":"medium","items_total":10,"correct":8,"accuracy":0.80,"common_errors":["missing_be"]}'::jsonb,
        '{"child":{"tone":"positive","message":"Voce usou melhor o ing nas frases.","next_step":"Lembrar tambem do am, is ou are."},"adult":{"summary":"Melhora no uso de ing; agora observar auxiliar antes do verbo.","strengths":["Mais acertos com ing"],"attention_points":["Falta am/is/are em alguns casos"],"recipe":["Modelo curto: She is playing.","Treinar uma forma por vez."],"avoid_saying":["Esta quase, mas falta tudo."]}}'::jsonb,
        '{"demo_dataset":"jose_carlos_30_dias","demo":true,"week":3,"attempt":2,"english_skill":"present_continuous"}'::jsonb),

      -- Semana 4, mais recente: progresso consolidando, ainda com orientacao cuidadosa.
      ('interpretacao','reading_comprehension','Leitura 7: a feira de ciencias', now() - interval '7 days', 10*60*1000,
        '{"week":4,"attempt":1,"questions_total":6,"questions_correct":5,"accuracy":0.83,"reading_seconds":230,"complexity":"medio","support_level":"baixo"}'::jsonb,
        '{"child":{"tone":"positive","message":"Voce leu, respondeu e explicou melhor suas escolhas.","next_step":"Continue usando pistas do texto."},"adult":{"summary":"Evidencia de autonomia em leitura com texto medio.","strengths":["Boa autonomia","Mais justificativa"],"attention_points":["Manter constancia"],"recipe":["Reforce a estrategia que funcionou.","Pergunte uma inferencia curta."],"avoid_saying":["Agora sempre tem que acertar."]}}'::jsonb,
        '{"demo_dataset":"jose_carlos_30_dias","demo":true,"week":4,"attempt":1}'::jsonb),
      ('interpretacao','reading_comprehension','Leitura 8: o acordo da turma', now() - interval '3 days', 10*60*1000,
        '{"week":4,"attempt":2,"questions_total":6,"questions_correct":5,"accuracy":0.85,"reading_seconds":220,"complexity":"medio","support_level":"baixo"}'::jsonb,
        '{"child":{"tone":"positive","message":"Voce manteve um bom resultado. Isso mostra crescimento.","next_step":"Na proxima, vamos tentar uma pergunta um pouco mais profunda."},"adult":{"summary":"Leitura com desempenho estavel e menor apoio. Bom sinal longitudinal.","strengths":["Consistencia","Autonomia"],"attention_points":["Aprofundar inferencia"],"recipe":["Comparar com ele: voce percebeu que hoje precisou de menos ajuda?","Celebrar progresso real."],"avoid_saying":["Agora nao pode errar."]}}'::jsonb,
        '{"demo_dataset":"jose_carlos_30_dias","demo":true,"week":4,"attempt":2}'::jsonb),
      ('redacao','guided_writing','Redacao 7: a ilha tranquila', now() - interval '6 days', 20*60*1000,
        '{"week":4,"attempt":1,"steps_total":6,"steps_completed":6,"revision_rounds":1,"word_count":132,"structure_score":0.82}'::jsonb,
        '{"child":{"tone":"positive","message":"Sua historia ficou completa e com mais detalhes.","next_step":"Vamos escolher uma palavra melhor para deixar o texto bonito."},"adult":{"summary":"Escrita com estrutura consolidando. Foco pode migrar para qualidade de linguagem.","strengths":["Estrutura completa","Mais detalhes"],"attention_points":["Vocabulario"],"recipe":["Elogie o metodo antes da palavra.","Troque apenas uma palavra."],"avoid_saying":["Vamos arrumar tudo."]}}'::jsonb,
        '{"demo_dataset":"jose_carlos_30_dias","demo":true,"week":4,"attempt":1,"text":"Jose viajou para uma ilha, enfrentou vento forte e escreveu no diario que aprendeu a nao desistir."}'::jsonb),
      ('redacao','guided_writing','Redacao 8: o jardim secreto', now() - interval '2 days', 21*60*1000,
        '{"week":4,"attempt":2,"steps_total":6,"steps_completed":6,"revision_rounds":1,"word_count":140,"structure_score":0.86}'::jsonb,
        '{"child":{"tone":"positive","message":"Sua redacao teve começo, meio e fim com mais seguranca.","next_step":"Agora o proximo passo e deixar algumas frases mais bonitas."},"adult":{"summary":"Evolucao clara em organizacao textual. A orientacao agora pode ser refinamento pequeno, mantendo confianca.","strengths":["Organizacao mais segura","Texto mais completo","Aceita revisao curta"],"attention_points":["Refinar frases sem excesso"],"recipe":["Mostre o progresso comparando com ele mesmo.","Escolha uma frase para melhorar, nao o texto todo."],"avoid_saying":["Ainda falta muito."]}}'::jsonb,
        '{"demo_dataset":"jose_carlos_30_dias","demo":true,"week":4,"attempt":2,"text":"No jardim secreto, Jose encontrou pistas, resolveu um problema com os amigos e terminou feliz por ter ajudado."}'::jsonb),
      ('tabuada','treino_finalizado','Tabuada 7: mista 2 a 5', now() - interval '6 days', 7*60*1000,
        '{"week":4,"attempt":1,"total_attempts":18,"correct_attempts":16,"accuracy":0.89,"median_seconds":2.4,"target_attempts":18,"tabs":[2,3,4,5],"completed":true}'::jsonb,
        '{"child":{"tone":"positive","message":"Voce fez a tabuada mista e terminou com muitos acertos.","next_step":"Continuar treinando sem pressa."},"adult":{"summary":"Acuracia alta e tempo melhor. Boa consolidacao.","strengths":["Acuracia alta","Tempo estavel"],"attention_points":["Evitar carga excessiva"],"recipe":["Manter dose curta.","So ampliar quando terminar leve."],"avoid_saying":["Agora vamos muito mais dificil."]}}'::jsonb,
        '{"demo_dataset":"jose_carlos_30_dias","demo":true,"week":4,"attempt":1,"tabs":[2,3,4,5]}'::jsonb),
      ('tabuada','treino_finalizado','Tabuada 8: mista 3 a 6', now() - interval '2 days', 8*60*1000,
        '{"week":4,"attempt":2,"total_attempts":20,"correct_attempts":18,"accuracy":0.90,"median_seconds":2.2,"target_attempts":20,"tabs":[3,4,5,6],"completed":true}'::jsonb,
        '{"child":{"tone":"positive","message":"Voce concluiu a meta e mostrou que a repeticao esta funcionando.","next_step":"Vamos continuar com calma e constancia."},"adult":{"summary":"Matematica mostra evolucao forte em acuracia e velocidade, sem necessidade de aumentar pressao.","strengths":["Concluiu a meta","Acuracia alta","Velocidade melhor"],"attention_points":["Preservar motivacao"],"recipe":["Diga que o treino apareceu no resultado.","Manter o formato de missao curta."],"avoid_saying":["Agora voce nao pode errar."]}}'::jsonb,
        '{"demo_dataset":"jose_carlos_30_dias","demo":true,"week":4,"attempt":2,"tabs":[3,4,5,6]}'::jsonb),
      ('ingles','grammar_practice','Ingles 7: question words', now() - interval '5 days', 8*60*1000,
        '{"week":4,"attempt":1,"skill":"question_words","support_level":"medium","items_total":10,"correct":8,"accuracy":0.80,"common_errors":["where_when"]}'::jsonb,
        '{"child":{"tone":"positive","message":"Voce reconheceu melhor what, where e when.","next_step":"Lembrar: where pergunta lugar, when pergunta tempo."},"adult":{"summary":"Bom desempenho em question words com apoio medio.","strengths":["Reconhece palavras principais"],"attention_points":["Diferenciar where e when"],"recipe":["Use exemplos do dia: where is your bag? when is class?","Uma distincao por vez."],"avoid_saying":["Voce confundiu de novo."]}}'::jsonb,
        '{"demo_dataset":"jose_carlos_30_dias","demo":true,"week":4,"attempt":1,"english_skill":"question_words"}'::jsonb),
      ('ingles','grammar_practice','Ingles 8: revisao curta', now() - interval '1 day', 8*60*1000,
        '{"week":4,"attempt":2,"skill":"mixed_review","support_level":"low","items_total":10,"correct":9,"accuracy":0.90,"common_errors":[]}'::jsonb,
        '{"child":{"tone":"positive","message":"Voce fez uma revisao com menos ajuda e foi muito bem.","next_step":"Vamos continuar com pequenas missoes de ingles."},"adult":{"summary":"Evidencia de progresso em ingles: melhor acuracia com menor apoio. Boa hora para manter revisoes curtas.","strengths":["Mais autonomia","Alta acuracia"],"attention_points":["Manter revisao para nao esquecer"],"recipe":["Celebre que ele precisou de menos ajuda.","Planeje uma revisao curta em alguns dias."],"avoid_saying":["Agora ja dominou tudo."]}}'::jsonb,
        '{"demo_dataset":"jose_carlos_30_dias","demo":true,"week":4,"attempt":2,"english_skill":"mixed_review"}'::jsonb)
  ) as item(service, activity_type, title, event_at, duration_ms, metrics, feedback, artifacts);

  raise notice 'Massa demo recriada para Jose Carlos: 32 eventos em 4 semanas.';
end $$;

-- Conferencia: deve retornar 8 eventos por semana.
select
  artifacts ->> 'week' as semana,
  service as modulo,
  count(*) as atividades,
  min(occurred_at)::date as primeira_data,
  max(occurred_at)::date as ultima_data,
  round(avg(coalesce((metrics ->> 'accuracy')::numeric, (metrics ->> 'structure_score')::numeric)), 2) as media_indicador
from public.activity_events
where artifacts ->> 'demo_dataset' = 'jose_carlos_30_dias'
group by artifacts ->> 'week', service
order by (artifacts ->> 'week')::int, service;

-- Conferencia por data, para ver a distribuicao dos ultimos 30 dias.
select
  occurred_at::date as data,
  service as modulo,
  title as atividade,
  metrics ->> 'accuracy' as acerto,
  metrics ->> 'structure_score' as estrutura,
  metrics ->> 'support_level' as apoio,
  feedback #>> '{adult,summary}' as resumo_adulto
from public.activity_events
where artifacts ->> 'demo_dataset' = 'jose_carlos_30_dias'
order by occurred_at;
