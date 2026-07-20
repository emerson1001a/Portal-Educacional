# Decisoes do Projeto

## 2026-07-09

### Criar pasta de projeto

Decisao:

- criar `projeto/` como painel de acompanhamento;
- manter `docs/` como fonte oficial de PRDs, arquitetura e regras.

Motivo:

- facilitar retomada em janelas sucessivas do Codex;
- evitar que o trabalho fique espalhado;
- separar gestao do trabalho de documentacao formal.

### Etapa 1 com PRD proprio

Decisao:

- fechar a matriz de papeis em `docs/prd-matriz-de-papeis.md`.

Motivo:

- a matriz precisa virar base da Etapa 2;
- permissoes devem ser decididas antes de banco, telas e endpoints.

### Etapa 2 começa por PRD tecnico

Decisao:

- antes de alterar `supabase/schema.sql`, criar `docs/prd-controle-de-acesso-supabase.md`.

Motivo:

- o schema atual funciona para o portal inicial, mas ainda nao cobre professor, turma, token infantil, classificacao de informacao e compartilhamento;
- mudar banco sem PRD aumentaria risco de quebrar o portal atual.

### Migracao incremental em vez de reescrever schema

Decisao:

- criar `supabase/migrations/20260709_access_control_foundation.sql`;
- manter `supabase/schema.sql` como base inicial por enquanto.

Motivo:

- evitar quebrar o portal ja publicado;
- permitir revisar e rodar a migracao manualmente no Supabase;
- preservar dados existentes.

### Token infantil com hash

Decisao:

- a tabela `child_access_tokens` guarda `token_hash`, nao o token puro.

Motivo:

- se houver vazamento de banco, o link/codigo infantil nao fica exposto diretamente;
- a validacao do token deve acontecer em endpoint server-side.

### APIs infantis antes da tela

Decisao:

- criar primeiro `/api/child-access-token` e `/api/child-session`;
- deixar a interface infantil para uma etapa seguinte.

Motivo:

- a tela infantil depende da migracao no Supabase;
- os endpoints permitem testar seguranca e escopo antes de mexer na experiencia visual.

### Primeira area infantil separada

Decisao:

- criar `apps/portal/child.html` como primeira tela infantil independente do painel adulto.

Motivo:

- a crianca deve acessar apenas tarefas liberadas por token;
- a tela nao deve consultar nem exibir percepcoes privadas, feedback adulto ou relatorio tecnico.

### Link infantil gerado pelo adulto

Decisao:

- adicionar no painel adulto um botao para gerar link infantil temporario;
- manter o modo infantil embutido como apoio para criancas pequenas no mesmo aparelho;
- tratar codigo curto ou login proprio da crianca como evolucao posterior.

Motivo:

- o adulto continua controlando quando passa o bastao;
- a crianca acessa apenas a area infantil, sem ver percepcoes privadas;
- o fluxo serve tanto para casa quanto para professor enviando atividade em outro aparelho.

### Missao simples antes do planejador completo

Decisao:

- criar no painel adulto uma forma simples de liberar missao com titulo, orientacao e modulos;
- gravar a missao como `released` para aparecer imediatamente no link infantil;
- deixar prazo, metas vinculadas, status por item e recomendacao automatica para uma evolucao posterior.

Motivo:

- permitir teste real com crianca sem esperar o planejador completo;
- manter o caminho pedagogico correto: adulto escolhe o foco, crianca recebe apenas a tarefa;
- reduzir risco de misturar percepcao adulta com a experiencia infantil.

### Plataforma com modulos plugaveis

Decisao:

- tratar o Portal Educacional como plataforma de evolucao educacional com modulos plugaveis;
- registrar `docs/prd-modulos-plugaveis.md` como referencia para catalogo, jornadas e futuro modelo comercial;
- considerar Ingles e outros dominios como modulos futuros, sem implementar agora;
- priorizar a linguagem de jornadas de apoio em vez de "pacotes de dificuldade".

Motivo:

- permitir crescimento futuro sem refazer a arquitetura;
- manter o historico longitudinal como centro de valor;
- abrir caminho para habilitacao ou venda por modulo no futuro;
- evitar que o produto rotule a crianca ou venda medo ao adulto.

## 2026-07-10

