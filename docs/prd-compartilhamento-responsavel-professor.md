# PRD: Compartilhamento entre Responsavel e Professor

## Objetivo

Definir como um responsavel e um professor podem acompanhar a mesma crianca sem misturar contextos privados da familia, observacoes pedagogicas da escola e informacoes de negocio.

O compartilhamento deve ajudar a crianca, melhorar a conversa entre adultos e preservar confianca.

## Principio central

Compartilhar nao significa liberar tudo.

O acesso deve ser:

- explicito;
- revogavel;
- limitado por escopo;
- compreensivel para o adulto que concede acesso;
- invisivel para a crianca, salvo quando vira missao infantil segura.

## Publicos envolvidos

### Responsavel

Adulto familiar ou tutor que acompanha a crianca fora da escola.

Pode:

- cadastrar crianca;
- criar metas e missoes;
- registrar percepcoes privadas;
- compartilhar evidencias e relatorios com professor autorizado;
- revogar acesso concedido.

Nao deve:

- ver dados de turma inteira;
- acessar observacoes privadas de professor sem compartilhamento;
- receber dados de outros alunos.

### Professor

Adulto escolar, tutor ou profissional de reforco.

Pode:

- acompanhar criancas autorizadas;
- criar metas e missoes no contexto pedagogico;
- registrar observacoes pedagogicas privadas;
- gerar relatorios para reuniao;
- compartilhar observacoes e relatorios quando fizer sentido.

Nao deve:

- ver percepcoes familiares privadas por padrao;
- acessar contexto familiar sem autorizacao;
- ver dados de criancas nao vinculadas.

### Crianca

Recebe apenas missoes, atividades e feedback infantil.

Nao ve:

- percepcoes do responsavel;
- observacoes do professor;
- relatorios adultos;
- convites, autorizacoes ou discussoes entre adultos.

## Escopos de compartilhamento

O compartilhamento deve permitir niveis simples no MVP.

### Nivel 1: Missoes e progresso

Professor ou responsavel autorizado pode ver:

- missoes liberadas;
- status da missao;
- itens concluidos;
- modulo usado;
- data de realizacao.

Nao inclui:

- percepcao privada;
- nota adulta privada;
- relatorio completo.

### Nivel 2: Evidencias pedagogicas

Inclui o Nivel 1 e tambem:

- textos produzidos;
- respostas da atividade;
- feedback adulto do modulo;
- metricas pedagogicas do modulo.

Deve ser usado com cuidado, pois pode conter producao da crianca.

### Nivel 3: Relatorio longitudinal

Inclui:

- sintese longitudinal;
- base de evidencias;
- leitura por area;
- orientacao pratica para o adulto;
- plano de proximos dias.

Nao inclui automaticamente:

- percepcoes privadas brutas;
- desabafos familiares;
- notas privadas de professor.

### Nivel 4: Percepcoes compartilhadas

Somente quando o autor escolher compartilhar uma percepcao especifica.

Regras:

- percepcao nasce privada;
- autor decide se compartilha;
- compartilhamento pode ser revogado;
- historico deve registrar quem compartilhou e quando.

## Modelo recomendado de dados

### Vínculos

Usar ou evoluir:

```text
child_guardians
child_teachers
```

Campos minimos recomendados:

```text
child_id
adult_id
role_context
permission_level
can_view_progress
can_view_evidence
can_view_reports
can_manage_goals
can_manage_tasks
shared_by
created_at
revoked_at
```

Para separar papeis:

```text
role_context: family | school | tutoring
permission_level: progress | evidence | reports
```

### Compartilhamentos especificos

Criar futuramente:

```text
shared_items
```

Campos sugeridos:

```text
id
child_id
item_type
item_id
shared_by
shared_with
visibility_scope
created_at
revoked_at
```

`item_type`:

```text
learning_review
progress_snapshot
activity_event
report
adult_perception
```

## Fluxos do MVP

### Responsavel compartilha com professor

1. Responsavel entra no portal.
2. Seleciona a crianca.
3. Abre "Compartilhamento".
4. Informa e-mail do professor.
5. Escolhe escopo inicial:
   - progresso;
   - evidencias;
   - relatorio.
6. Professor recebe convite.
7. Professor aceita com conta autenticada.
8. Portal registra vinculo.
9. Responsavel pode revogar depois.

### Professor compartilha com responsavel

1. Professor entra no portal.
2. Seleciona aluno autorizado.
3. Gera relatorio ou percepcao compartilhavel.
4. Escolhe "Compartilhar com responsavel".
5. Responsavel recebe acesso apenas ao item compartilhado ou ao escopo autorizado.

### Escola ou reforco

1. Professor cria turma ou grupo.
2. Adiciona alunos autorizados.
3. Acompanha progresso agregado da turma.
4. Nao ve percepcoes familiares privadas.
5. Relatorio individual exige aluno autorizado.

## Regras de privacidade

- Crianca nunca ve compartilhamento adulto.
- Admin do negocio nao ve dados pedagogicos individuais.
- Responsavel nao ve dados de outros alunos.
- Professor nao ve percepcoes familiares privadas por padrao.
- Percepcao privada nunca deve entrar automaticamente em relatorio compartilhado.
- Relatorio compartilhado deve indicar a base de evidencias usada.
- Revogar acesso deve impedir novas leituras, preservando auditoria.

## Linguagem de produto

Usar:

- "Compartilhar acompanhamento"
- "Permitir que este professor acompanhe"
- "Compartilhar relatorio"
- "Revogar acesso"
- "Visivel para voce"
- "Visivel para adultos autorizados"

Evitar:

- "liberar tudo"
- "diagnostico"
- "deficiencia"
- "problema do aluno"
- "controle dos pais"

## Criterios de aceite

- Responsavel consegue convidar professor sem expor percepcao privada.
- Professor autorizado ve apenas criancas vinculadas.
- Professor nao ve crianca de outro responsavel.
- Responsavel consegue revogar acesso.
- Relatorio compartilhado nao inclui notas privadas sem acao explicita.
- Crianca nao ve tela, convite ou texto de compartilhamento.
- Logs de auditoria registram convite, aceite, alteracao de escopo e revogacao.

## Fora de escopo inicial

- Painel administrativo comercial.
- Banco dedicado por escola.
- Contratos e aceite juridico formal.
- Relatorio agregado por escola.
- Convites em lote para turma inteira.

Esses pontos ficam para a etapa escolar/enterprise.

## Decisoes em aberto

- O professor podera cadastrar crianca sem responsavel?
- O responsavel podera limitar compartilhamento por modulo?
- O professor podera criar missao sem aprovacao do responsavel?
- Convite por e-mail sera obrigatorio ou tambem havera codigo de turma?
- Como apresentar para a familia que um relatorio foi gerado pela escola?
