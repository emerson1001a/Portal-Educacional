# PRD: Analise Longitudinal por Blocos

## Status

Documento de trabalho.

Este PRD ainda nao autoriza uma implementacao completa. Ele organiza a direcao do produto para que as proximas mudancas no Portal Educacional sejam feitas com criterio pedagogico, evidencias claras e linguagem segura para adultos e criancas.

## Contexto

O Portal Educacional nasceu para ajudar adultos a apoiarem criancas com mais clareza, calma e evidencia.

A experiencia com os modulos de Redacao, Interpretacao, Tabuada e Ingles mostrou que registrar atividades nao basta. O valor mais importante aparece quando o portal consegue olhar para o tempo e responder:

```text
O que esta melhorando?
O que esta estavel?
O que ainda precisa de uma estrategia diferente?
Quais evidencias sustentam essa orientacao?
O que o adulto pode fazer agora, sem pressionar a crianca?
```

Os testes com massa simulada mostraram duas licoes importantes:

- a interface consegue mostrar sinais longitudinais quando ha dados distribuidos no tempo;
- ainda precisamos separar melhor exibicao de feedbacks pontuais de uma analise longitudinal real.

Este PRD define uma nova camada do produto: a analise longitudinal por blocos de aprendizagem.

## Ponderacao de produto

A analise longitudinal nao deve ser uma nota, um julgamento ou um diagnostico.

Ela deve ser uma leitura cuidadosa de evidencias, comparando a crianca com ela mesma ao longo do tempo.

O adulto pode pensar ou escrever internamente:

```text
Ele nao evoluiu em redacao.
```

O produto deve transformar isso em algo mais cuidadoso:

```text
Ainda nao ha sinais consistentes de avanco em estrutura de redacao. Vale reduzir a tarefa, manter o roteiro de comeco, meio e fim e observar novas tentativas antes de aumentar a exigencia.
```

O produto deve ajudar o adulto a agir melhor, nao assustar, culpar ou rotular.

## Objetivo

Criar um modelo de analise longitudinal que:

- analise cada bloco de aprendizagem separadamente;
- mostre tendencias de forma simples quando o bloco estiver fechado;
- permita abrir cada bloco para ver graficos, evidencias e orientacoes;
- ligue toda conclusao a evidencias concretas;
- ajude o adulto a decidir o proximo passo;
- preserve linguagem esperancosa, pratica e metodica;
- evite conclusoes fracas quando ainda ha poucos dados.

## Principios permanentes

### 1. Blocos separados

Cada area deve ter sua propria analise longitudinal.

Exemplos:

- Redacao;
- Interpretacao de texto;
- Tabuada;
- Ingles;
- futuros modulos.

O portal nao deve misturar areas para dizer genericamente:

```text
A crianca esta evoluindo.
```

Ele deve dizer algo mais preciso:

```text
Em Tabuada, ha tendencia de alta.
Em Redacao, os sinais ainda estao estaveis.
Em Interpretacao, ha boa continuidade, mas ainda vale observar justificativas.
```

### 2. Visao integrada fica para depois

A arquitetura deve permitir uma camada futura de analise integrada, mas o MVP da analise longitudinal deve priorizar blocos separados.

Um professor, psicologo, psicopedagogo ou orientador podera cruzar evidencias com sua propria expertise. O produto deve fornecer material claro para isso, sem fazer cruzamentos precipitados.

### 3. Evidencia antes de conclusao

Toda conclusao deve poder responder:

```text
Que atividades sustentam esta leitura?
Quais dados foram usados?
Quantas evidencias existem?
Ha tempo suficiente para falar em tendencia?
```

Se nao houver base suficiente, o portal deve dizer:

```text
Ainda ha pouca evidencia para uma conclusao. O melhor caminho e observar mais algumas atividades curtas.
```

### 4. Tendencia nao e diagnostico

O portal pode falar em:

- sinais;
- tendencia;
- estabilidade;
- ganho de autonomia;
- ponto de atencao;
- necessidade de mais evidencias;
- sugestao de proximo passo.

O portal nao deve falar em:

- diagnostico;
- incapacidade;
- atraso como rotulo;
- comparacao com outras criancas;
- previsoes definitivas.

### 5. O adulto tambem precisa de cuidado

