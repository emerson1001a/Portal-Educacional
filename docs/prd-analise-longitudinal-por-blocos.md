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
- relacione a evolucao observada com as metas cadastradas pelo adulto;
- ajude o adulto a perceber se a meta esta bem encaminhada, ainda em construcao, precisa de ajuste ou ainda nao tem evidencias suficientes;
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

### 6. A meta fecha o ciclo da analise

A analise longitudinal nao deve apenas dizer se uma area melhorou.

Ela deve ajudar o adulto a responder:

```text
As evidencias mostram que a crianca esta se aproximando da meta cadastrada?
```

Esse ponto e central para o produto.

Hoje o portal registra metas, missoes e evidencias. A evolucao do produto deve
ligar essas camadas, para que o adulto nao precise fazer sozinho a conexao entre
o que foi planejado e o que aconteceu.

O portal deve tratar a meta como eixo da leitura:

- qual era a intencao pedagogica do adulto;
- quais missoes foram propostas a partir dessa meta;
- quais evidencias foram registradas;
- se os sinais recentes indicam aproximacao da meta;
- se a meta ainda precisa de mais pratica;
- se a estrategia deve ser ajustada;
- se a meta esta bem encaminhada para ser concluida ou encerrada para ajuste.

O produto nao deve afirmar de forma seca:

```text
Meta alcancada.
```

Preferir sinais cuidadosos:

```text
Meta bem encaminhada.
```

```text
Ha indicios de que esta meta pode ser concluida como foco principal.
```

```text
Ainda nao ha evidencias suficientes para concluir se a meta esta avancando.
```

Decisao final:

- o portal sinaliza;
- o adulto decide;
- a evidencia fica disponivel para auditoria.

## Separacao dos blocos do painel adulto

O painel adulto nao deve repetir a mesma analise em lugares diferentes.

Decisao de produto:

- tempo e area nao devem ser tratados como blocos independentes na analise pedagogica;
- cada area deve trazer sua propria leitura temporal, porque qualidade, volume e continuidade se misturam;
- **Acompanhamento por area** passa a ser o bloco central da analise longitudinal;
- dentro de cada area, o produto deve avaliar desempenho, quantidade de evidencias, distribuicao no tempo, complexidade, consistencia e nivel de confianca;
- **Onde olhar primeiro** deixa de ser bloco independente e passa a ser a sintese de entrada dentro de **Acompanhamento por area**;
- o ritmo geral de pratica pode aparecer como sinal auxiliar, mas nao como bloco principal separado;
- o **Historico unificado** deve ser a area de auditoria das evidencias;
- o **Plano dos proximos 7 dias** nao deve ser um bloco principal neste momento. A orientacao de proximo passo deve aparecer como recomendacao curta dentro de **Acompanhamento por area**, especialmente em **Onde olhar primeiro** ou dentro de cada area analisada.

Ordem oficial do modulo adulto:

1. **Aluno ativo e Bloco Infantil**
2. **Registro da Meta e das Missoes**
   - Meta Pedagogica
   - Missoes para a crianca
3. **Acompanhamento da Crianca**
   - Acompanhamento por area
     - Onde olhar primeiro
     - areas analisadas
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
- **Acompanhamento por area:** responder "como cada area esta evoluindo ao longo do tempo, com base nas evidencias disponiveis?" e, na entrada do bloco, "onde o adulto deve olhar primeiro?";
- **Leitura da meta:** responder, dentro de cada area ou meta relacionada, "as evidencias aproximam a crianca da meta cadastrada?";
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

### Onde olhar primeiro

Ponderacao:

A funcao antes chamada de **Sinais principais** nao deve existir como bloco
independente no painel adulto.

Ela continua importante, mas deve ficar dentro de **Acompanhamento por area**, como
uma sintese de entrada chamada **Onde olhar primeiro**.

Motivo:

- evita criar um bloco concorrente com Acompanhamento por area;
- reduz duplicidade de leitura;
- deixa claro que os sinais estao ligados a areas especificas;
- ajuda o adulto a decidir qual area abrir primeiro;
- preserva a ideia de triagem rapida sem transformar isso em relatorio.

Funcao:

- ser a primeira leitura dentro de Acompanhamento por area;
- mostrar no maximo 3 pistas acionaveis;
- indicar qual area merece ser aberta primeiro;
- reduzir ansiedade com orientacao curta;
- separar sinal positivo, ponto de atencao e proximo passo;
- evitar que o adulto precise interpretar todos os graficos antes de agir.

