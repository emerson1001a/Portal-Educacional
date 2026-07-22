# PRD: Metas e Tarefas

## Contexto

O Portal Educacional precisa transformar uma percepcao do adulto em um caminho pequeno, observavel e seguro para a crianca.

Esse caminho nao deve ser:

- uma cobranca vaga;
- uma lista grande de exercicios;
- uma conclusao sobre a crianca;
- uma meta exibida diretamente para a crianca com linguagem adulta.

O caminho deve ser:

1. adulto registra uma percepcao;
2. portal organiza uma meta pedagogica;
3. adulto libera uma tarefa curta;
4. crianca executa no Portal da Crianca ou em um modulo;
5. modulo devolve evidencias;
6. portal compara as evidencias com a meta cadastrada;
7. portal mostra evolucao e orienta o proximo passo.

## Ponderacao de produto

Meta e uma ferramenta do adulto. Missao e a versao segura e simples que chega para a crianca.

Essa separacao e essencial.

O adulto pode pensar:

```text
Quero observar se ele compreende melhor pistas do texto.
```

A crianca deve receber algo como:

```text
Leia com calma e procure uma pista no texto antes de responder.
```

O produto nao deve dizer para a crianca:

```text
Voce tem dificuldade de inferencia.
```

## Objetivo

Definir como percepcoes, metas, tarefas, missoes e evidencias se conectam.

O PRD orienta:

- modelo conceitual;
- fluxo adulto;
- fluxo infantil;
- estados;
- dados esperados;
- criterio de aceite;
- proximas implementacoes.

## Modelo conceitual

### Percepcao

Observacao inicial do adulto.

Exemplos:

- "Ele le o texto, mas responde sem voltar ao enunciado."
- "Na redacao, as ideias aparecem, mas ficam fora de ordem."
- "Na tabuada, ele sabe algumas respostas, mas trava quando muda a ordem."

Pode ser familiar ou pedagogica.

### Meta pedagogica

Objetivo adulto, observavel e pequeno.

Exemplos:

- "Usar pistas do texto antes de responder."
- "Organizar comeco, meio e fim antes de escrever."
- "Ganhar seguranca na tabuada do 6 com repeticao curta."

### Tarefa

Plano liberado pelo adulto, ligado ou nao a uma meta.

Pode conter um ou mais itens.

### Missao infantil

Versao da tarefa exibida para a crianca.

Deve ser curta, positiva e concreta.

### Evidencia

Resultado registrado por modulo ou pelo portal.

Exemplos:

- texto produzido;
- texto lido;
- respostas;
- tempo de leitura;
- acertos;
- revisoes;
- feedback pontual;
- observacao do adulto.

## Fluxo adulto

1. Adulto seleciona a crianca.
2. Adulto registra uma percepcao ou escolhe uma meta existente.
3. IA pode ajudar a organizar a percepcao.
4. Adulto revisa a sugestao.
5. Adulto salva a meta.
6. Adulto cria tarefa ligada a essa meta.
7. Adulto escolhe modulos.
8. Adulto define instrucao infantil.
9. Adulto libera a missao.
10. Adulto acompanha evidencias no historico.
11. Portal sinaliza se a meta esta bem encaminhada, ainda em construcao, precisa de ajuste ou ainda nao tem evidencias suficientes.
12. Portal sugere proximo passo.

## Fluxo infantil

1. Crianca abre link infantil.
2. Crianca ve missoes liberadas.
3. Crianca escolhe uma atividade.
4. Crianca abre o modulo.
5. Crianca executa a atividade.
6. Modulo devolve evidencia ao portal.
7. Crianca recebe feedback curto e positivo.
8. Adulto recebe feedback completo no portal.

## Regras de linguagem

### Para o adulto

Pode conter:

- leitura mais completa;
- pontos de atencao;
- receita pratica;
- evidencias;
- limites de conclusao quando ainda ha poucos dados.

Deve evitar:

- diagnostico;
- alarmismo;
- certeza sem evidencia;
- linguagem de culpa.

### Para a crianca

Pode conter:

- "Vamos tentar uma parte pequena."
- "Voce terminou uma etapa importante."
- "Agora procure uma pista no texto."
- "Revise uma frase antes de entregar."

Deve evitar:

- "Voce tem dificuldade."
- "Voce errou muito."
- "Sua redacao esta ruim."
- "Voce precisa melhorar porque esta atras."

## Dados principais

### learning_goals

Meta pedagogica adulta.

Campos esperados:

```text
id
child_id
created_by
area
title
description
status
source_type
created_at
updated_at
```

Campos futuros recomendados:

```text
target_skill
success_criteria
primary_metric
confidence
review_after_events
review_after_days
goal_reading_status
goal_reading_updated_at
completed_at
```

### assignments

Tarefa ou missao liberada.

Campos esperados:

```text
id
child_id
created_by
created_by_role
goal_id
title
adult_notes
child_title
child_instructions
status
release_at
due_at
created_at
updated_at
```

### assignment_items

Itens da tarefa.

Campos esperados:

```text
id
assignment_id
module_id
activity_type
title
child_instructions
sort_order
required
status
created_at
```

### activity_events

Evidencias devolvidas por modulos.

Campos importantes para este PRD:

```text
child_id
assignment_id
assignment_item_id
service
activity_type
title
metrics
feedback
artifacts
evidence_level
visibility
created_at
```

