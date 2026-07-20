# Contrato de Modulo

Um modulo e qualquer experiencia de aprendizagem plugada ao Portal Educacional.

Este contrato define:

- como o portal abre um modulo;
- como o modulo registra uma evidencia;
- quais campos sao obrigatorios para acompanhamento longitudinal;
- quais campos cada area precisa enviar;
- quais dados nunca devem aparecer para a crianca;
- quando uma evidencia e considerada boa o suficiente para relatorios.

## Principio central

Todo modulo deve gerar uma evidencia pedagogica completa quando a crianca
termina uma atividade.

A evidencia deve permitir responder, no futuro:

```text
O que a crianca fez?
Quando fez?
Qual habilidade foi trabalhada?
Como foi o desempenho?
Que material foi usado ou produzido?
Que feedback a crianca recebeu?
Que orientacao o adulto recebeu?
Essa evidencia veio de uma missao, meta ou atividade livre?
```

Sem essa resposta, o portal nao deve usar a atividade para conclusoes fortes de
analise longitudinal.

## Cadastro do modulo

Cada modulo deve ter cadastro com estes campos:

```json
{
  "id": "interpretacao",
  "name": "Interpretacao de Texto",
  "short_name": "Interpretacao",
  "area": "leitura",
  "description": "Leitura, perguntas e feedback para compreensao.",
  "url": "https://interpretacao-portal.vercel.app",
  "status": "available",
  "accent": "reading",
  "icon": "L"
}
```

Campos recomendados:

- `id`: identificador tecnico estavel;
- `name`: nome completo;
- `short_name`: nome curto para cartoes e botoes;
- `area`: dominio amplo, como `leitura`, `escrita`, `matematica`, `idiomas` ou `organizacao`;
- `description`: descricao curta para adulto;
- `url`: endereco do modulo;
- `status`: `available`, `planned`, `internal` ou `disabled`;
- `journey`: jornada de apoio, como `leitura_e_interpretacao` ou `ingles_inicial`;
- `skills`: habilidades pedagogicas observaveis;
- `commercial_key`: chave futura para habilitacao por modulo, pacote ou plano;
- `accent` e `icon`: apoio visual.

Regra:

O modulo pode ser vendido, habilitado ou escondido no futuro, mas a crianca deve
ver apenas atividades liberadas. A experiencia infantil nao deve exibir bloqueios
comerciais.

## Abertura a partir do portal

O portal pode abrir o modulo com parametros:

```text
?child_id=<uuid>
&child_name=<nome>
&child_birth_date=<yyyy-mm-dd>
&child_age=<numero>
&assignment_id=<uuid>
&assignment_item_id=<uuid>
&portal_return_url=<url>
&portal_child_token=<token>
&portal_event_token=<token>
```

Regras:

- `child_name`, `child_birth_date` e `child_age` sao contexto para UX, nao fonte de permissao;
- permissoes devem vir dos tokens e das APIs do portal;
- o modulo nao deve pedir nome, idade ou id da crianca quando esses dados vierem do portal;
- o botao de retorno deve voltar para `portal_return_url`;
- o modulo deve preservar `assignment_id` e `assignment_item_id` ao registrar a evidencia.

## Registro de evidencia

O modulo deve enviar evidencias para:

```text
POST /api/activity-events
```

Formato base:

```json
{
  "portal_child_token": "token",
  "service": "redacao",
  "activity_type": "guided_writing",
  "title": "Redacao sobre aventura",
  "occurred_at": "2026-07-20T10:00:00.000Z",
  "duration_ms": 480000,
  "assignment_id": "uuid-opcional",
  "assignment_item_id": "uuid-opcional",
  "metrics": {},
  "feedback": {},
  "artifacts": {}
}
```

Campos principais:

- `service`: modulo que gerou a evidencia;
- `activity_type`: tipo de atividade dentro do modulo;
- `title`: titulo humano da evidencia;
- `occurred_at`: momento real da atividade;
- `duration_ms`: duracao total, sem exibir cronometro para a crianca;
- `assignment_id`: missao vinculada, quando existir;
- `assignment_item_id`: item da missao, quando existir;
- `metrics`: indicadores estruturados;
- `feedback`: devolutivas para crianca e adulto;
- `artifacts`: materiais concretos usados ou produzidos.

## Campos comuns obrigatorios em `metrics`

Todo modulo deve enviar, sempre que possivel:

```json
{
  "schema_version": "1.0",
  "module_version": "1.0.0",
  "started_at": "2026-07-20T10:00:00.000Z",
  "finished_at": "2026-07-20T10:08:00.000Z",
  "duration_seconds": 480,
  "completed": true,
  "completion_reason": "finished",
  "support_level": "medium",
  "attempt_number": 1,
  "child_age": 10,
  "input_mode": "typed",
  "mission_context": "assignment"
}
```

Campos:

- `schema_version`: versao deste contrato;
- `module_version`: versao do modulo;
- `started_at`: inicio da atividade;
- `finished_at`: fim da atividade;
- `duration_seconds`: tempo total em segundos;
- `completed`: se a atividade foi concluida;
- `completion_reason`: `finished`, `abandoned`, `returned_to_portal`, `timeout`, `error`;
- `support_level`: `low`, `medium`, `high`, `adult_assisted`, `unknown`;
- `attempt_number`: tentativa dentro daquela atividade, quando aplicavel;
- `child_age`: idade no momento da atividade;
- `input_mode`: `typed`, `voice_dictation`, `paper_ocr`, `multiple_choice`, `mixed`, `unknown`;
- `mission_context`: `assignment`, `free_practice`, `goal_practice`, `demo`.

## Autoavaliacao leve da crianca

Quando houver autoavaliacao opcional, enviar:

```json
{
  "child_self_assessment": "needed_thinking",
  "child_self_assessment_label": "Precisei pensar"
}
```

Valores recomendados:

- `calm`: Foi tranquilo;
- `needed_thinking`: Precisei pensar;
- `try_again`: Quero tentar de novo;
- `liked`: Gostei;
- `easy`: Foi facil;
- `right_level`: Foi na medida;
- `hard_but_done`: Foi dificil, mas consegui;
- `practice_more`: Quero treinar mais esse assunto.

Regras:

- a pergunta deve falar da missao, nao da identidade da crianca;
- a resposta e opcional;
- a resposta nao deve virar julgamento isolado;
- a crianca nao deve ver interpretacoes adultas sobre essa resposta.

## Feedback

Todo modulo deve separar feedback da crianca e feedback do adulto.

```json
{
  "child": {
    "tone": "positive",
    "message": "Voce terminou uma parte importante.",
    "next_step": "Na proxima, vamos cuidar de uma coisa de cada vez."
  },
  "adult": {
    "summary": "A crianca concluiu a atividade e ainda precisa de apoio em organizacao.",
    "strengths": ["manteve a ideia principal"],
    "attention_points": ["precisa organizar melhor a sequencia"],
    "recipe": ["Converse por partes: comeco, meio e fim."],
    "avoid_saying": ["Seu texto esta confuso."]
  }
}
```

Regras:

- feedback da crianca deve ser curto, positivo e adequado para ela;
- feedback adulto pode ser mais completo, mas sem rotular;
- `avoid_saying` deve orientar o adulto sem culpa;
- o modulo fala sobre a atividade pontual;
- o portal fala sobre evolucao ao longo do tempo.

## Artifacts

`artifacts` guarda os materiais concretos da atividade.

Regra:

Se uma evidencia sustenta conclusao longitudinal, o adulto deve conseguir abrir
o material que gerou aquela conclusao.

Exemplos:

- texto produzido;
- texto lido;
- perguntas;
- respostas;
- tabuadas treinadas;
- palavras de Ingles;
- configuracao da missao;
- habilidade trabalhada;
- origem do material;
- versao revisada.

## Contrato especifico: Redacao

### Objetivo

Guardar dados suficientes para analisar organizacao textual ao longo do tempo.

### `metrics` obrigatorios

```json
{
  "writing_type": "story",
  "structure_score": 0.62,
  "beginning_score": 0.7,
  "middle_score": 0.5,
  "ending_score": 0.6,
  "coherence_score": 0.6,
  "revision_done": true,
  "adult_help_level": "low",
  "word_count": 132
}
```

Campos:

- `writing_type`: `story`, `personal_report`, `opinion`, `short_answer`, `english_short_writing`;
- `structure_score`: indicador geral de comeco, meio e fim;
- `beginning_score`: clareza do comeco;
- `middle_score`: desenvolvimento;
- `ending_score`: fechamento;
- `coherence_score`: coerencia entre partes;
- `revision_done`: se houve revisao guiada;
- `adult_help_level`: `none`, `low`, `medium`, `high`, `unknown`;
- `word_count`: tamanho aproximado.