### PRD do Portal da Crianca

Decisao:

- fechar `docs/prd-portal-crianca.md`;
- manter a area infantil como ambiente separado, positivo e sem conteudo sensivel adulto;
- tratar gamificacao como camada futura de progresso pessoal, nao como ranking ou pressao por desempenho.

Motivo:

- a area infantil ja existe em MVP e precisa de criterio formal para evoluir;
- a crianca deve receber apenas missoes e instrucoes adequadas;
- o adulto continua sendo quem organiza metas, interpreta evidencias e recebe orientacao completa.

### PRD de metas e tarefas

Decisao:

- fechar `docs/prd-metas-e-tarefas.md`;
- separar meta adulta, tarefa e missao infantil;
- manter a percepcao original e notas adultas fora da area da crianca;
- usar tarefas como ponte entre metas, modulos e evidencias longitudinais.

Motivo:

- meta e ferramenta do adulto, nao cobranca para a crianca;
- a crianca precisa receber apenas uma instrucao curta, positiva e executavel;
- o historico longitudinal depende de evidencias conectadas a metas e tarefas;
- o proximo passo tecnico deve revisar schema e interface contra esse PRD.

### Migracao incremental da Etapa 5

Decisao:

- criar `docs/analise-schema-etapa-5.md`;
- criar `supabase/migrations/20260710_goals_assignments_alignment.sql`;
- criar `supabase/tests/20260710_goals_assignments_smoke.sql`;
- preservar `owner_id` em `learning_goals` por compatibilidade com o app atual;
- ampliar status e metadados sem reescrever tabelas existentes.

Motivo:

- a fundacao de acesso ja criou tarefas e itens;
- o PRD de metas e tarefas pede refinamentos, nao uma reescrita;
- migracao pequena reduz risco de quebrar o portal publicado;
- os testes manuais no Supabase precisam indicar claramente o que deve aparecer como `ok`.

### Expiracao e escopo do token infantil

Decisao:

- `child_area` expira em 24 horas por padrao, com maximo de 72 horas;
- `assignment` expira em 72 horas por padrao, com maximo de 7 dias;
- `module_return` fica como escopo tecnico futuro recomendado em 2 horas;
- token infantil continua sem acesso adulto e com hash salvo no banco.

Motivo:

- link geral infantil deve ser curto porque abre a area da crianca;
- link de missao precisa caber em rotina familiar ou escolar durante a semana;
- retorno tecnico de modulo deve ser curto e invisivel para a crianca;
- a decisao esta documentada em `docs/decisao-token-infantil.md`.

### Codigo curto infantil temporario

Decisao:

- manter link infantil como caminho principal;
- adicionar codigo curto como alternativa futura para criancas maiores, sala de aula e missoes especificas;
- tratar codigo curto como acesso temporario, nao como login infantil permanente;
- deixar PIN infantil como decisao futura, caso a rotina real mostre necessidade.

Motivo:

- link atende melhor criancas pequenas e uso familiar;
- codigo curto ajuda professor, turma e criancas que digitam sozinhas;
- conta ou senha infantil permanente criaria complexidade de privacidade e suporte cedo demais;
- a decisao esta documentada em `docs/decisao-codigo-curto-infantil.md`.

### Preparacao de banco para codigo curto

Decisao:

- reutilizar `child_access_tokens` para codigo curto;
- adicionar `access_code_hash` e campos auxiliares, sem salvar o codigo puro;
- manter a validade e revogacao no mesmo modelo do token infantil.

Motivo:

- codigo curto deve ser alias humano de um acesso limitado;
- criar outra tabela de permissao aumentaria risco de divergencia;
- a preparacao tecnica esta documentada em `docs/analise-codigo-curto-infantil.md`.

### API de codigo curto sem quebrar link atual

Decisao:

- evoluir `/api/child-access-token` para gerar codigo curto apenas quando solicitado;
- criar `/api/child-code-session` para resolver codigo curto;
- manter o fluxo atual por link intacto antes da migracao ser aplicada.

Motivo:

- o portal publicado nao deve quebrar se a coluna nova ainda nao existir;
- codigo curto depende de migracao no Supabase;
- a entrada por codigo deve devolver apenas dados seguros da area infantil.

### Painel adulto com link e codigo curto progressivo

