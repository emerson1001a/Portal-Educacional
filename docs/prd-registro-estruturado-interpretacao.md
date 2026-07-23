# PRD: Registro Estruturado da Interpretacao de Texto

## Status

Documento de trabalho.

Este PRD define o contrato de dados e a logica pedagogica minima para que o
modulo de Interpretacao de Texto gere evidencias estruturadas, capazes de
sustentar analise longitudinal e relatorios para familia sem depender de
estimativas frageis.

Ele nao substitui o PRD de Analise Longitudinal por Blocos nem o PRD de
Relatorio para Reuniao com Pais. Ele detalha o que o modulo de Interpretacao
precisa salvar para alimentar esses documentos com mais qualidade.

## Relacao com outros documentos

Este PRD depende de:

- `docs/prd-analise-longitudinal-por-blocos.md`;
- `docs/prd-relatorio-reuniao-pais.md`;
- `docs/prd-sinais-da-missao.md`;
- `docs/guia-de-orientacao-pedagogica.md`;
- `modules/module-contract.md`.

## Contexto

Hoje o Portal Educacional consegue registrar texto, perguntas, respostas e
feedback da Interpretacao de Texto. Isso ja permite leitura qualitativa.

O problema aparece quando o relatorio tenta criar um indicador numerico sem que
o modulo tenha salvo, de forma explicita, se cada resposta estava correta,
parcialmente correta ou incorreta.

Exemplo do problema:

```text
A crianca respondeu todas as perguntas, mas o sistema mostra indicador 70.
```

Esse numero pode ser confundido com nota ou percentual de acerto, mesmo quando
ele veio de uma estimativa tecnica. Isso fragiliza o relatorio e pode gerar
uma leitura injusta.

Este PRD resolve esse ponto definindo que o modulo deve salvar evidencias
pedagogicas estruturadas.

## Objetivo

Transformar cada atividade de Interpretacao em uma evidencia rica, capaz de
responder:

```text
Que texto a crianca leu?
Que tipos de pergunta foram feitos?
Como a crianca respondeu?
O que ela acertou, acertou parcialmente ou ainda precisa praticar?
Que habilidade de leitura apareceu melhor?
Que habilidade ainda precisa de continuidade?
Qual orientacao pratica o adulto deve receber?
```

## Nao objetivos

Esta etapa nao deve:

- criar diagnostico;
- comparar criancas;
- gerar nota escolar;
- substituir avaliacao do professor;
- transformar toda resposta aberta em julgamento duro;
- bloquear a crianca por erro;
- mostrar metricas tecnicas para a crianca;
- exigir que registros antigos tenham a mesma qualidade dos novos.

## Principios pedagogicos

### 1. A resposta deve ser corrigida contra o texto

A IA deve avaliar a resposta da crianca com base no texto apresentado e na
pergunta feita.

Nao deve usar conhecimento externo quando a pergunta e de compreensao do texto.

### 2. Nem toda pergunta e do mesmo tipo

O modulo deve diferenciar perguntas:

- literais;
- inferenciais;
- vocabulario em contexto;
- justificativa;
- sequencia ou organizacao de fatos.

Essa separacao e essencial porque a crianca pode ir muito bem em perguntas
literais e ainda precisar de apoio em inferencia ou justificativa.

### 3. Acerto parcial e pedagogicamente importante

Respostas abertas raramente sao apenas certo ou errado.

O sistema deve permitir:

- correta;
- parcialmente correta;
- incorreta;
- sem resposta;
- nao avaliavel.

### 4. O adulto precisa de orientacao, nao de susto

Mesmo quando houver baixa performance, a linguagem deve indicar proximo passo
pequeno e possivel.

Exemplo:

```text
As respostas mostram que vale trabalhar perguntas literais antes de aumentar a
complexidade. Use textos curtos e peca para a crianca apontar a pista no texto.
```

### 5. A crianca precisa de feedback curto

Para a crianca, o feedback deve ser simples, positivo e acionavel.

Exemplo:

```text
Boa tentativa. Na proxima, procure no texto a parte que ajuda a responder.
```

## Modelo de dados esperado

O registro continua usando `activity_events`, com dados em:

- `service = "interpretacao"`;
- `activity_type`;
- `metrics`;
- `artifacts`;
- `feedback.child`;
- `feedback.adult`.

## Contrato de `metrics`

Campos minimos recomendados para novas atividades:

