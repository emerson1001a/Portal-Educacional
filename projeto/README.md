# Projeto: Portal Educacional

Esta pasta e o painel de acompanhamento do desenvolvimento.

Ela nao substitui `docs/`. A diferenca e:

- `projeto/`: onde estamos, proximas etapas, backlog e decisoes de trabalho;
- `docs/`: documentos de produto, PRDs, arquitetura, regras pedagogicas e setup.

## Estado atual

Etapa atual: consolidacao do portal adulto/crianca com evidencias longitudinais
Status: MVP funcional em evolucao incremental
Documento de retomada: `projeto/painel-atual.md`

## Como retomar em uma nova janela do Codex

Quando o trabalho for retomado, comece por:

1. ler este arquivo;
2. abrir `painel-atual.md`;
3. abrir `backlog.md`;
4. verificar a etapa em andamento em `roadmap.md`;
5. checar `git status`.

## Etapa em andamento

Consolidacao do MVP do Portal Educacional.

Entrega esperada:

- manter adulto e crianca em ambientes separados;
- garantir que as evidencias dos modulos retornem ao historico central;
- melhorar relatorio longitudinal;
- refinar navegabilidade entre portal, area infantil e modulos;
- preservar as decisoes pedagogicas e de seguranca ja documentadas.

Entregas recentes:

- area infantil por link temporario;
- missoes adultas com itens por modulo;
- retorno de atividade concluida para o historico adulto;
- Tabuada configuravel por missao;
- PRD do modulo de Ingles;
- checklist e endpoint de status das migracoes Supabase.

Antes de mexer em banco:

1. abrir `docs/supabase-migrations-checklist.md`;
2. testar `/api/supabase-status`;
3. separar o que e obrigatorio, recomendado e futuro;
4. aplicar uma migracao por vez no SQL Editor.

## Regra de trabalho

Cada janela do Codex deve tentar terminar com uma entrega pequena e clara:

- documento fechado;
- codigo implementado;
- teste executado;
- commit local criado;
- proximo passo anotado.
