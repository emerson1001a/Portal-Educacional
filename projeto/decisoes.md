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
