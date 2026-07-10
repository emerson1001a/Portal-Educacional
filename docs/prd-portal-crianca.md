# PRD: Portal da Crianca

## Contexto

O Portal da Crianca e a area de execucao das atividades liberadas pelo adulto. Ele existe para passar o bastao para a crianca sem expor percepcoes, metas sensiveis, relatorios tecnicos ou orientacoes adultas.

O MVP ja existe em `apps/portal/child.html`, usando token infantil gerado pelo adulto e endpoint `/api/child-session`.

## Ponderacao de produto

O Portal da Crianca nao deve ser uma copia simplificada do painel adulto. Ele tem outra funcao:

- reduzir ruido;
- mostrar apenas a proxima atividade;
- manter linguagem positiva;
- preservar autoestima;
- devolver evidencias ao adulto sem carregar a crianca com leitura tecnica.

Gamificacao pode entrar no futuro, mas deve reforcar processo, persistencia e revisao, nao ranking ou pressao por desempenho.

## Objetivo

Definir o comportamento esperado da area infantil para as proximas iteracoes.

O Portal da Crianca deve permitir que a crianca:

- reconheca que esta no ambiente dela;
- veja missoes liberadas;
- entenda uma instrucao curta;
- abra o modulo certo;
- volte para a area infantil depois de concluir;
- receba mensagens simples e positivas.

## Fora de escopo

Esta etapa nao inclui:

- conta propria da crianca;
- PIN infantil;
- ranking;
- loja de recompensas;
- notificacoes;
- chat livre com IA;
- relatorio infantil detalhado;
- conteudo sensivel do adulto.

## Principios

1. A crianca ve apenas o que foi liberado para ela.
2. A crianca nao ve observacoes adultas, metas internas ou preocupacoes familiares.
3. A crianca nao deve receber linguagem de diagnostico, comparacao ou culpa.
4. A atividade deve parecer curta e possivel.
5. O retorno ao adulto acontece por evidencias, nao por exposicao da crianca ao painel adulto.
6. Quando nao houver missao, a tela deve explicar com calma e pedir apoio do adulto.

## Fluxo principal

1. Adulto entra no portal autenticado.
2. Adulto seleciona uma crianca.
3. Adulto cria ou libera uma missao.
4. Adulto gera link infantil.
5. Crianca abre `child.html?token=...`.
6. Portal valida o token em `/api/child-session`.
7. Crianca ve missoes e itens liberados.
8. Crianca abre um modulo.
9. Modulo recebe `portal_child_token`, `child_id`, `child_name` e `portal_return_url`.
10. Modulo registra resultado via `/api/activity-events`.
11. Adulto ve a evidencia no historico unificado.

## Modelo de acesso

### MVP atual

O acesso infantil acontece por link com token.

O token:

- e gerado por adulto autorizado;
- fica salvo no banco apenas como hash;
- pode representar area infantil geral ou uma tarefa especifica;
- deve ser validado server-side.

Decisao de expiracao:

- `child_area`: 24 horas por padrao, maximo de 72 horas;
- `assignment`: 72 horas por padrao, maximo de 7 dias;
- `module_return`: escopo tecnico futuro, recomendado em 2 horas.

Documento de referencia:

- `docs/decisao-token-infantil.md`.

### Codigo curto

Decisao:

- a crianca podera usar codigo curto no futuro;
- o codigo curto sera temporario e ligado a missao, sessao ou sala;
- o codigo curto nao sera login infantil permanente nesta fase;
- link infantil continua sendo o caminho principal no MVP.

Motivo:

- link e melhor para criancas pequenas e uso em casa;
- codigo curto e melhor para criancas maiores e sala de aula;
- PIN infantil fica como possibilidade futura, apenas se a rotina real justificar.

Documento de referencia:

- `docs/decisao-codigo-curto-infantil.md`.

### Decisoes futuras

Ainda esta pendente decidir se criancas maiores tambem usarao:

- PIN;
- conta propria;
- link individual recorrente;
- combinacao de link, codigo e PIN.

## Informacoes permitidas para a crianca

Permitido:

- nome da crianca;
- titulo da missao;
- instrucao infantil;
- nome do modulo;
- descricao simples do modulo;
- botao de comecar;
- mensagem positiva de estado vazio.

Nao permitido:

- percepcao do adulto;
- hipotese pedagogica;
- preocupacao familiar;
- comentario como "tem dificuldade em";
- relatorio longitudinal;
- feedback adulto completo;
- notas privadas;
- informacao comercial ou de plano.

## Missoes

Uma missao infantil deve ter:

- titulo curto;
- instrucao positiva;
- um ou mais itens;
- modulo associado;
- status.

Exemplo de titulo bom:

- "Treino de leitura de hoje"
- "Uma redacao pequena"
- "Tabuada com calma"

Evitar:

- "Corrigir sua dificuldade"
- "Resolver seu problema de atencao"
- "Melhorar porque voce esta ruim"

## Modulos livres

O MVP atual pode exibir modulos livres quando nao ha missao especifica.

Ponderacao:

Isso ajuda testes e criancas pequenas, mas no produto final o ideal e priorizar missoes liberadas pelo adulto. Modulos livres devem ser configuraveis por conta ou por decisao pedagogica.

## Feedback infantil

O feedback da crianca deve:

- reconhecer tentativa;
- destacar uma conquista pequena;
- indicar uma proxima acao concreta;
- evitar notas, comparacoes ou julgamento global.

Formato recomendado:

```text
Voce terminou esta etapa.
Agora vamos tentar melhorar uma parte pequena.
```

## Feedback adulto

O feedback adulto nao aparece no Portal da Crianca.

Ele deve ir para:

- historico unificado;
- resumo do desenvolvimento;
- relatorio longitudinal;
- orientacao de proximos passos.

## Gamificacao futura

Gamificacao e desejavel, mas apenas como camada leve de progresso pessoal.

Permitido:

- trilha de passos;
- selos de esforco;
- conquistas por revisao;
- celebracao de persistencia;
- sequencia flexivel;
- colecao simbolica sem competicao.

Evitar:

- ranking;
- comparacao entre criancas;
- punicao por erro;
- perda de recompensa por falhar um dia;
- loja de moedas como foco principal;
- estimulo a fazer rapido demais.

Regra:

Gamificacao deve reforcar comportamento de aprendizagem, nao desempenho isolado.

## Estados da interface

### Token ausente

Mensagem:

```text
Peça para um adulto abrir sua atividade novamente.
```

### Token invalido ou expirado

Mensagem:

```text
Este link nao esta disponivel agora. Peça ajuda para um adulto.
```

### Sem missao

Mensagem:

```text
Nenhuma missao disponivel no momento.
Quando houver uma missao, ela aparecera aqui.
```

### Com missao

Mostrar:

- saudacao;
- titulo da missao;
- instrucao;
- itens;
- botao `Comecar`.

## Criterios de aceite

- A crianca consegue abrir a area infantil por token valido.
- A tela nao exibe nenhum conteudo adulto sensivel.
- Missoes liberadas aparecem com linguagem infantil.
- Itens de missao abrem modulos com token de retorno.
- Modulos conseguem devolver evidencias para o portal.
- Quando nao ha missao, a tela orienta com calma.
- A experiencia infantil nao mostra ranking, desempenho comparativo ou informacao comercial.

## Proximas etapas

1. Revisar estados visuais do `child.html`.
2. Projetar a entrada infantil por codigo curto.
3. Definir se crianca maior precisara de PIN em etapa posterior.
4. Evoluir missao simples para plano de tarefas com prazo e status por item.
5. Especificar primeira camada de gamificacao leve.
6. Unificar visual infantil entre portal, redacao, leitura e tabuada.