Nao deve:

- aparecer como bloco principal independente;
- listar todas as atividades;
- repetir todos os graficos;
- virar historico completo;
- conter botao de relatorio completo como acao principal;
- substituir a analise temporal dentro de cada area;
- substituir os cards por area;
- virar Plano dos proximos 7 dias;
- misturar detalhes tecnicos demais;
- fazer conclusoes sem indicar nivel de confianca.

Conteudo esperado:

- 1 sinal positivo, quando existir;
- 1 area que merece observacao, quando existir;
- 1 proximo passo curto;
- indicacao da area que deve ser aberta;
- opcionalmente, um relatorio rapido textual, sem virar documento longo.

Exemplos de intencao:

```text
Tudo caminhando bem. Mantenha a rotina leve e continue observando os proximos registros.
```

```text
Vale olhar Redacao com calma. Ha sinais de que a estrutura do texto ainda precisa de pratica guiada.
```

Exemplo dentro de Acompanhamento por area:

```text
Onde olhar primeiro

1. Tabuada: boa continuidade nas ultimas semanas.
2. Redacao: vale abrir a area antes de aumentar a dificuldade.
3. Interpretacao: ainda ha poucos dados para concluir.

Proximo passo: abra Redacao e observe as evidencias de estrutura do texto.
```

### Relatorio longitudinal

O Relatorio longitudinal nao deve ser um botao solto no topo da tela.
Tambem nao deve ficar como acao principal dentro de Onde olhar primeiro, porque
essa sintese deve ser uma olhada rapida.

Ele deve ser gerado a partir de:

- Onde olhar primeiro;
- Acompanhamento por area;
- ritmo geral de pratica, quando relevante;
- Historico unificado.

A entrada para o relatorio completo deve ficar preferencialmente dentro das
areas de evolucao, com botoes como:

- Ver relatorio completo;
- Gerar relatorio para reuniao;
- Ver evidencias desta area.

O relatorio deve ser uma consequencia da analise, nao um bloco concorrente.

Em Onde olhar primeiro, quando houver algo relacionado a relatorio, deve aparecer
como "relatorio rapido" ou sintese curta, sem exigir que o adulto abra um
documento longo naquele momento.

## Relatorios longitudinais e calendario escolar

### Ponderacao

O acompanhamento diario ou semanal serve para o adulto ajustar a rota.

O relatorio para a familia, especialmente em contexto escolar, nao deve ser
necessariamente mensal. Na realidade da escola, faz mais sentido que o produto
suporte relatorios por ciclos:

- bimestre;
- semestre;
- ano letivo;
- periodo personalizado.

Um relatorio de 30 dias responde:

```text
Como foi este ciclo inicial?
```

Um relatorio semestral ou por 4 bimestres responde:

```text
Qual foi a trajetoria da crianca ao longo do tempo?
```

Esses dois relatorios nao devem ter a mesma estrutura.

### Decisao de produto

O portal deve preservar historico longitudinal continuo, sem se limitar a 30
dias.

As telas podem trazer resumos curtos, mas o banco e a camada de analise devem
estar preparados para recuperar evidencias de meses anteriores e comparar
periodos escolares.

O produto deve suportar, como direcao de arquitetura:

- acompanhamento diario/semanal para professor, nucleo pedagogico ou familia;
- analise mensal interna, quando a escola quiser ajustar a estrategia;
- relatorio bimestral para conversa com responsaveis;
- relatorio semestral para mostrar trajetoria;
- relatorio anual ou por 4 bimestres para consolidar percurso escolar.

### Tipos de relatorio

#### 1. Relatorio rapido do adulto

Uso:

- dentro do portal;
- leitura curta;
- ajuda o adulto a decidir onde olhar primeiro.

Nao deve virar documento formal.

Exemplo de pergunta que responde:

```text
Onde vale prestar atencao agora?
```

#### 2. Relatorio interno da escola

Uso:

- professor;
- coordenacao;
- nucleo de apoio pedagogico;
- revisao de estrategia.

Pode ser mais tecnico, com graficos, evidencias abertas e metricas por area.

Exemplo de pergunta que responde:

```text
A estrategia aplicada neste periodo esta funcionando?
```

