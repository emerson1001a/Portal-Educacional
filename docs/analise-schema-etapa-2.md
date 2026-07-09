# Analise do Schema Atual Para a Etapa 2

Data: 2026-07-09  
Base analisada: `supabase/schema.sql`  
PRD de referencia: `docs/prd-controle-de-acesso-supabase.md`

## Resumo

O schema atual funciona para o primeiro portal familiar, mas ainda esta concentrado em um modelo simples:

- um adulto tem um unico `role`;
- a crianca se vincula principalmente por `child_guardians`;
- metas e eventos pertencem ao `owner_id`;
- nao ha tarefas atribuidas;
- nao ha token infantil persistido;
- nao ha professor/turma;
- nao ha separacao formal entre percepcao privada e conteudo infantil.

A migracao `supabase/migrations/20260709_access_control_foundation.sql` adiciona uma fundacao incremental para resolver esses pontos sem remover tabelas existentes.

## O que foi preservado

- `profiles`
- `children`
- `child_guardians`
- `learning_goals`
- `activity_events`
- `progress_snapshots`
- `learning_reviews`
- `create_child_for_current_user`
- trigger `handle_new_user`

## Lacunas encontradas

### 1. Papel unico em `profiles.role`

Problema:

- uma pessoa pode ser responsavel e professor ao mesmo tempo.

Proposta:

- adicionar `profile_roles`;
- manter `profiles.role` por compatibilidade temporaria.

### 2. Professor e turma ausentes

Problema:

- nao ha como representar professor, turma ou grupo de reforco.

Proposta:

- adicionar `child_teachers`;
- adicionar `classrooms`;
- adicionar `classroom_students`.

### 3. Percepcao adulta misturada com dados gerais

Problema:

- observacoes sensiveis podem ficar em campos genericos como `children.notes`.

Proposta:

- criar `adult_perceptions`;
- privacidade por padrao;
- crianca nunca acessa.

### 4. Falta de tarefas

Problema:

- os modulos podem registrar eventos, mas nao ha uma entidade clara de tarefa atribuida.

Proposta:

- criar `assignments`;
- criar `assignment_items`;
- ligar eventos e sessoes a essas tarefas.

### 5. Acesso infantil sem modelo persistente

Problema:

- area infantil precisa de link/codigo com escopo e expiracao.

Proposta:

- criar `child_access_tokens`;
- guardar apenas hash;
- validar acesso infantil por endpoint server-side.

### 6. Evidencias sem sessao

Problema:

- `activity_events` registra eventos, mas nao agrupa uma execucao.

Proposta:

- criar `activity_sessions`;
- adicionar `assignment_id`, `assignment_item_id` e `session_id` em `activity_events`.

## Riscos da migracao

### Risco: recursao ou policy muito permissiva

Mitigacao:

- testar cada policy com usuarios diferentes;
- evitar que crianca consulte tabelas adultas diretamente;
- usar endpoints server-side para tokens infantis.

### Risco: admin com acesso excessivo

Mitigacao:

- admin aparece nas policies apenas onde necessario;
- futuro painel admin deve ter auditoria.

### Risco: modulo antigo nao enviar assignment

Mitigacao:

- campos novos em `activity_events` sao opcionais;
- os modulos antigos continuam funcionando enquanto sao adaptados.

## Checklist de teste manual depois de rodar a migracao

- [ ] Responsavel continua vendo propria crianca.
- [ ] Responsavel continua criando crianca.
- [ ] Responsavel nao ve crianca de outro adulto.
- [ ] Adulto pode ter mais de um papel em `profile_roles`.
- [ ] Professor vinculado ve aluno autorizado.
- [ ] Professor nao ve percepcao familiar privada.
- [ ] Responsavel pode criar tarefa para crianca vinculada.
- [ ] Crianca com token valido ve apenas tarefa liberada via endpoint infantil.
- [ ] Token expirado ou revogado nao libera acesso.
- [ ] `activity_events` antigo continua aceitando evento sem assignment.

## Proxima acao recomendada

Nao rodar a migracao em producao automaticamente.

Antes:

1. revisar o SQL;
2. rodar no Supabase SQL Editor;
3. testar os cenarios acima;
4. so depois adaptar endpoints e interface.