### `artifacts` obrigatorios

```json
{
  "theme": "Aventura",
  "title": "O barco a vela",
  "writing_type_label": "Historia",
  "final_text": "Texto final da crianca...",
  "revised_text": "Texto revisado com pequena melhoria...",
  "draft_parts": {
    "beginning": "Parte escrita no comeco...",
    "middle": "Parte escrita no meio...",
    "ending": "Parte escrita no final..."
  },
  "revision_focus": "clareza do comeco",
  "input_mode": "voice_dictation"
}
```

Regra importante:

Para relatorio adulto, a evidencia de Redacao precisa guardar o texto. Sem texto,
o portal pode registrar participacao, mas nao deve fazer analise forte de
evolucao textual.

## Contrato especifico: Interpretacao

### Objetivo

Guardar dados suficientes para analisar compreensao, acertos, tipo de pergunta
e uso de pistas do texto.

### `metrics` obrigatorios

```json
{
  "questions_total": 5,
  "questions_correct": 4,
  "accuracy": 0.8,
  "reading_seconds": 180,
  "question_seconds": 220,
  "text_complexity": "medium",
  "literal_correct": 2,
  "inference_correct": 1,
  "vocabulary_correct": 1,
  "support_level": "medium"
}
```

Campos:

- `questions_total`: total de perguntas;
- `questions_correct`: perguntas corretas;
- `accuracy`: acerto de 0 a 1;
- `reading_seconds`: tempo de leitura;
- `question_seconds`: tempo nas perguntas;
- `text_complexity`: `short_easy`, `short_medium`, `medium`, `long`, `custom`;
- `literal_correct`: acertos literais;
- `inference_correct`: acertos inferenciais;
- `vocabulary_correct`: acertos de vocabulario;
- `support_level`: apoio necessario.

### `artifacts` obrigatorios

```json
{
  "topic": "Ferias",
  "source_type": "ai_generated",
  "text": "Texto lido pela crianca...",
  "questions": [
    {
      "id": "q1",
      "type": "literal",
      "prompt": "Onde a historia acontece?",
      "expected_answer": "No recreio da escola.",
      "child_answer": "Na escola.",
      "is_correct": true,
      "feedback": "Voce encontrou uma pista importante no texto."
    }
  ]
}
```

Regra importante:

Perguntas precisam ser coerentes com o texto usado. Se o texto e as perguntas
nao forem salvos juntos, nao ha como auditar a qualidade da atividade.

## Contrato especifico: Tabuada

### Objetivo

Guardar dados suficientes para analisar fluencia, repeticao e fatos que precisam
de treino.

### `metrics` obrigatorios

```json
{
  "tables_practiced": [2, 3, 4],
  "total_attempts": 20,
  "correct": 17,
  "incorrect": 3,
  "accuracy": 0.85,
  "median_seconds": 1.8,
  "training_mode": "adaptive",
  "target_attempts": 20,
  "target_reached": true
}
```

Campos:

- `tables_practiced`: tabuadas treinadas;
- `total_attempts`: tentativas totais;
- `correct`: acertos;
- `incorrect`: erros;
- `accuracy`: acerto de 0 a 1;
- `median_seconds`: tempo mediano por resposta;
- `training_mode`: `adaptive`, `fixed`, `review`, `custom`;
- `target_attempts`: meta combinada;
- `target_reached`: se a atividade concluiu a meta.

### `artifacts` obrigatorios

```json
{
  "facts": [
    {
      "factor_a": 3,
      "factor_b": 6,
      "expected": 18,
      "answer": 24,
      "is_correct": false,
      "response_seconds": 2.1
    }
  ],
  "most_missed_facts": ["3x6", "4x8"],
  "most_practiced_tables": [3, 4],
  "mission_summary": "Treino do 2, 3 e 4 com 20 tentativas."
}
```

Regra importante:

A Tabuada deve registrar no portal no fim da atividade, nao a cada bloco de
tentativas, para nao poluir o historico adulto.

## Contrato especifico: Ingles

### Objetivo

Guardar dados suficientes para analisar habilidade especifica de Ingles,
considerando nivel de apoio, erros frequentes e repeticao no tempo.

### `metrics` obrigatorios

```json
{
  "skill": "present_continuous",
  "exercise_type": "multiple_choice",
  "support_mode": "medium",
  "items_total": 10,
  "correct": 7,
  "incorrect": 3,
  "accuracy": 0.7,
  "common_errors": ["they_am", "missing_ing"]
}
```