```json
{
  "module_version": "interpretacao-structured-v1",
  "completed": true,
  "child_age": 10,
  "text_level": "medio",
  "text_complexity_score": 0.55,
  "questions_total": 4,
  "questions_answered": 4,
  "questions_correct": 3,
  "questions_partial": 1,
  "questions_incorrect": 0,
  "accuracy_pct": 87.5,
  "literal_accuracy_pct": 100,
  "inferential_accuracy_pct": 75,
  "vocabulary_accuracy_pct": null,
  "justification_accuracy_pct": null,
  "comprehension_score": 0.88,
  "support_level": "independent",
  "duration_seconds": 420,
  "reading_duration_seconds": 180,
  "answer_duration_seconds": 240,
  "used_text_evidence_count": 2,
  "source": "ai_generated_text"
}
```

### Campos obrigatorios no MVP

Para o primeiro ciclo de implementacao, salvar pelo menos:

- `module_version`;
- `completed`;
- `child_age`;
- `text_level`;
- `questions_total`;
- `questions_answered`;
- `questions_correct`;
- `questions_partial`;
- `questions_incorrect`;
- `accuracy_pct`;
- `comprehension_score`;
- `support_level`;
- `duration_seconds`;
- `source`.

### Campos opcionais, mas desejaveis

- `literal_accuracy_pct`;
- `inferential_accuracy_pct`;
- `vocabulary_accuracy_pct`;
- `justification_accuracy_pct`;
- `text_complexity_score`;
- `reading_duration_seconds`;
- `answer_duration_seconds`;
- `used_text_evidence_count`.

## Contrato de `artifacts`

Campos minimos:

```json
{
  "text": "Texto lido pela crianca...",
  "text_title": "A aventura no recreio",
  "theme": "aventura",
  "text_size": "medio",
  "source": "ai_generated_text",
  "questions": [
    {
      "id": "q1",
      "type": "literal",
      "difficulty": "facil",
      "prompt": "Onde a historia aconteceu?",
      "expected_answer": "No recreio da escola.",
      "evidence": "Era um recreio normal..."
    }
  ],
  "answers": [
    {
      "question_id": "q1",
      "answer": "No recreio.",
      "evaluation": "correct",
      "score": 1,
      "uses_text_evidence": true,
      "feedback_child": "Isso mesmo, voce encontrou o lugar da historia.",
      "feedback_adult": "Resposta literal bem localizada."
    }
  ]
}
```

### Tipos de pergunta

Valores permitidos em `questions[].type`:

- `literal`;
- `inferential`;
- `vocabulary_context`;
- `justification`;
- `sequence`;
- `main_idea`;
- `character_action`;
- `cause_consequence`.

### Dificuldade da pergunta

Valores permitidos em `questions[].difficulty`:

- `facil`;
- `media`;
- `dificil`.

### Avaliacao da resposta

Valores permitidos em `answers[].evaluation`:

- `correct`;
- `partial`;
- `incorrect`;
- `blank`;
- `not_evaluable`.

### Pontuacao da resposta

Campo `answers[].score`:

- `1`: correta;
- `0.5`: parcialmente correta;
- `0`: incorreta ou em branco;
- `null`: nao avaliavel.

Essa pontuacao nao deve aparecer para a crianca.

## Contrato de `feedback.child`

Formato recomendado:

```json
{
  "message": "Voce encontrou boas pistas no texto. Continue respondendo com calma.",
  "next_step": "Na proxima leitura, tente mostrar qual parte do texto ajudou voce.",
  "tone": "positive"
}
```

Regras:

- ser curto;
- falar com a crianca;
- valorizar esforco real;
- evitar nota;
- evitar comparacao;
- orientar uma unica melhoria.

## Contrato de `feedback.adult`

Formato recomendado:

```json
{
  "summary": "A crianca localizou bem informacoes explicitas. O proximo passo e praticar perguntas que pedem uma pequena justificativa.",
  "recipe": [
    "Leia um trecho curto.",
    "Faca uma pergunta literal.",
    "Depois pergunte: que parte do texto ajudou voce?"
  ],
  "attention_points": [
    "Ainda vale observar se a crianca justifica a resposta com base no texto."
  ],
  "avoid_saying": [
    "Voce nao entendeu o texto."
  ],
  "suggested_phrase": "Vamos procurar juntos a pista que ajuda a responder."
}
```

## Como calcular os indicadores

### `questions_correct`

Soma de respostas com:

```text
evaluation = correct
```

### `questions_partial`

Soma de respostas com:

```text
evaluation = partial
```

### `questions_incorrect`

Soma de respostas com:

```text
evaluation = incorrect ou blank
```

### `accuracy_pct`