O adulto pode estar preocupado, cansado ou inseguro.

A analise deve trazer:

- clareza;
- calma;
- orientacao pratica;
- esperanca realista;
- receita pequena para a proxima semana;
- indicacao de quando esperar mais evidencias.

## Separacao dos blocos do painel adulto

O painel adulto nao deve repetir a mesma analise em lugares diferentes.

Decisao de produto:

- a evolucao sempre deve existir em dois eixos complementares: **tempo** e **area**;
- **Evolucao no tempo** mostra ritmo, continuidade e distribuicao da pratica;
- **Evolucao por area** mostra como leitura, escrita, matematica, ingles e futuros modulos estao evoluindo dentro de suas proprias logicas;
- esses dois blocos formam o coracao da analise longitudinal;
- **Sinais principais** deve ser uma sintese curta depois das missoes, nao um relatorio completo;
- o **Historico unificado** deve ser a area de auditoria das evidencias;
- o **Plano dos proximos 7 dias** nao deve ser um bloco principal neste momento. A orientacao de proximo passo deve aparecer como recomendacao curta dentro dos Sinais principais ou dentro de cada area analisada.

Ordem oficial do modulo adulto:

1. **Aluno ativo e Bloco Infantil**
2. **Registro da Meta e das Missoes**
   - Meta Pedagogica
   - Missoes para a crianca
3. **Acompanhamento da Crianca**
   - Sinais principais
   - Evolucao no tempo
   - Evolucao por area
   - Historico unificado

Essa ordem segue a logica pedagogica do produto:

```text
intencao do adulto -> tarefa da crianca -> leitura dos resultados -> evidencias
```

Divisao visual recomendada:

- **Registro da Meta e das Missoes:** bloco de cadastro e planejamento;
- **Acompanhamento da Crianca:** bloco de analise dos resultados e evidencias.

Cada bloco deve ter uma funcao clara:

- **Aluno ativo e Bloco Infantil:** responder "qual crianca estou acompanhando, como cadastro outra e como abro a area infantil?";
- **Meta Pedagogica:** responder "o que a crianca precisa praticar ou desenvolver?";
- **Missoes para a crianca:** responder "baseado na meta pedagogica, quais atividades propor a crianca?";
- **Sinais principais:** responder "com base no que ja foi feito, onde o adulto precisa olhar agora?";
- **Evolucao no tempo:** responder "ha continuidade de pratica ao longo das semanas?";
- **Evolucao por area:** responder "como cada area esta evoluindo dentro da sua propria logica?";
- **Historico unificado:** responder "quais evidencias existem e onde posso auditar cada atividade?".

### Aluno ativo e Bloco Infantil

Funcao:

- selecionar a crianca em acompanhamento;
- permitir cadastrar novo aluno;
- abrir o Bloco Infantil em outra aba;
- copiar link infantil;
- gerar codigo infantil;
- deixar claro que todas as metas, missoes e analises abaixo pertencem ao aluno selecionado.

Nao deve:

- misturar dados de criancas diferentes;
- ocupar o centro da tela;
- competir visualmente com as metas e missoes.

### Meta Pedagogica

Funcao:

- registrar a intencao pedagogica do adulto;
- indicar o que a crianca precisa praticar ou desenvolver;
- servir de base para criar missoes;
- ligar percepcao adulta, pratica da crianca e evidencias futuras.

Nao deve:

- ser um diagnostico;
- virar relatorio longitudinal;
- comparar a crianca com outras criancas;
- ter linguagem dura, alarmista ou rotuladora.

Exemplo:

```text
Fortalecer textos curtos com comeco, meio e fim.
```

### Missoes para a crianca

Funcao:

- transformar a meta em pratica concreta;
- liberar atividades para a crianca;
- mostrar ao adulto o que esta pendente, em andamento ou concluido;
- manter claro o combinado entre adulto e crianca.

Texto orientador recomendado:

```text
Baseado na meta pedagogica, quais atividades propor a crianca.
```

Acoes de acesso infantil:

- **Abrir Bloco Infantil:** abre a area infantil em outra aba, preservando o painel adulto;
- **Copiar link infantil:** gera e copia o link para envio;
- **Gerar codigo infantil:** gera codigo curto para a crianca digitar em outro aparelho.

