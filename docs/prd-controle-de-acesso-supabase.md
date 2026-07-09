# PRD: Controle de Acesso e Supabase

Status: em desenho  
Data: 2026-07-09  
Origem: `docs/prd-matriz-de-papeis.md`  
Proxima saida esperada: proposta de schema e policies RLS

## Objetivo

Transformar a matriz de papeis em uma arquitetura de banco segura no Supabase.

Esta etapa deve definir:

- tabelas;
- relacionamentos;
- funcoes auxiliares;
- politicas RLS;
- tokens de acesso infantil;
- criterios de teste;
- plano de migracao a partir do schema atual.

## Ponderacao de produto

Esta etapa e delicada porque seguranca nao pode depender apenas da interface.

Se a crianca nao pode ver percepcoes privadas, isso precisa ser verdade no banco, nos endpoints e nas policies, nao apenas escondido por CSS ou por navegacao.

Tambem precisamos evitar outro erro comum: dar poder demais ao papel `admin`. O admin deve existir para operacao, mas o acesso a dados pedagogicos sensiveis deve ser excepcional, registrado e reduzido ao minimo necessario.

## Estado atual do schema

O arquivo `supabase/schema.sql` ja possui uma base funcional:

- `profiles`;
- `children`;
- `child_guardians`;
- `learning_goals`;
- `activity_events`;
- `progress_snapshots`;
- `learning_reviews`;
- funcoes `is_admin`, `can_access_child`, `create_child_for_current_user`;
- policies basicas para responsavel vinculado.

Essa base foi suficiente para o primeiro portal, mas ainda nao cobre completamente:

- adulto com multiplos papeis;
- professor com turma;
- aluno acessando por link/codigo;
- notas privadas separadas de observacoes pedagogicas;
- compartilhamento explicito entre familia e escola;
- classificacao de informacao por nivel;
- tarefas atribuidas;
- escopo/expiracao de acesso infantil.

## Decisao arquitetural

### Manter Supabase como autoridade de permissao

O Supabase deve ser a camada principal para:

- autenticar adultos;
- controlar vinculos;
- limitar acesso por crianca;
- proteger dados adultos;
- registrar evidencias.

### Adulto autenticado

Responsavel, professor e admin entram por Supabase Auth.

### Crianca no MVP

Crianca nao entra com e-mail/senha no MVP.

O acesso infantil deve ocorrer por:

- area infantil aberta pelo adulto;
- link infantil;
- codigo infantil;
- token com escopo limitado.

Esse token nunca deve permitir acesso a:

- percepcoes privadas;
- relatorios adultos;
- notas pedagogicas adultas;
- dados de outras criancas;
- configuracoes administrativas.

## Modelo de papeis

### Problema do schema atual

Hoje `profiles.role` aceita apenas um papel:

```text
guardian | teacher | admin
```

Isso e insuficiente, porque uma mesma pessoa pode ser:

- pai e professor;
- professor e admin;
- tutor familiar e professor de reforco.

### Decisao recomendada

Criar tabela separada:

```text
profile_roles
```

Campos sugeridos:

```text
profile_id uuid references profiles(id)
role text check (role in ('guardian', 'teacher', 'admin'))
created_at timestamptz
primary key (profile_id, role)
```

Manter `profiles.role` temporariamente apenas para compatibilidade, ou migrar depois.

## Modelo de vinculos

### Responsavel-crianca

Tabela atual:

```text
child_guardians
```

Deve continuar existindo, mas precisa evoluir.

Campos recomendados:

```text
child_id
guardian_id
relationship
permission_level
can_view_reports
can_manage_goals
can_manage_tasks
created_at
revoked_at
```

### Professor-aluno

Criar tabela:

```text
child_teachers
```

Campos recomendados:

```text
child_id
teacher_id
scope
can_view_evidence
can_view_reports
can_manage_goals
can_manage_tasks
shared_by
created_at
revoked_at
```

`scope` pode iniciar simples:

```text
individual | classroom | tutoring
```