#### 3. Relatorio para familia

Uso:

- reuniao com pais ou responsaveis;
- devolutiva bimestral, semestral ou por periodo definido;
- comunicacao cuidadosa, simples e pratica.

Deve traduzir os dados para uma conversa humana.

Nao deve:

- expor excesso de metricas;
- assustar;
- rotular;
- apresentar diagnostico;
- despejar historico completo sem curadoria.

Deve:

- mostrar evidencias selecionadas;
- explicar a trajetoria;
- indicar avancos;
- indicar pontos que ainda pedem continuidade;
- orientar como a familia pode ajudar;
- terminar com proximo passo claro e esperancoso.

#### 4. Relatorio tecnico longitudinal

Uso:

- revisao pedagogica mais profunda;
- conversa com especialistas, quando autorizado;
- auditoria interna;
- evolucao por 4 bimestres ou ano letivo completo.

Pode trazer:

- graficos por area;
- comparacao entre bimestres;
- evolucao de metricas;
- textos representativos;
- feedbacks e artefatos completos;
- observacoes do adulto;
- limites da conclusao.

### Periodos suportados

O produto deve permitir filtrar e gerar analises por:

- ultimos 30 dias;
- ultimos 90 dias;
- bimestre;
- semestre;
- ano letivo;
- periodo personalizado.

Para escola, o conceito de bimestre deve ser configuravel, porque calendarios
podem variar.

No MVP, o produto pode comecar com periodos fixos simples. A evolucao natural
e permitir configurar datas de inicio e fim de cada ciclo escolar.

### Relatorio por bimestre

Funcao:

- mostrar o que foi praticado no ciclo;
- indicar como a crianca respondeu;
- registrar evidencias principais;
- orientar a continuidade no proximo bimestre.

Estrutura recomendada para familia:

1. abertura acolhedora;
2. sintese do bimestre;
3. atividades realizadas por area;
4. sinais de avanco;
5. pontos que ainda pedem apoio;
6. orientacao pratica para casa;
7. proximos passos da escola.

### Relatorio semestral

Funcao:

- mostrar trajetoria, nao apenas volume de tarefas;
- comparar momentos do semestre;
- selecionar evidencias representativas;
- explicar oscilacoes com cuidado;
- orientar a continuidade do acompanhamento.

Estrutura recomendada:

1. sintese do semestre;
2. linha do tempo por meses ou bimestres;
3. evolucao por area;
4. evidencias selecionadas;
5. leitura cuidadosa dos pontos que ainda precisam de apoio;
6. orientacoes para familia;
7. proximos passos do nucleo pedagogico.

### Relatorio por 4 bimestres

O portal deve estar preparado para contar uma trajetoria longa, como no caso
real de uma crianca que pratica Redacao, Leitura, Tabuada e outros modulos ao
longo de todo o ano.

Esse relatorio deve responder:

```text
Onde a crianca estava no inicio?
Que estrategias foram aplicadas?
O que mudou ao longo dos bimestres?
O que ficou mais consistente?
O que ainda precisa de continuidade?
Quais evidencias sustentam essa leitura?
```

Nao deve listar tudo. Deve selecionar evidencias representativas.

Exemplo:

- uma redacao inicial;
- uma redacao intermediaria;
- uma redacao recente;
- sinais de mudanca no processo;
- graficos por area;
- orientacao de continuidade.

### Curadoria de evidencias

O banco deve guardar historico completo.

O relatorio deve selecionar evidencias relevantes.

A IA pode ajudar a selecionar e resumir, mas sempre com rastreabilidade:

```text
Ver evidencias usadas neste relatorio
```

Regras:

- nao omitir dados importantes que contradigam a conclusao;
- nao exagerar avanco com base em poucos registros;
- nao transformar volume de pratica em prova de evolucao;
- separar constancia de pratica de qualidade pedagogica;
- indicar quando a conclusao ainda tem baixa confianca.

### Linguagem do relatorio para familia

O relatorio para familia deve ser tecnico o suficiente para ser defensavel,
mas humano o suficiente para aliviar e orientar.

Preferir:

```text
Pedro Antonio se beneficia de atividades curtas e organizadas por etapas.
```

```text
Em Redacao, os registros mostram que a estrutura ainda precisa de pratica
guiada. O proximo ciclo deve manter foco em comeco, meio e fim.
```