Nao deve:

- fazer analise longitudinal;
- misturar evidencias antigas com tarefas futuras;
- sobrecarregar a crianca com muitas atividades de uma vez.

Exemplo:

```text
Hoje: escrever uma historia curta com foco no comeco.
```

### Sinais principais

Ponderacao:

Sinais principais substitui a ideia de um bloco grande chamado Resumo do
Desenvolvimento. Ele nao deve explicar tudo.

Ele tambem nao deve aparecer antes da Meta Pedagogica e das Missoes, porque
a analise deve vir depois do combinado pedagogico e da pratica.

Ele nao deve ser o centro da analise longitudinal. O centro deve ficar em
**Evolucao no tempo** e **Evolucao por area**.

Sinais principais deve funcionar como uma primeira leitura, curta e tranquila, para
ajudar o adulto a decidir onde olhar primeiro.

Funcao:

- ser uma porta de entrada para a analise;
- mostrar no maximo 3 sinais principais;
- indicar quais blocos merecem ser abertos;
- reduzir ansiedade com uma orientacao curta;
- evitar que o adulto precise ler tudo para saber por onde comecar.

Nao deve:

- listar todas as atividades;
- repetir todos os graficos;
- virar historico completo;
- conter botao de relatorio completo;
- substituir Evolucao no tempo;
- substituir Evolucao por area;
- virar Plano dos proximos 7 dias;
- misturar detalhes tecnicos demais;
- fazer conclusoes sem indicar nivel de confianca.

Conteudo esperado:

- 1 sinal positivo;
- 1 ponto que merece observacao, quando existir;
- 1 proximo passo curto;
- indicacao dos blocos que devem ser abertos para analise real.
- opcionalmente, um "relatorio rapido" textual, sem virar um relatorio completo.

Exemplos de intencao:

```text
Tudo caminhando bem. Mantenha a rotina leve e continue observando os proximos registros.
```

```text
Vale olhar Redacao com calma. Ha sinais de que a estrutura do texto ainda precisa de pratica guiada.
```

Exemplo:

```text
Sinais principais

1. Boa continuidade em Tabuada.
2. Interpretacao mostra sinais positivos.
3. Redacao merece observacao mais cuidadosa.

Proximo passo: abra Evolucao por area em Redacao antes de aumentar a dificuldade.
```

### Relatorio longitudinal

O Relatorio longitudinal nao deve ser um botao solto no topo da tela.
Tambem nao deve ficar como acao principal dentro de Sinais principais, porque
esse bloco deve ser uma olhada rapida.

Ele deve ser gerado a partir de:

- Sinais principais;
- Evolucao no tempo;
- Evolucao por area;
- Historico unificado.

A entrada para o relatorio completo deve ficar preferencialmente dentro das
areas de evolucao, com botoes como:

- Ver relatorio completo;
- Gerar relatorio para reuniao;
- Ver evidencias desta area.

O relatorio deve ser uma consequencia da analise, nao um bloco concorrente.

Em Sinais principais, quando houver algo relacionado a relatorio, deve aparecer
como "relatorio rapido" ou sintese curta, sem exigir que o adulto abra um
documento longo naquele momento.

### Evolucao no tempo

Funcao:

- mostrar ritmo e continuidade;
- indicar semanas com pratica;
- mostrar equilibrio entre areas;
- ajudar o adulto a perceber se houve constancia ou concentracao de atividades em poucos dias.

Nao deve:

- concluir qualidade pedagogica sozinho;
- dizer que a crianca evoluiu apenas porque praticou;
- substituir a analise por bloco;
- listar textos, respostas ou detalhes de cada atividade.

Conteudo esperado:

- quantidade de atividades por semana;
- semanas exibidas lado a lado, para dar impressao visual de evolucao;
- areas praticadas por semana;
- grafico abaixo dos indicadores semanais, ocupando a largura disponivel;
- quatro linhas no grafico quando houver dados: Redacao, Interpretacao, Tabuada e Ingles;
- alerta de pouca continuidade;
- indicacao de concentracao excessiva em poucos dias;
- sugestao de rotina curta.

Exemplo:

```text
Houve pratica em 3 de 4 semanas. A continuidade esta se formando. Agora vale manter pequenas missoes distribuidas, em vez de concentrar muitas atividades em um unico dia.
```

