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