### Turmas

Criar:

```text
classrooms
classroom_students
```

Campos sugeridos:

```text
classrooms:
id
teacher_id
name
description
created_at

classroom_students:
classroom_id
child_id
created_at
```

## Modelo de informacao sensivel

### Adult perceptions

Criar tabela separada para percepcoes do adulto:

```text
adult_perceptions
```

Campos:

```text
id
child_id
author_id
author_context text check ('family', 'school', 'tutoring')
visibility text check ('private', 'shared_with_guardians', 'shared_with_teachers')
raw_text
structured_summary jsonb
suggested_goal_id
created_at
updated_at
```

Regra:

- percepcao nasce `private`;
- crianca nunca acessa;
- professor nao ve percepcao familiar privada;
- responsavel nao ve percepcao pedagogica privada sem compartilhamento.

### Learning goals

Tabela atual `learning_goals` continua, mas precisa de campos:

```text
created_from_perception_id
created_by_role
visibility
child_safe_title
child_safe_description
```

Regra:

- adulto pode ver objetivo completo;
- crianca pode ver apenas versao segura da tarefa ou missao.

## Modelo de tarefas

Criar:

```text
assignments
assignment_items
```

### assignments

Campos:

```text
id
child_id
created_by
created_by_role
goal_id
title
adult_notes
child_title
child_instructions
status text check ('draft', 'released', 'in_progress', 'done', 'archived')
release_at
due_at
created_at
updated_at
```

### assignment_items

Campos:

```text
id
assignment_id
module_id
activity_type
title
child_instructions
sort_order
required
status
created_at
```

Regra:

- crianca so ve assignments `released`;
- crianca ve `child_title` e `child_instructions`;
- crianca nao ve `adult_notes`.

## Acesso infantil por token

Criar:

```text
child_access_tokens
```

Campos:

```text
id
child_id
created_by
token_hash
purpose text check ('child_area', 'assignment', 'module_return')
assignment_id
expires_at
used_at
revoked_at
created_at
```

Regra:

- guardar hash do token, nao token puro;
- token tem escopo;
- token expira;
- token nao concede acesso adulto;
- token so permite buscar tarefas liberadas e registrar execucao permitida.

## Evidencias

Tabela atual `activity_events` deve continuar, mas precisa ser ligada a tarefas:

Campos a adicionar:

```text
assignment_id
assignment_item_id
session_id
visibility
evidence_level
```

Criar ou prever:

```text
activity_sessions
```

Campos:

```text
id
child_id
assignment_id
assignment_item_id
module_id
started_at
finished_at
duration_ms
status
child_access_token_id
created_at
```

## Funcoes auxiliares recomendadas

### Adulto pode acessar crianca

```text
can_adult_access_child(child_id uuid)
```

Retorna true se:

- admin operacional autorizado;
- responsavel ativo da crianca;
- professor ativo da crianca;
- professor da turma onde a crianca esta ativa.

### Adulto pode gerenciar tarefas

```text
can_manage_child_tasks(child_id uuid)
```

Retorna true se vinculo permite criar/liberar tarefa.

### Adulto pode ver relatorio

```text
can_view_child_reports(child_id uuid)
```

Retorna true se vinculo permite relatorio.

### Token infantil valido

```text
is_valid_child_token(token text, child_id uuid)
```

Preferencialmente essa validacao deve ficar em endpoint server-side, usando `SUPABASE_SERVICE_ROLE_KEY`, para comparar hash com seguranca.

## Politicas RLS por tabela

### profiles

- usuario ve e edita seu proprio profile;
- admin tecnico pode ver profiles se necessario;
- crianca nao acessa.

### profile_roles

- usuario ve seus papeis;
- admin tecnico gerencia;
- futuro: convite pode conceder papel teacher/guardian.

### children

- adulto ve criancas vinculadas;
- professor ve alunos vinculados;
- admin tecnico ve se necessario;
- token infantil nao deve consultar diretamente todos os dados da crianca.