### Evolucao por area

Funcao:

- analisar cada area separadamente;
- mostrar tendencia especifica por disciplina ou habilidade;
- permitir abrir grafico e evidencias daquela area;
- orientar o proximo passo pedagogico dentro daquele bloco.

Nao deve:

- misturar leitura, escrita, matematica e ingles em uma conclusao unica;
- esconder a metrica usada;
- afirmar tendencia sem quantidade minima de evidencias;
- mostrar todos os detalhes de todas as atividades logo no bloco fechado.

Conteudo esperado com o bloco fechado:

- nome do bloco;
- tendencia;
- pista curta;
- numero de evidencias;
- periodo observado;
- nivel de confianca.

Conteudo esperado com o bloco aberto:

- resumo longitudinal do bloco;
- grafico de linha;
- metrica principal;
- sinais observados;
- orientacao para o adulto;
- lista de evidencias recolhidas.

Exemplo fechado:

```text
Redacao
Tendencia estavel
8 evidencias em 4 semanas
Pista: estrutura ainda oscila; abra para ver as redacoes e a orientacao.
```

### Historico unificado

Funcao:

- ser a area de auditoria;
- reunir todas as atividades registradas;
- permitir abrir uma evidencia especifica;
- mostrar o material concreto que sustenta conclusoes.

Nao deve:

- ser a principal area de leitura longitudinal;
- tentar resumir toda a evolucao;
- substituir os blocos por area;
- esconder detalhes importantes da atividade.

Conteudo esperado:

- filtro de periodo, como ultimos 30 dias, ultimos 90 dias ou ano atual;
- data;
- modulo;
- titulo da atividade;
- feedback completo;
- artefatos da atividade;
- metricas;
- perguntas e respostas, quando existirem;
- textos produzidos ou utilizados, quando existirem.

Exemplos:

- em Redacao, deve mostrar tema, titulo e texto;
- em Tabuada, deve mostrar tabuadas treinadas;
- em Interpretacao, deve mostrar texto, perguntas e respostas quando disponiveis;
- em Ingles, deve mostrar habilidade, nivel de apoio e erros frequentes quando disponiveis.

### Regra contra duplicidade

Se a mesma informacao aparecer em mais de um bloco, ela deve ter funcao diferente.

Exemplo:

- em Sinais principais: "Redacao merece atencao nesta semana";
- na Evolucao por Area: "Redacao esta estavel, com estrutura oscilando";
- no Historico unificado: "Redacao 4, texto completo, feedback e metricas".

O mesmo dado pode aparecer em camadas diferentes, mas nao deve gerar a mesma leitura repetida.

## Modelo de tela

### Visao geral recolhida

Cada bloco deve aparecer recolhido por padrao.

Com o bloco fechado, o adulto deve ver apenas:

- nome do bloco;
- tendencia;
- pista curta;
- quantidade de evidencias;
- periodo observado;
- nivel de confianca.

Exemplo:

```text
Redacao
Tendencia estavel
8 evidencias em 4 semanas
Pista: estrutura ainda oscila; vale manter roteiro de comeco, meio e fim.
```

Outro exemplo:

```text
Tabuada
Tendencia de alta
8 evidencias em 4 semanas
Pista: acertos e tempo melhoraram com treinos curtos.
```

### Tendencias possiveis

No MVP, as tendencias devem ser simples:

- alta;
- estavel;
- baixa;
- dados insuficientes.

Texto de apoio:

- **alta:** ha sinais consistentes de avanco no periodo observado;
- **estavel:** ha pratica, mas sem mudanca clara no indicador principal;
- **baixa:** ha queda nos indicadores ou aumento de dificuldade sem recuperacao;
- **dados insuficientes:** ainda nao ha base suficiente para falar em tendencia.

### Bloco aberto

Ao abrir um bloco, o adulto deve ver:

1. resumo longitudinal;
2. grafico de linha;
3. metrica principal usada;
4. sinais observados;
5. orientacao para o adulto;
6. lista de evidencias recolhidas;
7. acao sugerida.

Exemplo de estrutura:

```text
Redacao

Resumo:
Ha pratica frequente, mas a estrutura ainda nao mostra avanco consistente.

Grafico:
Estrutura do texto ao longo do tempo.

Orientacao:
Nesta semana, reduza a tarefa. Trabalhe apenas uma parte por vez e mantenha o roteiro fixo: comeco, meio e fim.

Evidencias:
- Redacao 1 - estrutura inicial - abrir
- Redacao 2 - estrutura inicial - abrir
- Redacao 3 - pequena melhora no comeco - abrir
```

### Evidencia aberta

Ao abrir uma atividade especifica, o adulto deve ver os dados concretos daquela evidencia.

Para Redacao:

- data;
- tema;
- titulo;
- tipo de texto;
- texto produzido;
- feedback para a crianca;
- feedback para o adulto;
- metricas usadas;
- observacoes de estrutura.

Para Interpretacao:

- data;
- texto usado;
- perguntas;
- respostas;
- acertos;
- tipos de erro;
- feedback para a crianca;
- feedback para o adulto.

Para Tabuada:

- data;
- tabuadas praticadas;
- quantidade de tentativas;
- acertos;
- tempo ou mediana;
- erros mais frequentes;
- feedback para a crianca;
- feedback para o adulto.

Para Ingles:

- data;
- habilidade treinada;
- nivel de apoio;
- tipo de exercicio;
- acertos;
- erros frequentes;
- frases ou palavras trabalhadas;
- feedback para a crianca;
- feedback para o adulto.

## Contrato de dados longitudinal

Cada atividade deve gerar uma evidencia com dados suficientes para analise futura.

Campos comuns:

- `child_id`;
- `service`;
- `activity_type`;
- `title`;
- `occurred_at`;
- `duration_ms`;
- `metrics`;
- `feedback.child`;
- `feedback.adult`;
- `artifacts`;
- `assignment_id`, quando existir;
- `assignment_item_id`, quando existir.

### Campos comuns em `metrics`

Recomendados:

- `module_version`;
- `attempt_number`;
- `duration_seconds`;
- `support_level`;
- `completed`;
- `child_age`;
- `child_self_assessment`, quando existir;
- `adult_goal_id`, quando existir;
- `confidence_signal`, quando calculado.

### Campos comuns em `artifacts`

Recomendados:

- texto produzido ou utilizado;
- perguntas e respostas;
- habilidade treinada;
- material de origem;
- configuracao da missao;
- resumo das evidencias exibiveis.

## Nivel de confianca

Cada analise deve indicar nivel de confianca.

### Dados insuficientes

Quando houver:

- menos de 3 evidencias no bloco;
- menos de 2 datas diferentes;
- apenas uma semana de pratica;
- metricas inconsistentes.

Texto sugerido:

```text
Ainda ha pouca evidencia para afirmar uma tendencia. Vale observar mais algumas atividades curtas antes de mudar a estrategia.
```

### Evidencia em formacao

Quando houver:

- 3 a 5 evidencias;
- pelo menos 2 semanas;
- alguma repeticao de habilidade.

Texto sugerido:

```text
Ja existe uma base inicial. Os sinais apontam um caminho, mas ainda vale confirmar com novas atividades.
```

### Boa base de evidencias

Quando houver:

- 6 ou mais evidencias;
- pelo menos 3 semanas;
- dados comparaveis;
- habilidade ou metrica repetida.

Texto sugerido:

```text
Ha boa base para observar tendencia neste bloco. A orientacao abaixo pode guiar a proxima semana.
```

## Redacao

### Objetivo da analise

Observar se a crianca esta ganhando organizacao textual ao longo do tempo.

### Indicadores principais

- presenca de comeco, meio e fim;
- clareza do comeco;
- desenvolvimento do meio;
- fechamento do final;
- coerencia entre as partes;
- tamanho do texto;
- aceitacao de revisao pequena;
- nivel de apoio necessario.

### Metrica principal sugerida

`structure_score`

Escala inicial:

- 0.0 a 0.3: estrutura muito inicial;
- 0.4 a 0.6: estrutura em formacao;
- 0.7 a 0.8: estrutura presente, ainda refinavel;
- 0.9 a 1.0: estrutura consistente para o nivel esperado.

Essa escala nao deve aparecer para a crianca.

### Tendencia de alta

Sinais:

- estrutura melhora em pelo menos 3 registros;
- comeco, meio e fim aparecem com mais clareza;
- a crianca precisa de menos apoio;
- os textos ficam mais completos sem aumentar sofrimento.

Mensagem para o adulto:

```text
Ha sinais de avanco na organizacao da redacao. O melhor caminho agora e manter a rotina por partes e refinar apenas um ponto por vez.
```

### Tendencia estavel

Sinais:

- ha pratica frequente;
- metricas de estrutura ficam quase iguais;
- os mesmos pontos aparecem em varias redacoes;
- a crianca inicia, mas nao organiza melhor.

Mensagem para o adulto:

```text
Ha pratica frequente, mas a estrutura ainda nao mostra avanco consistente. Vale reduzir a tarefa, manter o roteiro de comeco, meio e fim e observar novas tentativas antes de aumentar a exigencia.
```

### Tendencia de baixa

Sinais:

- textos ficam menores ou mais incompletos;
- aumento de abandono;
- mais apoio necessario;
- queda de estrutura em varias tentativas.

Mensagem para o adulto:

```text
Os registros recentes sugerem que a tarefa pode estar pesada neste momento. Vale reduzir a dose, voltar para uma etapa por vez e preservar a confianca antes de exigir textos maiores.
```

### Evidencia de redacao aberta

Deve mostrar:

- tema;
- titulo;
- texto;
- etapa mais forte;
- etapa que precisa de mais apoio;
- feedback da crianca;
- orientacao para o adulto;
- botao ou secao para comparar com redacoes anteriores.

## Interpretacao de Texto

### Objetivo da analise

Observar se a crianca esta compreendendo melhor textos e usando pistas para responder.

### Indicadores principais

- acertos;
- tipo de pergunta;
- uso de pistas do texto;
- resposta literal;
- inferencia;
- tempo de leitura;
- complexidade do texto;
- nivel de apoio.

### Metrica principal sugerida

No MVP:

- `accuracy`;
- `questions_correct`;
- `questions_total`;
- `support_level`;
- `complexity`.

Futuro:

- separar perguntas literais de inferenciais;
- medir se a crianca voltou ao texto;
- registrar justificativa da resposta.

### Tendencia de alta

Sinais:

- aumento de acertos;
- maior complexidade com acerto mantido;
- menos apoio;
- melhor justificativa.

Mensagem para o adulto:

```text
Ha sinais de avanco na leitura. A crianca esta encontrando mais pistas no texto. Continue pedindo uma justificativa curta, sem transformar a atividade em interrogatorio.
```

### Tendencia estavel

Mensagem:

```text
Ha continuidade, mas os sinais ainda estao estaveis. Vale manter textos curtos e observar se a crianca volta ao texto antes de responder.
```

### Tendencia de baixa

Mensagem:

```text
Os registros recentes sugerem que a leitura pode estar exigindo mais do que a crianca consegue sustentar neste momento. Reduza o tamanho do texto e trabalhe uma pergunta bem feita por vez.
```

## Tabuada

### Objetivo da analise

Observar se a crianca esta automatizando fatos de multiplicacao com repeticao curta e sem pressao.

### Indicadores principais

- tabuadas treinadas;
- tentativas;
- acertos;
- erros;
- tempo mediano;
- repeticao por tabuada;
- conclusao da missao.

### Metrica principal sugerida

Combinacao de:

- `accuracy`;
- `median_seconds`;
- `total_attempts`;
- `tabs`;
- `completed`.

### Tendencia de alta

Sinais:

- acerto aumenta;
- tempo diminui;
- mais tabuadas sem queda brusca;
- a crianca conclui a missao.

Mensagem:

```text
Ha sinais de consolidacao na tabuada. A repeticao curta esta funcionando. Mantenha a dose e aumente a variedade apenas quando a missao terminar leve.
```

### Tendencia estavel

Mensagem:

```text
A pratica esta acontecendo, mas os sinais ainda estao estaveis. Vale repetir menos tabuadas por vez antes de ampliar a mistura.
```

### Tendencia de baixa

Mensagem:

```text
Os registros sugerem que a carga pode ter aumentado rapido demais. Volte para poucas tabuadas e mantenha uma meta curta para recuperar confianca.
```

### Evidencia aberta de tabuada