## Status de meta

Recomendados:

- `active`: em acompanhamento;
- `paused`: pausada sem apagar historico;
- `done`: concluida;
- `archived`: arquivada.

Regra:

Meta concluida nao some. Ela vira conquista e evidencia longitudinal.

## Status de tarefa

Recomendados:

- `draft`: adulto ainda esta montando;
- `released`: disponivel para a crianca;
- `in_progress`: crianca iniciou ou modulo registrou inicio;
- `done`: todos os itens obrigatorios concluidos;
- `archived`: retirada da lista ativa.

## Status de item

Recomendados:

- `pending`;
- `started`;
- `done`;
- `skipped`;
- `blocked`.

## Relacao entre meta e tarefa

Uma meta pode ter varias tarefas.

Uma tarefa pode estar vinculada a uma meta principal.

No futuro, uma tarefa podera atender mais de uma meta, mas o MVP deve manter uma meta principal para reduzir complexidade.

## Relacao entre meta e evidencia

A meta nao deve ser apenas um cadastro textual.

Ela deve ser usada como referencia para interpretar as evidencias.

Pergunta central:

```text
As atividades realizadas aproximam a crianca da meta cadastrada?
```

Estados sugeridos para leitura da meta:

- `insufficient_evidence`: ainda faltam evidencias;
- `building`: ha sinais iniciais, mas a meta ainda esta em construcao;
- `on_track`: a meta esta bem encaminhada;
- `needs_adjustment`: ha pratica, mas os sinais sugerem ajustar estrategia;
- `maintenance_ready`: a meta pode estar pronta para deixar de ser foco principal e seguir em manutencao.

Regras:

- uma meta pode ter evidencias diretas, quando a atividade foi vinculada a ela;
- uma meta pode ter evidencias indiretas da mesma area, quando o adulto ainda nao vinculou atividade;
- evidencias diretas devem ter mais peso que evidencias indiretas;
- o portal deve mostrar quais evidencias sustentam a leitura;
- a decisao de encerrar uma meta continua sendo do adulto;
- o sistema nao deve dizer "meta alcancada" como conclusao definitiva sem revisao adulta.

Exemplo:

```text
Meta: organizar textos com comeco, meio e fim.
Evidencias: 12 redacoes vinculadas.
Leitura da meta: bem encaminhada.
Proximo passo: considerar encerrar esta meta como foco principal e criar uma meta menor, como melhorar frases de transicao.
```

## IA no fluxo

A IA pode:

- organizar percepcao do adulto;
- sugerir meta pequena;
- sugerir primeira tarefa;
- sugerir instrucao infantil;
- sugerir receita para o adulto;
- sugerir quando ainda e cedo para definir meta.

A IA nao deve:

- salvar sem confirmacao do adulto;
- diagnosticar;
- criar missao com linguagem sensivel para a crianca;
- transformar preocupacao adulta em rotulo infantil;
- recomendar excesso de tarefas.

## Pouca evidencia

Quando houver pouca evidencia, o sistema deve dizer algo como:

```text
Ainda temos poucos registros para concluir uma meta ideal. Vale fazer mais 2 ou 3 atividades curtas e observar o padrao.
```

Isso e especialmente importante para pais, que podem estar aflitos ou inseguros.

## Plano de 7 dias

O plano de 7 dias deve ser derivado de:

- metas ativas;
- evidencias recentes;
- continuidade;
- idade/serie quando disponivel;
- modulos habilitados.

Regra:

O plano deve ser curto. Melhor uma pratica pequena bem feita do que muitas tarefas que aumentem resistencia.

## Tarefas recorrentes

Nao implementar agora.

Prever para depois:

- repetir por dias da semana;
- limitar quantidade;
- pausar automaticamente;
- ajustar com base em evidencias.

## Gamificacao relacionada

Gamificacao deve se apoiar em tarefas e evidencias.

Pode celebrar:

- missao concluida;
- revisao feita;
- tentativa com calma;
- retorno para melhorar;
- continuidade flexivel.

Nao deve premiar apenas:

- velocidade;
- acerto absoluto;
- comparacao com outras criancas.

## Criterios de aceite

- Adulto consegue criar meta para uma crianca.
- Adulto consegue criar tarefa ligada a uma meta.
- Adulto consegue liberar uma missao infantil segura.
- Crianca ve apenas `child_title`, `child_instructions` e itens liberados.
- Crianca nao ve `adult_notes`, percepcao original nem hipotese pedagogica.
- Modulos recebem identificadores de tarefa quando abertos pela missao.
- Evidencias voltam com `assignment_id` e `assignment_item_id` quando aplicavel.
- Historico adulto mostra tarefa, modulo, feedback e artefatos expansiveis.
- Meta pode ser concluida sem apagar o historico.
- Sistema nao faz conclusoes amplas quando ha pouca evidencia.

## Proximas implementacoes

1. Ajustar interface adulta de metas para diferenciar meta, tarefa e missao infantil.
2. Permitir vincular tarefa a meta existente.
3. Exibir status de tarefa e item.
4. Registrar `assignment_id` e `assignment_item_id` em todos os modulos conectados.
5. Criar resumo por meta no painel adulto.
6. Criar primeira versao de leitura da meta a partir das evidencias.
7. Criar primeira versao de conclusao de meta como conquista.
8. Preparar PRD de relatorio longitudinal.
