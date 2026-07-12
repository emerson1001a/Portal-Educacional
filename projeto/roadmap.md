# Roadmap de Trabalho

## Etapa 1: Matriz de papeis

Status: fechada

Objetivo:

- definir responsavel, professor, crianca/aluno e admin;
- mapear permissoes;
- bloquear acesso infantil a conteudo adulto;
- preparar base para Supabase.

Documento:

- `docs/prd-matriz-de-papeis.md`

## Etapa 2: Controle de acesso e Supabase

Status: implementada em base incremental

Objetivo:

- transformar a matriz de papeis em tabelas, vinculos e politicas RLS.

Documento planejado:

- `docs/prd-controle-de-acesso-supabase.md`

## Etapa 3: PRD do Portal da Crianca

Status: fechada em PRD

Objetivo:

- definir acesso infantil por abertura do adulto, link ou codigo;
- definir lista de tarefas;
- definir feedback seguro;
- definir retorno ao portal adulto.

Documento:

- `docs/prd-portal-crianca.md`

## Etapa 4: PRD de metas e tarefas

Status: fechada em PRD

Objetivo:

- transformar percepcao do adulto em meta;
- transformar meta em tarefa;
- liberar tarefa para modulos.

Documento:

- `docs/prd-metas-e-tarefas.md`

## Etapa 5: Banco de dados

Status: base atual em uso; migracoes incrementais documentadas

Objetivo:

- implementar schema;
- aplicar policies;
- testar permissoes.

Documentos:

- `docs/analise-schema-etapa-5.md`
- `supabase/migrations/20260710_goals_assignments_alignment.sql`
- `supabase/tests/20260710_goals_assignments_smoke.sql`
- `docs/analise-codigo-curto-infantil.md`
- `supabase/migrations/20260710_child_short_codes.sql`
- `supabase/tests/20260710_child_short_codes_smoke.sql`

## Etapa 6: Interface do adulto

Status: MVP em uso

Objetivo:

- organizar telas de criancas, metas, tarefas, evidencias e relatorios.

Proximo foco:

- reduzir excesso visual por blocos recolhiveis;
- melhorar historico unificado;
- transformar feedback dos modulos em relatorio longitudinal claro.

## Etapa 7: Interface da crianca

Status: MVP em uso

Objetivo:

- criar ambiente infantil real, separado e seguro.
- incluir entrada por link e por codigo curto temporario.

Documento de apoio:

- `docs/decisao-codigo-curto-infantil.md`
- `docs/analise-codigo-curto-infantil.md`

## Etapa 8: Relatorio longitudinal

Status: proxima grande prioridade

Objetivo:

- consolidar evidencias;
- mostrar progresso no tempo;
- gerar relatorio para pais e professores.

Observacao:

- esta etapa e o centro de valor do produto; deve ser feita com calma, a partir dos testes reais de uso.

## Etapa 8.5: Compartilhamento responsavel/professor

Status: definida em PRD inicial

Objetivo:

- permitir acompanhamento compartilhado sem expor percepcoes privadas por padrao;
- preparar convite, aceite, escopo e revogacao;
- separar contexto familiar, escolar e tutoria/reforco.

Documento:

- `docs/prd-compartilhamento-responsavel-professor.md`

## Etapa 9: Unificacao visual e logica dos modulos

Status: planejada

Objetivo:

- alinhar Redacao, Leitura e Tabuada como partes de uma plataforma unica.

## Etapa 10: Catalogo de modulos plugaveis

Status: arquitetura iniciada

Objetivo:

- consolidar o contrato de modulos;
- organizar modulos por jornadas de apoio;
- preparar campos para habilitacao futura por conta, turma ou crianca;
- considerar Ingles e outros dominios como modulos futuros sem antecipar sua implementacao.

Documento:

- `docs/prd-modulos-plugaveis.md`
- `docs/prd-modulo-ingles.md`