### child_guardians

- responsavel ve seu proprio vinculo;
- outro responsavel so ve se compartilhamento exigir;
- admin tecnico gerencia se necessario.

### child_teachers

- professor ve seus proprios vinculos;
- responsavel autorizado pode ver quais professores estao vinculados;
- professor nao ve vinculos familiares privados.

### adult_perceptions

- autor ve;
- compartilhados veem conforme `visibility`;
- crianca nunca ve;
- admin nao ve por padrao.

### learning_goals

- adultos vinculados veem metas permitidas;
- crianca nao acessa meta adulta diretamente;
- crianca pode ver tarefa derivada da meta.

### assignments

- adultos autorizados gerenciam;
- crianca acessa apenas via token e apenas campos infantis;
- assignments nao liberadas ficam invisiveis para crianca.

### activity_sessions

- modulo cria via endpoint seguro;
- adulto autorizado ve;
- crianca nao lista historico adulto.

### activity_events

- modulo insere via endpoint seguro;
- adulto autorizado ve;
- crianca nao ve feedback adulto nem evidencia bruta.

### progress_snapshots e learning_reviews

- adultos autorizados veem;
- crianca nao acessa;
- relatorio longitudinal permanece adulto.

## Endpoints necessarios

### Adultos

```text
GET /api/adult/children
POST /api/adult/children
GET /api/adult/children/:id/context
POST /api/adult/perceptions
POST /api/adult/goals
POST /api/adult/assignments
POST /api/adult/child-access-token
GET /api/adult/reports/:child_id
```

### Crianca

```text
GET /api/child/session?token=...
GET /api/child/assignments?token=...
POST /api/child/activity-session
POST /api/child/activity-event
```

### Modulos

```text
POST /api/activity-events
GET /api/activity-token
```

Esses endpoints ja existem parcialmente e devem evoluir para assignments e sessoes.

## Plano de migracao recomendado

### Passo 1: Documentar sem quebrar

Criar este PRD e revisar contra `schema.sql`.

### Passo 2: Adicionar tabelas novas

Adicionar:

- `profile_roles`;
- `child_teachers`;
- `classrooms`;
- `classroom_students`;
- `adult_perceptions`;
- `assignments`;
- `assignment_items`;
- `child_access_tokens`;
- `activity_sessions`.

### Passo 3: Compatibilidade

Manter:

- `profiles.role`;
- `child_guardians`;
- `learning_goals`;
- `activity_events`;
- `progress_snapshots`;
- `learning_reviews`.

### Passo 4: Policies

Criar policies novas sem remover as antigas de imediato, quando possivel.

### Passo 5: Testes

Testar manualmente no Supabase:

- responsavel ve propria crianca;
- responsavel nao ve crianca de outro responsavel;
- professor ve aluno autorizado;
- professor nao ve percepcao familiar privada;
- crianca com token ve tarefa liberada;
- crianca com token nao ve feedback adulto;
- token expirado nao acessa;
- link infantil nao abre painel adulto.

## Criterios de aceite da Etapa 2

- [ ] PRD de controle de acesso criado.
- [ ] Schema atual analisado contra matriz de papeis.
- [ ] Tabelas novas propostas.
- [ ] Funcoes auxiliares propostas.
- [ ] Policies por tabela propostas.
- [ ] Modelo de token infantil definido.
- [ ] Plano de migracao sem quebrar o portal atual definido.
- [ ] Checklist de testes de permissao definido.
- [ ] Saida pronta para Etapa 5: implementacao de banco.

## Decisoes em aberto

1. Token infantil deve expirar por tempo, por tarefa ou pelos dois?
2. Codigo infantil sera digitavel pela crianca ou apenas link?
3. Professor podera criar crianca sozinho ou apenas receber crianca compartilhada?
4. Responsavel podera revogar acesso do professor?
5. Admin tera painel proprio ou apenas operacao tecnica no inicio?
6. Activity events de modulos antigos devem ser convertidos para assignments retroativamente?