Evitar:

```text
Pedro Antonio nao evoluiu em Redacao.
```

```text
Pedro Antonio tem dificuldade grave.
```

### Papel da IA nos relatorios

A IA deve atuar como organizadora de evidencias e tradutora pedagogica.

Pode:

- resumir a trajetoria;
- comparar periodos;
- selecionar evidencias representativas;
- escrever sintese para familia;
- escrever sintese tecnica para escola;
- sugerir proximos passos;
- indicar quando ainda faltam dados.

Nao pode:

- diagnosticar;
- rotular;
- afirmar causalidade sem base;
- esconder incerteza;
- escrever recomendacoes alarmistas;
- substituir professor, coordenacao ou especialista.

### Requisitos tecnicos derivados

Para suportar relatorios bimestrais, semestrais e por 4 bimestres, o produto
precisa garantir:

- toda evidencia tem `occurred_at` real e confiavel;
- as consultas nao ficam presas apenas as ultimas semanas;
- as telas aceitam filtro de periodo;
- os graficos conseguem comparar periodos longos;
- os artefatos completos ficam preservados;
- redacoes guardam texto, tema, titulo e feedbacks;
- interpretacoes guardam texto, perguntas, respostas e feedbacks;
- tabuadas guardam tabuadas treinadas, tentativas, acertos, erros e tempos;
- ingles guarda habilidade, tipo de exercicio, itens, acertos, erros e apoio;
- relatorios podem apontar quais evidencias foram usadas.

### Acompanhamento por area

Funcao:

- analisar cada area separadamente;
- mostrar como cada area esta evoluindo ao longo do tempo;
- relacionar a evolucao da area com metas ativas ou concluidas;
- considerar desempenho, volume, continuidade, complexidade e consistencia;
- indicar se ha evidencias suficientes para falar em tendencia;
- permitir abrir grafico e evidencias daquela area;
- orientar o proximo passo pedagogico dentro daquele bloco.

Pergunta central:

```text
Como cada area esta evoluindo ao longo do tempo, com base nas evidencias disponiveis?
```

Pergunta complementar obrigatoria quando houver meta:

```text
Esta evolucao aproxima a crianca da meta cadastrada?
```

Ponderacao:

Tempo e area nao podem ser analisados de forma completamente separada.

Uma area pode ter bom desempenho em atividades isoladas, mas pouca pratica no
periodo. Nesse caso, o produto nao deve afirmar evolucao consistente.

Exemplo:

```text
Em Interpretacao, a crianca respondeu bem nas atividades feitas, mas ainda ha poucas evidencias no periodo para afirmar evolucao consistente.
```

Outra area pode ter pratica suficiente e mostrar repeticao do mesmo ponto de
atencao. Nesse caso, a orientacao pode ser mais firme.

Exemplo:

```text
Em Redacao, houve pratica suficiente no periodo e os mesmos sinais apareceram em varias tentativas. Vale manter foco em comeco, meio e fim antes de aumentar a dificuldade.
```

Nao deve:

- separar qualidade pedagogica de volume e continuidade;
- misturar leitura, escrita, matematica e ingles em uma conclusao unica;
- esconder a metrica usada;
- afirmar tendencia sem quantidade minima de evidencias;
- dizer que a crianca evoluiu apenas porque praticou;
- dizer que a crianca nao evoluiu sem considerar se houve pratica suficiente;
- mostrar todos os detalhes de todas as atividades logo no bloco fechado.

Conteudo esperado no topo do bloco:

- **Onde olhar primeiro**;
- ritmo geral de pratica como sinal auxiliar, quando relevante;
- indicacao de areas com poucos dados;
- indicacao de areas que merecem abertura imediata.

Conteudo esperado com cada area fechada:

- nome da area;
- meta relacionada, quando existir;
- leitura da meta;
- tendencia;
- pista curta;
- numero de evidencias;
- distribuicao no tempo;
- periodo observado;
- nivel de confianca.

Conteudo esperado com cada area aberta:

- resumo longitudinal da area;
- leitura da meta relacionada;
- grafico de linha da area ao longo do tempo;
- volume de evidencias no periodo;
- distribuicao das praticas por semana, mes ou bimestre;
- metrica principal;
- sinais observados;
- orientacao para o adulto;
- lista de evidencias recolhidas.

