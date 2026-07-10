# Backlog

## Agora

- Fechar PRD de controle de acesso e Supabase.
- Decidir expiracao e escopo do token infantil.
- Revisar migracao `supabase/migrations/20260709_access_control_foundation.sql`.
- Executar smoke test `supabase/tests/20260709_access_control_smoke.sql` apos rodar a migracao.
- Rodar migracao no Supabase SQL Editor depois de revisada.
- Validar APIs de token infantil depois que a migracao estiver aplicada.
- Validar `child.html` com token real depois que a migracao estiver aplicada.
- Validar geracao do link infantil no painel adulto depois que a migracao estiver aplicada.
- Validar criacao de missao simples no painel adulto e exibicao no link infantil.

## Proximo

- Definir modelo de compartilhamento entre responsavel e professor.
- Definir se crianca maior tambem tera codigo curto alem do link infantil.
- Evoluir missao simples para plano de tarefas com metas, prazo e status por item.

## Mais tarde

- PRD do Portal da Crianca.
- PRD de metas e tarefas.
- Interface infantil para receber tarefas.
- Relatorio longitudinal.
- Unificacao visual e logica dos modulos.
- Catalogo de modulos plugaveis e jornadas de apoio.
- Preparar habilitacao futura por modulo, sem expor bloqueios comerciais para a crianca.

## Pendente de decisao

- Crianca maior usara codigo curto, link individual ou ambos?
- Links infantis terao expiracao por tempo, por tarefa ou por sessao?
- Professor podera convidar responsavel por e-mail?
- Responsavel podera compartilhar relatorio com professor por link?
- Admin tera tela propria ou apenas acesso operacional inicial?
- Quais jornadas iniciais fazem sentido: leitura, escrita, matematica, idiomas, organizacao?
- A habilitacao comercial futura sera por conta, crianca, turma, escola ou pacote?