Decisao:

- o botao adulto de acesso infantil solicita link e codigo curto;
- quando a migracao esta aplicada, o adulto ve os dois;
- quando a migracao ainda nao esta aplicada, o adulto recebe o link e uma mensagem informando que o codigo curto depende do Supabase.

Motivo:

- evita publicar uma interface quebrada antes da migracao;
- permite testar em producao de forma incremental;
- preserva o fluxo atual por link, que ja funciona.

### Entrada infantil por codigo redireciona para a area infantil

Decisao:

- criar `apps/portal/entrar.html` como pagina simples para a crianca digitar o codigo;
- resolver o codigo em `/api/child-code-session`;
- gerar um token tecnico temporario e redirecionar para `child.html?token=...`;
- manter a execucao das missoes no `child.html`.

Motivo:

- os modulos ja esperam `portal_child_token`;
- o codigo curto nao deve circular dentro dos modulos;
- reaproveitar `child.html` evita duplicar logica infantil e reduz risco de divergencia.

## 2026-07-11

### Missao adulta com meta, prazo e progresso

Decisao:

- evoluir a missao simples para aceitar meta vinculada, prazo e nota adulta;
- manter `child_title` e `child_instructions` como a unica parte visivel para a crianca;
- mostrar no painel adulto o progresso por item, usando evidencias dos modulos quando existirem.

Motivo:

- o adulto precisa saber por que liberou aquela missao e o que observar;
- a crianca nao deve ver hipotese, preocupacao ou nota adulta;
- progresso por item aproxima a missao do historico longitudinal sem criar relatorio pesado cedo demais.

### Atividade infantil concluida permanece reconhecida

Decisao:

- quando um modulo entrega uma evidencia com `assignment_item_id`, o portal marca o item como concluido;
- a area infantil mostra o item concluido como "Feita" e mantem as atividades pendentes acima;
- uma missao inteira concluida pode aparecer como concluida, em vez de continuar parecendo tarefa ativa.
- atividades livres podem continuar disponiveis, mas devem aparecer separadas da missao, com texto claro de que sao extras opcionais.

Motivo:

- a crianca precisa perceber que terminou uma parte da missao;
- apagar a atividade sem reconhecimento pode reduzir a sensacao de progresso;
- manter o estado concluido ajuda o adulto a entender o caminho sem poluir a lista de pendencias.
- sem essa separacao, uma atividade livre pode parecer uma tarefa que ficou pendente, mesmo quando o combinado ja foi cumprido.

## 2026-07-12

### Painel atual como central operacional

Decisao:

- criar `projeto/painel-atual.md` como primeira leitura para retomar o projeto;
- atualizar `projeto/README.md`, `projeto/roadmap.md` e `projeto/backlog.md` para refletir o MVP atual;
- manter `docs/` como fonte formal de PRDs, regras pedagogicas e setup;
- manter `projeto/` como painel de trabalho vivo.

Motivo:

- reduzir dependencia de memoria informal;
- permitir que novas janelas do Codex retomem o contexto certo;
- evitar backlog desatualizado apontando para etapas que ja evoluiram;
- proteger as decisoes pedagogicas centrais enquanto o produto cresce por modulos.

### Painel administrativo sem acesso pedagogico individual

Decisao:

- o painel administrativo do negocio deve trabalhar com dados operacionais, planos, cobranca, uso, suporte e metricas agregadas;
- admin do negocio nao acessa dados pedagogicos individuais, textos, percepcoes, feedbacks privados, relatorios individuais ou dados pessoais sensiveis;
- o produto pode usar analytics anonimo/agregado para entender evolucao, dificuldade e efetividade por modulo;
- qualquer consulta identificavel de crianca, adulto, turma ou escola exige autorizacao explicita dos responsaveis legais ou da escola autorizada, alem de auditoria.

Motivo:

- proteger a confianca de pais, criancas, professores e escolas;
- permitir melhoria do produto sem invadir a privacidade pedagogica;
- evitar que `admin` vire permissao ampla sobre dados sensiveis;
- alinhar a arquitetura futura com privacidade, LGPD e minimo acesso necessario.

## 2026-07-14

### Sinais da missao cuidam da crianca e do adulto

Decisao:

- criar `docs/prd-sinais-da-missao.md` para padronizar tempo invisivel, autoavaliacao leve da crianca e leitura combinada pela IA;
- a crianca pode responder opcionalmente como foi a missao, com linguagem visual ou simples conforme idade;
- o tempo de execucao deve ser registrado sem cronometro visivel para a crianca;
- a IA pode combinar sinais para orientar o adulto, mas nao diagnosticar nem julgar a crianca;
- o adulto deve receber indicadores reais com orientacao esperancosa, pratica e cuidadosa;
- a crianca deve receber devolutiva curta, positiva e animadora sobre seu progresso.

Motivo:

- aprendizagem acontece na relacao entre crianca, adulto, tentativa, orientacao e constancia;
- os indicadores ajudam, mas podem gerar ansiedade se vierem sem contexto;
- o produto deve cuidar da confianca do adulto e da percepcao de progresso da crianca;
- autoavaliacao e tempo so fazem sentido quando cruzados com historico, idade, tentativas, acertos e conclusao da missao;
- o portal deve organizar sinais, nao transformar dificuldade em rotulo.

## 2026-07-18

### Produto unico com modos Familia e Escola

Decisao:

- nao duplicar o produto neste momento;
- preservar um nucleo comum de crianca, adulto, missoes, evidencias e analise longitudinal;
- evoluir a experiencia com dois modos de uso: Familia e Escola;
- seguir refinando o produto sem destruir a futura vertente escolar;
- usar a tela atual como prototipo escolar funcional para validacao com escola, deixando claro que ainda faltam turma, papeis escolares, relatorios por turma e implantacao dedicada.

Motivo:

- a versao escolar ja esta avancada porque metas, missoes, evidencias, historico e relatorio longitudinal fazem sentido para escola;
- a versao familia precisa de linguagem e fluxo mais simples, mas deve usar o mesmo motor;
- duplicar agora aumentaria manutencao e risco de divergencia entre modulos;
- um marco Git foi criado para preservar o ponto atual antes dessa decisao.

### Relatorios longitudinais por calendario escolar

Decisao:

- o portal deve guardar historico continuo, nao apenas ultimos 30 dias;
- o relatorio para familia em contexto escolar deve poder ser bimestral, semestral, anual ou por periodo personalizado;
- o acompanhamento mensal pode existir como uso interno da escola ou do adulto, mas nao deve ser o unico formato de devolutiva aos pais;
- a IA deve ajudar a organizar evidencias e escrever sinteses cuidadosas, sempre sem diagnosticar, rotular ou substituir professor/especialista;
- relatorios longos devem selecionar evidencias representativas, e nao listar tudo;
- toda conclusao deve permitir rastrear quais evidencias foram usadas.

Motivo:

- escolas trabalham por ciclos, bimestres, semestres e ano letivo;
- familias precisam de uma devolutiva clara, curta e orientadora, nao de uma descarga de metricas;
- a forca do produto esta em contar a trajetoria da crianca em relacao a ela mesma ao longo do tempo;
- casos reais como acompanhamento por 4 bimestres exigem banco, telas e relatorios preparados para periodos longos.

### Tempo incorporado ao Acompanhamento por area

Decisao:

- retirar `Sinais principais` como bloco independente do painel adulto;
- preservar sua funcao como sintese curta dentro de `Acompanhamento por area`;
- renomear essa sintese operacionalmente para `Onde olhar primeiro`;
- usar `Onde olhar primeiro` para indicar, em ate 3 pistas, qual area o adulto deve abrir primeiro;
- retirar `Evolucao no tempo` como bloco principal separado;
- tratar tempo, volume e continuidade como dimensoes obrigatorias dentro da analise de cada area;
- usar ritmo geral de pratica apenas como sinal auxiliar dentro de `Acompanhamento por area`;
- manter `Historico unificado` separado, porque ele e auditoria das evidencias.

Motivo:

- `Sinais principais` como bloco proprio ficava com proposito pouco claro;
- a funcao real dele e uma triagem por area, nao um resumo geral do desenvolvimento;
- separar `tempo` e `area` em blocos independentes deixa a analise pedagogica incompleta;
- a evolucao de uma disciplina depende de desempenho, quantidade de evidencias, distribuicao no tempo e consistencia;
- colocar essa sintese dentro de `Acompanhamento por area` reduz duplicidade e deixa o painel mais limpo;
- o adulto continua recebendo uma orientacao curta, mas ligada diretamente aos blocos que sustentam a analise.