Formula:

```text
((correct * 1.0) + (partial * 0.5)) / total_avaliavel * 100
```

Respostas `not_evaluable` nao entram no denominador.

### `comprehension_score`

No MVP:

```text
accuracy_pct / 100
```

Evolucao futura:

- ponderar tipo de pergunta;
- considerar complexidade do texto;
- considerar uso de evidencia textual;
- considerar nivel de apoio.

## Regras para relatorio

### Quando houver dados estruturados

O relatorio pode mostrar:

- indicador numerico;
- grafico de evolucao;
- acertos por tipo de pergunta;
- leitura da tendencia;
- comparacao entre inicio, meio e fim do periodo.

### Quando nao houver dados estruturados

O relatorio nao deve inventar indicador numerico.

Deve dizer:

```text
Ha textos, perguntas e respostas salvas, mas ainda nao ha pontuacao estruturada
suficiente para calcular uma tendencia numerica confiavel.
```

E deve usar:

- texto trabalhado;
- perguntas;
- respostas;
- feedback da crianca;
- feedback para o adulto.

### Registros antigos

Registros antigos devem continuar aparecendo no historico e no anexo.

Mas devem ser marcados internamente como:

```text
structured_reading_v1 = false
```

Ou equivalente:

```text
metrics.module_version ausente
```

Eles podem sustentar leitura qualitativa, mas nao devem ser misturados com
metricas numericas novas sem aviso.

## Papel da IA

### Na geracao da atividade

A IA deve:

- criar texto adequado a idade;
- criar perguntas coerentes com o texto;
- classificar cada pergunta por tipo;
- gerar resposta esperada;
- indicar evidencia do texto que sustenta a resposta.

### Na correcao

A IA deve receber:

- texto;
- perguntas;
- respostas esperadas;
- respostas da crianca.

E devolver JSON estruturado com:

- avaliacao por pergunta;
- score por pergunta;
- feedback curto para crianca;
- orientacao para adulto;
- metricas agregadas.

### Limite importante

A IA nao deve penalizar a crianca por resposta com palavras diferentes se a
ideia estiver correta.

Exemplo:

Pergunta:

```text
Onde a historia aconteceu?
```

Resposta esperada:

```text
No recreio da escola.
```

Resposta da crianca:

```text
No recreio.
```

Resultado:

```text
correct
```

## Prompt tecnico esperado

O endpoint de correcao deve orientar a IA a responder apenas em JSON valido.

Estrutura esperada:

```json
{
  "metrics": {},
  "artifacts_patch": {
    "answers": []
  },
  "feedback": {
    "child": {},
    "adult": {}
  }
}
```

Regra:

```text
Nao inclua texto fora do JSON.
```

## UX da crianca

A crianca deve ver:

- texto;
- perguntas;
- progresso;
- feedback positivo;
- botao claro para retornar a missao.

A crianca nao deve ver:

- porcentagens;
- score;
- comparacao com outras atividades;
- avaliacao tecnica por tipo de pergunta;
- texto adulto.

## UX do adulto

O adulto deve ver:

- leitura da atividade;
- texto trabalhado;
- perguntas e respostas;
- resumo da compreensao;
- orientacao pratica;
- acertos por tipo de pergunta quando houver dados;
- evolucao longitudinal no relatorio.

## Impacto no relatorio para pais

Com este contrato, o relatorio de Interpretacao podera dizer:

```text
No periodo, Gabriel realizou 20 leituras. Nas perguntas literais, manteve alta
precisao. Nas perguntas inferenciais, os registros mais recentes mostram mais
seguranca para localizar pistas e explicar a resposta.
```

Sem este contrato, o relatorio deve ser mais cuidadoso:

```text
Ha textos, perguntas e respostas salvas. A leitura abaixo e qualitativa, pois o
modulo ainda nao registrava acertos por tipo de pergunta neste periodo.
```

## Impacto no banco

Nao ha necessidade imediata de nova tabela se `activity_events.metrics`,
`activity_events.artifacts` e `activity_events.feedback` ja comportarem JSON.

O ajuste principal e de contrato.

Possivel evolucao futura:

- tabela `activity_question_results`;
- tabela `reading_texts`;
- tabela `reading_question_bank`;
- snapshots de relatorio.

Para MVP, manter em JSON reduz custo e risco.

## Plano de implementacao

### Etapa 1: PRD e contrato

- Criar este PRD.
- Validar nomes de campos.
- Confirmar compatibilidade com `activity_events`.

### Etapa 2: Geracao de perguntas estruturadas