Deve mostrar:

- tabuadas praticadas;
- total de tentativas;
- acertos;
- erros;
- tempo mediano;
- fatos que mais precisam de revisao;
- se a missao foi concluida.

## Ingles

### Objetivo da analise

Observar se a crianca esta ganhando seguranca em habilidades especificas de Ingles.

### Blocos iniciais

- `verb_to_be`;
- `simple_present`;
- `present_continuous`;
- `question_words`;
- vocabulario;
- redacao curta futura.

### Indicadores principais

- habilidade treinada;
- acertos;
- erros frequentes;
- nivel de apoio;
- tipo de exercicio;
- palavras ou frases trabalhadas;
- repeticao da mesma habilidade em dias diferentes.

### Metrica principal sugerida

- `accuracy`;
- `support_level`;
- `skill`;
- `common_errors`;
- `items_total`;
- `correct`.

### Tendencia de alta

Mensagem:

```text
Ha sinais de maior seguranca nesta habilidade de Ingles. A crianca acertou mais com menos apoio. Vale manter revisoes curtas para consolidar.
```

### Tendencia estavel

Mensagem:

```text
Ha pratica, mas os sinais ainda estao estaveis. Mantenha a mesma habilidade por mais algumas missoes antes de trocar de assunto.
```

### Tendencia de baixa

Mensagem:

```text
Os registros sugerem que a habilidade ainda precisa de mais apoio. Volte para exemplos curtos e reduza a quantidade de itens por missao.
```

## Papel da IA

### O que a IA pode fazer

- resumir evidencias;
- detectar tendencia quando houver dados suficientes;
- sugerir proximo passo pequeno;
- organizar orientacao para o adulto;
- explicar a base da conclusao;
- dizer quando ainda e cedo para concluir.

### O que a IA nao deve fazer

- diagnosticar;
- rotular a crianca;
- comparar com outras criancas;
- alarmar o adulto;
- afirmar certeza quando ha pouca evidencia;
- esconder as evidencias que sustentam a conclusao.

### Regra de transparencia

Sempre que a IA gerar uma conclusao longitudinal, o portal deve permitir abrir:

```text
Ver evidencias desta conclusao
```

## Fluxo do adulto

1. Adulto seleciona a crianca.
2. Adulto revisa ou cria uma Meta Pedagogica.
3. Adulto transforma a meta em Missoes para a crianca.
4. Portal mostra Sinais principais com uma sintese curta do que merece atencao.
5. Adulto abre Evolucao no tempo para ver ritmo e continuidade.
6. Adulto abre Evolucao por area para analisar leitura, escrita, matematica, ingles ou futuros modulos.
7. Adulto abre atividades especificas no Historico unificado quando quiser auditar evidencias.
8. Portal sugere um proximo passo curto sem substituir a decisao adulta.

## Fluxo do professor

O professor deve conseguir usar a mesma estrutura, mas com linguagem um pouco mais tecnica.

O produto deve permitir:

- observar tendencia por disciplina;
- abrir evidencias;
- preparar conversa com responsavel;
- sustentar orientacao com registros;
- evitar conclusoes sem base.

## Fluxo da crianca

A crianca nao deve ver a analise longitudinal adulta.

Ela deve ver apenas:

- missao atual;
- feedback positivo;
- sinal claro de conclusao;
- incentivo para continuar.

## Guia pedagogico publico

Depois de validado por especialista, o Guia Pedagogico do Produto deve poder
ser publicado no portal como elemento de confianca para pais, professores e
escolas.

Essa pagina nao deve expor dados de criancas, responsaveis, professores ou
escolas. Ela deve explicar a abordagem do produto.

No portal, o acesso a essa documentacao deve ser discreto. Ela deve existir
para quem quiser entender a abordagem, mas nao deve competir com as tarefas,
metas, missoes ou analises.

Formato recomendado:

- link pequeno no rodape;
- item discreto no menu secundario;
- texto curto como "Nossa abordagem" ou "Principios pedagogicos";
- sem card chamativo na tela principal;
- sem interromper o fluxo de acompanhamento.

### Camada publica

Funcao:

- explicar a filosofia pedagogica do portal;
- mostrar que o acompanhamento compara a crianca com ela mesma ao longo do tempo;
- explicar o uso de feedback positivo e evidencias;
- deixar claro que o portal apoia o adulto, mas nao substitui especialistas;
- aumentar confianca de familias e escolas.

Possiveis nomes:

- Nossa abordagem pedagogica;
- Como orientamos as criancas;
- Guia de apoio para adultos;
- Principios pedagogicos.

Conteudo esperado:

- progresso individual, sem comparacao com outras criancas;
- feedback positivo e pratico;
- missoes curtas e graduais;
- cuidado com linguagem;
- papel do adulto;
- papel da IA;
- limites do portal;
- quando buscar apoio especializado.

### Camada tecnica validada

Funcao:

- documentar regras de linguagem;
- listar limites pedagogicos;
- registrar criterios de alerta cuidadosos;
- explicar como evidencias sao usadas;
- servir de base para revisao por pedagogos, psicologos infantis ou psicopedagogos.

Essa camada pode existir como PDF, pagina tecnica ou documento interno anexado
ao portal institucional.

### Regra de publicacao

O guia so deve ser publicado como material de autoridade depois de revisao
profissional. Antes disso, ele pode existir como documento interno de produto.

## Regras de linguagem

### Preferir

- sinais de avanco;
- ponto de atencao;
- ainda precisa de pratica guiada;
- vale observar mais algumas tentativas;
- proximo passo;
- evidencias;
- desenvolvimento em relacao ao proprio percurso.

### Evitar

- nao evoluiu;
- fracassou;
- problema grave;
- deficiencia;
- atraso;
- desempenho ruim;
- incapacidade;
- comparacao com outras criancas.

## Criterios de aceite do MVP

O MVP da analise longitudinal por blocos sera considerado aceitavel quando:

- cada bloco aparecer separado;
- cada bloco fechado mostrar tendencia e pista curta;
- cada bloco aberto mostrar grafico de linha;
- cada conclusao tiver evidencias abertas;
- Redacao mostrar texto produzido;
- Tabuada mostrar tabuadas treinadas;
- Interpretacao mostrar texto, perguntas e respostas quando disponiveis;
- Ingles mostrar habilidade, apoio e erros frequentes;
- o portal diferenciar alta, estabilidade, baixa e dados insuficientes;
- a linguagem adulta for pratica e cuidadosa;
- a crianca nao tiver acesso a conclusoes adultas;
- o sistema nao fizer diagnosticos.

## Testes necessarios

### Caso 1: evolucao clara

Crianca com melhora em varias atividades de um bloco.

Esperado:

- tendencia de alta;
- grafico ascendente;
- orientacao para manter estrategia;
- evidencias abertas sustentam conclusao.

### Caso 2: pratica frequente sem avanco

Crianca com muitas atividades, mas indicador estavel.

Esperado:

- tendencia estavel;
- texto cuidadoso;
- orientacao para reduzir tarefa ou ajustar estrategia;
- evidencias abertas mostram repeticao do mesmo ponto.

### Caso 3: poucos dados

Crianca com 1 ou 2 atividades.

Esperado:

- dados insuficientes;
- sem conclusao forte;
- sugestao de observar mais.

### Caso 4: queda recente

Crianca com registros antigos melhores e recentes piores.

Esperado:

- tendencia de baixa;
- linguagem sem alarme;
- sugestao de reduzir dose e recuperar confianca.

## Questoes abertas

- Qual sera a metrica principal definitiva da Redacao?
- A analise deve considerar idade automaticamente?
- Como o professor podera anexar observacoes sem expor percepcoes privadas para a crianca?
- Quando uma tendencia estavel deve sugerir nova estrategia?
- Quantas evidencias sao necessarias para acionar uma orientacao mais firme?
- Como validar os textos com especialista pedagogico/psicologico antes de producao?

## Proximos passos

1. Refinar este PRD disciplina por disciplina.
2. Definir o contrato final de `metrics` e `artifacts` por modulo.
3. Criar massa de teste neutra, sem conclusoes plantadas.
4. Implementar o painel por blocos.
5. Implementar grafico por bloco.
6. Implementar "ver evidencias desta conclusao".
7. Testar com Jose Carlos e Pedro Antonio.
8. Depois testar com dados reais de Miguel e Gabriel, sem misturar com massa demo.