Exemplos fechados:

```text
Redacao
Tendencia estavel
8 evidencias em 4 semanas
Pista: estrutura ainda oscila; abra para ver as redacoes e a orientacao.
```

```text
Interpretacao
Bom desempenho, mas poucos dados
2 evidencias em 8 semanas
Pista: as respostas foram boas, mas ainda nao ha continuidade suficiente para falar em evolucao.
```

```text
Tabuada
Tendencia de alta
10 evidencias distribuidas em 4 semanas
Pista: acertos subiram e o tempo diminuiu com pratica frequente.
```

### Ritmo geral de pratica

O ritmo geral nao deve ser um bloco principal separado.

Ele deve aparecer como sinal auxiliar dentro de **Acompanhamento por area**,
especialmente em **Onde olhar primeiro**.

Funcao:

- indicar se houve pratica distribuidada ou concentrada;
- mostrar se alguma area ficou sem evidencia suficiente;
- apoiar a interpretacao da tendencia por area;
- ajudar o adulto a ajustar a rotina.

Nao deve:

- concluir qualidade pedagogica sozinho;
- substituir a analise por area;
- virar grafico grande concorrente;
- listar todas as atividades.

Exemplo:

```text
Houve pratica em 3 de 4 semanas. Tabuada teve boa continuidade; Redacao teve poucas evidencias para concluir evolucao consistente.
```

### Leitura da meta

Funcao:

- fechar o ciclo entre meta, missao e evidencia;
- ajudar o adulto a perceber se a estrategia esta funcionando;
- indicar quando manter, ajustar, reduzir ou encerrar uma meta;
- evitar que metas continuem ativas por inercia quando ja ha sinais de avanco;
- evitar que uma estrategia sem efeito continue sendo repetida sem ajuste.

Pergunta que responde:

```text
As evidencias aproximam a crianca da meta cadastrada?
```

Estados sugeridos:

- **sem meta ativa:** ha evidencias na area, mas nenhuma meta atual vinculada;
- **sem evidencias suficientes:** a meta existe, mas ainda faltam registros para comparar;
- **em construcao:** ha pratica e alguns sinais, mas ainda e cedo para decidir;
- **bem encaminhada:** os registros recentes apontam aproximacao da meta;
- **precisa de ajuste:** houve pratica suficiente, mas os sinais nao caminham na direcao esperada;
- **pronta para conclusao:** ha sinais consistentes de que a meta pode ser concluida como foco principal.

Exemplo:

```text
Meta: organizar redacoes com comeco, meio e fim.
Leitura da meta: bem encaminhada.
Sinais: as redacoes recentes mostram estrutura mais clara que os primeiros registros.
Proximo passo: considerar encerrar esta meta como foco principal e criar uma meta menor, como melhorar frases de transicao.
```

Regras:

- nao declarar "meta alcancada" sem mostrar evidencias;
- nao encerrar meta automaticamente;
- sempre mostrar as evidencias usadas;
- separar pratica frequente de melhoria real;
- considerar periodo, volume, tendencia e complexidade;
- quando houver duvida, orientar observacao por mais algumas atividades curtas.

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

- em Onde olhar primeiro: "Redacao merece atencao nesta semana";
- no card de Redacao em Acompanhamento por area: "Redacao esta estavel, com estrutura oscilando";
- no Historico unificado: "Redacao 4, texto completo, feedback e metricas".

O mesmo dado pode aparecer em camadas diferentes, mas nao deve gerar a mesma leitura repetida.

## Modelo de tela

### Visao geral recolhida

Cada bloco deve aparecer recolhido por padrao.

Com o bloco fechado, o adulto deve ver apenas:

- nome do bloco;
- meta relacionada, quando existir;
- leitura curta da meta;
- tendencia;
- pista curta;
- quantidade de evidencias;
- periodo observado;
- nivel de confianca.

Exemplo:

```text
Redacao
Tendencia estavel
Meta: organizar comeco, meio e fim
Leitura da meta: ainda em construcao
8 evidencias em 4 semanas
Pista: estrutura ainda oscila; vale manter roteiro de comeco, meio e fim.
```

Outro exemplo:

```text
Tabuada
Tendencia de alta
Meta: ganhar seguranca na tabuada do 6
Leitura da meta: bem encaminhada
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
2. meta relacionada, quando existir;
3. leitura da meta;
4. grafico de linha;
5. metrica principal usada;
6. sinais observados;
7. orientacao para o adulto;
8. lista de evidencias recolhidas;
9. acao sugerida.

Exemplo de estrutura:

```text
Redacao

Resumo:
Ha pratica frequente, mas a estrutura ainda nao mostra avanco consistente.

Meta relacionada:
Organizar redacoes com comeco, meio e fim.

Leitura da meta:
Ainda em construcao. As evidencias mostram pratica suficiente, mas os sinais de estrutura ainda oscilam.

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
4. Adulto abre Acompanhamento por area para ver Onde olhar primeiro e analisar leitura, escrita, matematica, ingles ou futuros modulos ao longo do tempo.
5. Dentro de cada area, adulto observa tendencia, volume de evidencias, distribuicao no tempo, nivel de confianca e orientacao.
6. Quando houver meta relacionada, adulto ve a leitura da meta: bem encaminhada, em construcao, precisa de ajuste, pronta para conclusao ou sem evidencias suficientes.
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
- cada bloco fechado mostrar leitura da meta quando houver meta relacionada;
- cada bloco aberto mostrar grafico de linha;
- cada bloco aberto mostrar como as evidencias conversam com a meta;
- cada conclusao tiver evidencias abertas;
- Redacao mostrar texto produzido;
- Tabuada mostrar tabuadas treinadas;
- Interpretacao mostrar texto, perguntas e respostas quando disponiveis;
- Ingles mostrar habilidade, apoio e erros frequentes;
- o portal diferenciar alta, estabilidade, baixa e dados insuficientes;
- o portal diferenciar meta bem encaminhada, em construcao, precisa de ajuste, pronta para conclusao e sem evidencias suficientes;
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

### Caso 5: meta bem encaminhada

Crianca com meta ativa e evidencias recentes apontando melhora consistente na
habilidade esperada.

Esperado:

- leitura da meta como bem encaminhada ou pronta para conclusao;
- sugestao de considerar fechamento da meta como foco principal;
- orientacao para concluir a meta ou criar meta menor;
- evidencias abertas sustentam a leitura.

### Caso 6: meta sem efeito claro

Crianca com meta ativa, pratica suficiente e sinais estaveis ou desalinhados
com a habilidade esperada.

Esperado:

- leitura da meta como precisa de ajuste ou ainda em construcao;
- texto cuidadoso, sem dizer que a crianca fracassou;
- sugestao de reduzir tarefa, mudar estrategia ou observar mais algumas tentativas;
- evidencias abertas mostram a base da orientacao.

## Questoes abertas

- Qual sera a metrica principal definitiva da Redacao?
- A analise deve considerar idade automaticamente?
- Como o professor podera anexar observacoes sem expor percepcoes privadas para a crianca?
- Quando uma tendencia estavel deve sugerir nova estrategia?
- Quantas evidencias sao necessarias para acionar uma orientacao mais firme?
- Como validar os textos com especialista pedagogico/psicologico antes de producao?
- Como configurar o calendario escolar de cada escola?
- O relatorio para familia deve ser gerado por bimestre, semestre ou ambos?
- Quais evidencias devem ser selecionadas automaticamente pela IA em um relatorio longo?
- Como permitir que a escola revise o relatorio antes de apresentar aos pais?

## Proximos passos

1. Auditar se o banco e as APIs preservam evidencias por periodo longo.
2. Confirmar se as telas atuais consultam apenas ultimas semanas ou todo o historico.
3. Definir filtros de periodo: 30 dias, 90 dias, bimestre, semestre, ano letivo e periodo personalizado.
4. Refinar este PRD disciplina por disciplina.
5. Definir o contrato final de `metrics` e `artifacts` por modulo.
6. Criar massa de teste neutra distribuida por bimestre e semestre, sem conclusoes plantadas.
7. Desenhar mockup do relatorio para familia.
8. Desenhar mockup do relatorio tecnico da escola.
9. Implementar o painel por blocos.
10. Implementar grafico por bloco e por periodo.
11. Implementar "ver evidencias desta conclusao".
12. Implementar geracao de relatorio longitudinal com IA, sempre com revisao pelo adulto.
13. Testar com Jose Carlos e Pedro Antonio.
14. Depois testar com dados reais de Miguel e Gabriel, sem misturar com massa demo.