- Ajustar prompt da criacao da atividade.
- Salvar perguntas com `type`, `difficulty`, `expected_answer` e `evidence`.

### Etapa 3: Correcao estruturada

- Ajustar endpoint de finalizacao.
- Solicitar JSON estruturado da IA.
- Validar JSON antes de salvar.
- Criar fallback seguro se a IA falhar.

### Etapa 4: Registro da evidencia

- Salvar `metrics`, `artifacts.answers` e `feedback`.
- Garantir que o evento seja gravado no Portal Educacional.

### Etapa 5: Relatorio

- Usar indicador numerico apenas quando houver dados estruturados.
- Mostrar acertos por tipo de pergunta.
- Separar registros antigos de registros estruturados.

### Etapa 6: Testes reais

- Testar com uma crianca ficticia.
- Testar com Gabriel, que tende a acertar tudo.
- Verificar se o relatorio mostra 100% quando todas as respostas foram avaliadas como corretas.
- Verificar se acertos parciais nao viram erro seco.

## Criterios de aceite

O registro estruturado sera aceitavel quando:

- cada pergunta tiver tipo e resposta esperada;
- cada resposta tiver avaliacao estruturada;
- acerto parcial for possivel;
- `accuracy_pct` representar acerto real, nao estimativa;
- o relatorio nao mostrar indicador numerico quando o dado nao existir;
- registros antigos continuarem visiveis sem distorcer grafico;
- feedback da crianca for curto, positivo e acionavel;
- feedback do adulto trouxer receita pratica;
- a IA nao fizer perguntas fora do texto;
- a IA nao corrigir usando conhecimento externo quando a pergunta depende do texto;
- o historico unificado mostrar texto, perguntas, respostas e feedback;
- a analise longitudinal conseguir diferenciar pergunta literal, inferencial e justificativa quando houver dados.

## Testes necessarios

### Caso 1: todas corretas

Crianca responde corretamente 4 de 4 perguntas.

Esperado:

- `questions_correct = 4`;
- `accuracy_pct = 100`;
- relatorio mostra indicador 100;
- feedback da crianca positivo e simples.

### Caso 2: resposta parcial

Crianca responde uma ideia correta, mas incompleta.

Esperado:

- `evaluation = partial`;
- `score = 0.5`;
- feedback orienta complemento sem dizer que esta tudo errado.

### Caso 3: pergunta inferencial

Crianca precisa concluir algo a partir do texto.

Esperado:

- pergunta classificada como `inferential`;
- resposta aceita se a conclusao estiver sustentada pelo texto;
- feedback adulto indica se a inferencia esta em formacao.

### Caso 4: resposta fora do texto

Crianca responde com ideia que nao aparece no texto.

Esperado:

- `evaluation = incorrect` ou `partial`, conforme caso;
- feedback da crianca convida a procurar pista no texto;
- feedback adulto orienta voltar a perguntas literais.

### Caso 5: registro antigo

Atividade antiga sem `module_version`.

Esperado:

- aparece no historico;
- aparece no anexo do relatorio;
- nao entra em grafico numerico sem aviso.

## Questoes abertas

- O modulo deve registrar se a crianca voltou ao texto antes de responder?
- Como detectar uso de microfone ou resposta ditada pelo celular?
- Devemos permitir que o adulto revise a correcao da IA?
- Qual sera o limite de perguntas por idade?
- A complexidade do texto deve ser calculada pela IA, por regra fixa ou pelos dois?
- Como diferenciar resposta curta correta de resposta incompleta?
- Quando a IA deve sugerir reduzir o tamanho do texto?

## Decisoes recomendadas

1. No MVP, manter os dados estruturados dentro de `activity_events`.
2. Nao migrar registros antigos.
3. Nao mostrar grafico numerico quando a atividade antiga nao tiver correcao estruturada.
4. Priorizar perguntas literais, inferenciais e justificativas no primeiro ciclo.
5. Manter feedback infantil simples e sem porcentagem.
6. Usar a IA para corrigir respostas abertas, mas salvar sempre a avaliacao estruturada.

## Proximos passos

1. Atualizar o modulo de Interpretacao para gerar perguntas estruturadas.
2. Atualizar a finalizacao da leitura para corrigir respostas com JSON.
3. Salvar `metrics`, `artifacts.answers` e `feedback` no contrato definido.
4. Ajustar relatorio de Interpretacao para usar apenas metricas reais.
5. Testar com Gabriel em cenario de alto acerto.
6. Testar com crianca ficticia em cenario de acerto parcial e erro.