Campos:

- `skill`: `verb_to_be`, `simple_present`, `present_continuous`, `question_words`, `vocabulary`, `short_writing`;
- `exercise_type`: `gap_fill`, `multiple_choice`, `translation_light`, `sentence_order`, `short_writing`;
- `support_mode`: `high`, `medium`, `low`;
- `items_total`: total de itens;
- `correct`: acertos;
- `incorrect`: erros;
- `accuracy`: acerto de 0 a 1;
- `common_errors`: erros padronizados.

### `artifacts` obrigatorios

```json
{
  "adult_request": "Treinar present continuous.",
  "language_balance": "mixed",
  "items": [
    {
      "prompt": "They ____ playing soccer.",
      "expected_answer": "are",
      "child_answer": "am",
      "is_correct": false,
      "hint_shown": "Quase. They combina com are: They are.",
      "skill": "verb_to_be"
    }
  ],
  "vocabulary_audio_used": false
}
```

Campos:

- `adult_request`: pedido original do adulto, quando existir;
- `language_balance`: `mostly_portuguese`, `mixed`, `mostly_english`;
- `items`: itens trabalhados;
- `hint_shown`: dica mostrada para a crianca;
- `vocabulary_audio_used`: se houve botao de ouvir palavra.

Regra importante:

O modulo de Ingles deve evitar virar curso completo no MVP. Ele deve trabalhar
habilidades especificas indicadas pelo adulto.

## Evidencia suficiente para longitudinal

Uma evidencia e considerada completa quando tem:

- `service`;
- `activity_type`;
- `occurred_at`;
- `duration_ms` ou `metrics.duration_seconds`;
- `metrics.completed`;
- metrica principal da area;
- `feedback.child.message`;
- `feedback.adult.summary`;
- artifacts suficientes para auditoria da area.

Se faltar material concreto, o portal pode mostrar a atividade no Historico
unificado, mas deve reduzir o nivel de confianca da analise.

## Evidencia insuficiente

Exemplos:

- Redacao sem texto;
- Interpretacao sem perguntas e respostas;
- Tabuada sem tabuadas treinadas;
- Ingles sem skill ou itens;
- feedback adulto sem dados;
- atividade sem `occurred_at` confiavel;
- atividade sem indicacao de conclusao.

Texto recomendado para o adulto:

```text
Esta atividade foi registrada, mas ainda nao tem dados suficientes para sustentar uma conclusao longitudinal forte.
```

## Privacidade

O modulo nunca deve retornar para a crianca:

- percepcao adulta original;
- feedback adulto;
- relatorio longitudinal;
- relatorio para pais;
- diagnosticos;
- comparacoes com outras criancas;
- classificacoes internas de risco.

O modulo pode mostrar para a crianca:

- missao;
- instrucao curta;
- feedback positivo;
- sinal de conclusao;
- proximo passo simples.

## Linguagem proibida

Evitar em qualquer modulo:

- "voce falhou";
- "voce nao evoluiu";
- "deficiencia";
- "problema grave";
- "atraso";
- "incapaz";
- comparacao com outras criancas;
- ranking publico.

Preferir:

- "vamos praticar uma parte por vez";
- "esta em formacao";
- "vale tentar de novo com calma";
- "ha sinais de progresso";
- "ainda precisamos de mais algumas atividades para entender melhor".

## Versao do contrato

Versao atual:

```text
1.0
```

Mudancas futuras devem preservar compatibilidade quando possivel.

Quando um modulo enviar `schema_version` diferente, o portal deve conseguir:

- aceitar versoes antigas;
- marcar campos ausentes;
- reduzir confianca de analises quando necessario;
- evitar quebrar o registro da atividade.

## Checklist de aceite por modulo

Antes de considerar um modulo pronto para longitudinal, verificar:

- abre pelo portal com dados da crianca preenchidos;
- nao pede nome, idade ou id quando veio do portal;
- registra evento em `/api/activity-events`;
- envia `assignment_id` e `assignment_item_id` quando existirem;
- marca a missao como concluida quando aplicavel;
- envia `metrics.completed`;
- envia metrica principal da area;
- envia artifacts auditaveis;
- separa feedback da crianca e do adulto;
- nao mostra conteudo adulto para a crianca;
- funciona em celular;
- registra tempo sem pressionar a crianca;
- permite baixa confianca quando faltarem dados.