## 2026-07-20

### PRD do Relatorio para Reuniao com Pais

Decisao:

- criar `docs/prd-relatorio-reuniao-pais.md` como documento proprio;
- tratar o relatorio como uma saida revisavel para conversa com a familia, e nao como copia do painel adulto;
- permitir relatorios por ultimos 30 dias, bimestre, semestre, ano letivo ou periodo personalizado;
- gerar a primeira versao a partir do `Acompanhamento por area`, preservando rastreabilidade das evidencias;
- exigir revisao humana antes de qualquer compartilhamento com a familia;
- manter linguagem acolhedora, sem diagnostico, rotulo ou comparacao com outras criancas;
- incluir orientacoes praticas para casa e proximos passos da escola.

Motivo:

- reuniao com pais exige comunicacao diferente do painel operacional;
- a familia precisa entender a trajetoria da crianca com clareza, cuidado e evidencias;
- a escola precisa de um material defensavel, revisavel e adequado para conversa;
- o produto deve ajudar o adulto a sair da ansiedade para um plano simples de continuidade;
- periodos escolares reais exigem bimestre, semestre e ano letivo, nao apenas ultimas semanas.

### Revisao critica antes de seguir instrucoes

Decisao:

- nenhuma instrucao de produto deve ser executada automaticamente se contrariar a logica pedagogica, a privacidade da crianca, a clareza para o adulto ou a arquitetura sustentavel;
- quando uma ideia parecer arriscada, confusa ou desalinhada, o projeto deve devolver uma ponderacao antes de implementar;
- criticas devem ser feitas com proposta alternativa, e nao apenas como bloqueio;
- a experiencia real com criancas e adultos tem prioridade sobre suposicoes de tela bonita ou arquitetura elegante.

Motivo:

- o produto lida com criancas, pais, professores e dados sensiveis;
- uma decisao errada pode gerar ansiedade, exposicao indevida ou conclusoes fracas;
- o objetivo e construir um portal que alivie e oriente, nao que apenas cumpra comandos;
- a qualidade do produto depende de testar ideias contra a logica pedagogica e a rotina real.

### Mapa de infraestrutura antes do codigo longitudinal

Decisao:

- criar `docs/analise-infra-relatorios-longitudinais.md`;
- mapear banco, APIs, contratos de modulo, permissoes, relatorios, IA, auditoria e sequencia segura antes de implementar;
- preservar `activity_events` como fonte central de evidencias;
- evitar criar relatorio final antes de consolidar contrato de evidencias e Acompanhamento por area;
- priorizar uma implementacao em camadas: contrato de evidencias, periodos, analise por area, tela, relatorio rascunho e exportacao.

Motivo:

- os PRDs recentes mudaram a profundidade do produto;
- relatorios bimestrais, semestrais e anuais exigem infraestrutura mais robusta;
- a IA precisa trabalhar com evidencias rastreaveis, nao com texto solto;
- uma revisao previa reduz risco de retrabalho, vazamento de dados adultos e conclusoes sem base.

### Contrato de evidencias por modulo

Decisao:

- atualizar `modules/module-contract.md` como fonte oficial do contrato de evidencias;
- exigir campos comuns de `metrics`, `feedback` e `artifacts` para qualquer modulo;
- definir campos especificos para Redacao, Interpretacao, Tabuada e Ingles;
- considerar uma evidencia completa apenas quando ela permitir auditoria futura;
- permitir que atividades incompletas aparecam no Historico unificado, mas com baixa confianca para conclusoes longitudinais;
- manter separacao rigorosa entre feedback da crianca e feedback do adulto.

Motivo:

- a analise longitudinal depende de dados comparaveis ao longo do tempo;
- relatorios para pais precisam de evidencias concretas e rastreaveis;
- cada modulo deve continuar livre na experiencia, mas padronizado na entrega de dados;
- sem contrato, a IA e o painel podem gerar conclusoes bonitas, mas fracas;
- a crianca deve receber apenas feedback positivo e seguro, enquanto o adulto recebe orientacao completa.
