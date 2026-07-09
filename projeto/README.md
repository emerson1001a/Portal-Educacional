# Projeto: Portal Educacional

Esta pasta e o painel de acompanhamento do desenvolvimento.

Ela nao substitui `docs/`. A diferenca e:

- `projeto/`: onde estamos, proximas etapas, backlog e decisoes de trabalho;
- `docs/`: documentos de produto, PRDs, arquitetura, regras pedagogicas e setup.

## Estado atual

Etapa atual: Etapa 2 - Controle de acesso e Supabase
Status: migracao proposta para revisao
Documento principal: `docs/prd-controle-de-acesso-supabase.md`

## Como retomar em uma nova janela do Codex

Quando o trabalho for retomado, comece por:

1. ler este arquivo;
2. abrir `roadmap.md`;
3. verificar a etapa em andamento;
4. ler o PRD indicado;
5. checar `git status`.

## Etapa em andamento

Etapa 2: Controle de acesso e Supabase.

Entrega esperada:

- PRD de controle de acesso;
- desenho de tabelas e vinculos;
- politicas RLS previstas;
- funcoes seguras;
- criterios de teste.

Entrega tecnica em revisao:

- `supabase/migrations/20260709_access_control_foundation.sql`
- `docs/analise-schema-etapa-2.md`

Antes de rodar no Supabase:

1. revisar a migracao;
2. rodar no SQL Editor;
3. testar permissoes basicas;
4. depois adaptar endpoints e telas.

## Regra de trabalho

Cada janela do Codex deve tentar terminar com uma entrega pequena e clara:

- documento fechado;
- codigo implementado;
- teste executado;
- commit local criado;
- proximo passo anotado.
