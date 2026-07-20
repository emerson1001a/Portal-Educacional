# Analise de Infraestrutura: Relatorios Longitudinais e Reuniao com Pais

## Status

Documento de planejamento tecnico.

Este documento nao autoriza implementacao imediata. Ele mapeia as mudancas de
infraestrutura necessarias para sustentar:

- Acompanhamento por area;
- analise longitudinal por periodo;
- relatorio para reuniao com pais;
- evidencias rastreaveis;
- revisao humana antes de compartilhamento.

## Documentos de referencia

- `docs/prd-analise-longitudinal-por-blocos.md`
- `docs/prd-relatorio-reuniao-pais.md`
- `docs/prd-metas-e-tarefas.md`
- `docs/prd-sinais-da-missao.md`
- `modules/module-contract.md`
- `supabase/schema.sql`
- `supabase/migrations/20260709_access_control_foundation.sql`

## Conclusao executiva

As mudancas recentes dos PRDs nao exigem jogar fora a base atual.

O portal ja tem uma estrutura promissora para registrar evidencias:

- `activity_events`;
- `metrics`;
- `feedback`;
- `artifacts`;
- `occurred_at`;
- vinculo com `assignment_id` e `assignment_item_id`;
- metas em `learning_goals`;
- missoes em `assignments`;
- itens em `assignment_items`;
- permissoes por responsavel, professor e turma em migracoes.

O que falta nao e uma nova fundacao completa. Falta uma camada de
consolidacao, consulta, rastreabilidade e relatorio.

Recomendacao:

1. nao implementar o relatorio diretamente na tela;
2. primeiro consolidar o contrato de evidencias por modulo;
3. depois criar a camada de analise por area e periodo;
4. so entao gerar relatorios revisaveis.

## O que ja existe e pode ser aproveitado

### 1. Registro central de evidencias

Tabela:

- `activity_events`

Campos ja adequados:

- `child_id`;
- `owner_id`;
- `service`;
- `activity_type`;
- `title`;
- `occurred_at`;
- `duration_ms`;
- `metrics`;
- `feedback`;
- `artifacts`;
- `assignment_id`;
- `assignment_item_id`;
- `visibility`;
- `evidence_level`.

Leitura:

Esta tabela deve continuar sendo a fonte principal do historico pedagogico.

Risco:

Como `metrics` e `artifacts` sao JSON, cada modulo pode salvar dados diferentes
demais. Isso e flexivel, mas pode prejudicar relatorios comparaveis.

Decisao recomendada:

Manter `activity_events`, mas criar um contrato minimo obrigatorio por modulo.

### 2. Metas, missoes e itens

Tabelas:

- `learning_goals`;
- `assignments`;
- `assignment_items`.

Leitura:

Ja existe o caminho pedagogico correto:

```text
meta adulta -> missao infantil -> atividade feita -> evidencia registrada
```

Risco:

A analise longitudinal depende de saber se uma evidencia veio de uma meta,
missao ou atividade livre. O sistema deve preservar essa diferenca.

Decisao recomendada:

Relatorios devem separar, quando util:

- atividades de missao;
- atividades livres;
- atividades vinculadas a meta;
- atividades sem meta.

### 3. Acesso infantil separado

Tabelas e APIs:

- `child_access_tokens`;
- `/api/child-access-token`;
- `/api/child-session`;
- `/api/child-code-session`.

Leitura:

A crianca ja pode acessar uma area separada sem ver conteudo adulto.

Risco:

Relatorios e analises adultas nao podem vazar para o Bloco Infantil.

Decisao recomendada:

Nenhuma API infantil deve retornar:

- percepcoes adultas;
- relatorios;
- feedback adulto;
- analise longitudinal;
- evidencias privadas.

### 4. Primeiros objetos de snapshot

Tabelas existentes:

- `progress_snapshots`;
- `learning_reviews`.

Leitura:

Essas tabelas indicam uma intencao anterior de consolidar progresso e revisoes.

Risco:

Elas ainda parecem genericas para o novo desenho. Podem ser uteis, mas nao
devem ser forçadas a cumprir todas as funcoes do relatorio para pais.

Decisao recomendada:

Usar como referencia, mas criar estruturas mais explicitas para relatorio
formal se necessario.

## Lacunas principais

### 1. Periodos escolares

Problema:

O produto agora precisa trabalhar com:

- ultimos 30 dias;
- bimestre;
- semestre;
- ano letivo;
- periodo personalizado.

Hoje:

As evidencias tem `occurred_at`, mas nao ha uma tabela clara de calendario
escolar, ciclos ou bimestres configuraveis.

Necessidade:

Criar suporte a periodo sem prender a analise em "ultimas 4 semanas".

Possivel tabela futura:

```text
school_periods
- id
- organization_id
- name
- period_type
- starts_on
- ends_on
- school_year
- sort_order
- created_at
```

Observacao:

No MVP familiar, periodo personalizado pode resolver. Para escola, calendario
por bimestre/semestre precisa ficar configuravel.

### 2. Analise por area como camada propria

Problema:

A tela nao deve calcular tudo de forma improvisada.

Necessidade:

Criar uma camada de consulta que receba:

```text
child_id
period_start
period_end
areas ou services
```

E devolva:

```text
Onde olhar primeiro
areas analisadas
ritmo geral
evidencias usadas
nivel de confianca
```

Possivel API futura:

```text
GET /api/longitudinal-analysis?child_id=...&period_start=...&period_end=...
```

Essa API deve:

- buscar `activity_events`;
- agrupar por area;
- calcular volume;
- calcular distribuicao no tempo;
- calcular metricas principais por area;
- classificar tendencia;
- indicar nivel de confianca;
- devolver evidencias usadas;
- nao chamar IA em toda abertura de tela, salvo quando necessario.

### 3. Contrato minimo por modulo

Problema:

O relatorio so sera bom se cada modulo guardar os dados certos.

Necessidade:

Padronizar o minimo em `metrics` e `artifacts`.

#### Redacao

Precisa garantir:

- tema;
- titulo;
- tipo de texto;
- texto final;
- versao revisada, quando existir;
- `structure_score`;
- sinais de comeco, meio e fim;
- feedback para crianca;
- feedback para adulto;
- nivel de apoio;
- duracao;
- se foi feita por digitacao, voz ou papel digitalizado, quando existir.

#### Interpretacao

Precisa garantir:

- texto usado;
- origem do texto;
- perguntas;
- respostas da crianca;
- gabarito ou resposta esperada;
- tipo de pergunta;
- acertos;
- total;
- complexidade;
- feedback para crianca;
- feedback para adulto;
- tempo de leitura;
- tempo total.

#### Tabuada

Precisa garantir:

- tabuadas treinadas;
- quantidade de tentativas;
- acertos;
- erros;
- tempo mediano;
- fatos mais errados;
- modo de treino;
- meta da missao;
- conclusao da missao.

#### Ingles

Precisa garantir:

- habilidade treinada;
- tipo de exercicio;
- nivel de apoio;
- itens apresentados;
- respostas da crianca;
- acertos;
- erros frequentes;
- palavras/frases treinadas;
- feedback para crianca;
- feedback para adulto;
- audio usado apenas como apoio, quando existir.

### 4. Evidencias rastreaveis de conclusoes

Problema:

O PRD exige que toda conclusao permita abrir as evidencias que a sustentam.

Necessidade:

Quando a IA ou o sistema gerar uma sintese, ela deve guardar quais eventos
foram usados.

Possivel tabela futura:

```text
analysis_runs
- id
- child_id
- requested_by
- period_start
- period_end
- analysis_type
- status
- input_summary
- output_json
- model
- created_at
```

Possivel tabela de vinculo:

```text
analysis_evidence_refs
- analysis_run_id
- activity_event_id
- reason
```

Observacao:

Isso evita uma frase bonita sem lastro. O adulto deve poder clicar em:

```text
Ver evidencias desta conclusao
```

### 5. Relatorio para reuniao com pais

Problema:

Relatorio para pais tem fluxo proprio:

```text
rascunho -> revisao -> revisado -> compartilhado -> arquivado
```

As tabelas atuais `progress_snapshots` e `learning_reviews` nao cobrem bem:

- versao revisavel;
- status;
- evidencias usadas;
- exportacao;
- registro de compartilhamento;
- texto final aprovado.

Possivel tabela futura:

```text
parent_meeting_reports
- id
- child_id
- created_by
- period_start
- period_end
- period_label
- report_type
- status
- title
- draft_json
- final_json
- final_text
- ai_model
- reviewed_by
- reviewed_at
- shared_at
- archived_at
- created_at
- updated_at
```

Possivel tabela de evidencias do relatorio:

```text
parent_report_evidence_refs
- report_id
- activity_event_id
- area
- reason
- display_order
```

Estados sugeridos:

- `draft`;
- `in_review`;
- `reviewed`;
- `shared`;
- `archived`.

### 6. Exportacao e apresentacao

Problema:

O relatorio para pais pode ser usado em reuniao, PDF ou tela.

Necessidade:

Definir se o MVP tera:

- pagina de visualizacao;
- impressao pelo navegador;
- PDF gerado;
- link compartilhavel;
- apenas texto revisado.

Recomendacao para MVP:

Comecar com pagina revisavel e impressao pelo navegador.

Deixar PDF formal para depois, salvo se a escola exigir.

### 7. Permissoes e privacidade

Problema:

Relatorios contem dados sensiveis.

Necessidade:

Separar permissoes:

- quem pode gerar;
- quem pode revisar;
- quem pode compartilhar;
- quem pode ver relatorio final;
- quem pode ver evidencias completas.

Possivel evolucao de permissoes:

- `can_view_reports`;
- `can_generate_reports`;
- `can_review_reports`;
- `can_share_reports`;
- `can_view_evidence`.

Regra critica:

Admin do negocio nao deve acessar relatorios individuais.

Observacao tecnica:

As funcoes atuais tratam `is_admin()` como acesso amplo em alguns pontos. Para
o futuro painel administrativo do negocio, sera importante diferenciar:

- admin tecnico/operacional do tenant;
- admin do negocio SaaS;
- professor/coordenador da escola.

Essa distincao deve ser resolvida antes de vender para escolas.

### 8. Auditoria

Problema:

Relatorios para familia e dados pedagogicos precisam de rastro.

Necessidade:

Registrar:

- quem gerou;
- quando gerou;
- quem revisou;
- quem compartilhou;
- quais evidencias foram usadas;
- se houve alteracao manual no texto;
- se o relatorio foi arquivado.

Possivel tabela futura:

```text
audit_logs
- id
- actor_id
- action
- entity_type
- entity_id
- child_id
- metadata
- created_at
```

No MVP, pode ser suficiente embutir campos de revisao no proprio relatorio.

## APIs futuras recomendadas

### 1. Analise longitudinal

```text
GET /api/longitudinal-analysis
```

Entrada:

- `child_id`;
- `period_start`;
- `period_end`;
- `period_type`;
- `areas`, opcional.

Saida:

- `where_to_look_first`;
- `areas`;
- `general_practice_rhythm`;
- `evidence_refs`;
- `confidence`;
- `warnings`;
- `generated_at`.

### 2. Evidencias filtradas

```text
GET /api/activity-evidence
```

Entrada:

- `child_id`;
- `period_start`;
- `period_end`;
- `service`;
- `assignment_id`, opcional;
- `goal_id`, opcional.

Saida:

- lista paginada de evidencias;
- resumo de artifacts;
- feedback adulto;
- metricas relevantes.

### 3. Gerar rascunho de relatorio

```text
POST /api/parent-meeting-reports/draft
```

Entrada:

- `child_id`;
- `period_start`;
- `period_end`;
- `report_type`;
- evidencias selecionadas automaticamente ou manualmente.

Saida:

- `report_id`;
- status `draft`;
- texto estruturado;
- evidencias usadas.

### 4. Revisar relatorio

```text
PATCH /api/parent-meeting-reports/:id
```

Permite:

- editar texto;
- mudar status;
- salvar revisao humana;
- arquivar.

### 5. Compartilhar ou exportar

```text
POST /api/parent-meeting-reports/:id/share
```

No MVP, pode apenas marcar como compartilhado.

Futuro:

- link seguro;
- PDF;
- envio por email;
- assinatura da escola.

## Indices recomendados no banco

Para consultas longitudinais:

```text
activity_events(child_id, occurred_at)
activity_events(child_id, service, occurred_at)
activity_events(child_id, assignment_id)
activity_events(child_id, assignment_item_id)
assignments(child_id, status, created_at)
assignment_items(assignment_id, module_id, status)
learning_goals(child_id, status, area)
```

Para JSON, considerar no futuro:

```text
GIN em activity_events.metrics
GIN em activity_events.artifacts
```

Ponderacao:

No inicio, indices simples por `child_id`, `service` e `occurred_at` devem
resolver. GIN em JSON deve esperar volume real maior ou consultas mais
complexas.

## Camada de IA

### Nao recomendado

Mandar todas as evidencias brutas de um semestre para a IA.

Riscos:

- custo alto;
- lentidao;
- contexto excessivo;
- possivel perda de rastreabilidade;
- conclusao sem controle.

### Recomendado

Pipeline em duas etapas:

1. o sistema calcula dados estruturados por area;
2. a IA transforma esse resumo em linguagem cuidadosa.

Entrada ideal para IA:

```text
periodo
areas trabalhadas
metricas resumidas
tendencias calculadas
nivel de confianca
evidencias selecionadas
limites da conclusao
linguagem proibida
```

Saida esperada:

- sintese curta;
- leitura por area;
- orientacao para familia;
- proximos passos;
- lista de evidencias citadas.

Regra:

A IA nunca deve inventar evidencia. Cada trecho importante deve apontar para
eventos reais.

## Compatibilidade com familia e escola

### Familia

Precisa de:

- linguagem mais simples;
- menos blocos;
- foco em "o que fazer agora";
- relatorio opcional.

### Escola

Precisa de:

- periodos escolares;
- turmas;
- professores;
- relatorio para reuniao;
- revisao institucional;
- possivel PDF;
- auditoria.

Infraestrutura comum:

- crianca;
- adulto;
- metas;
- missoes;
- evidencias;
- analise por area;
- relatorios revisaveis.

Conclusao:

Nao e necessario duplicar o produto agora. Mas a infraestrutura deve nascer
com campo suficiente para suportar modo Familia e modo Escola.

## Sequencia segura de implementacao

### Etapa 1: Auditoria e contrato de evidencias

Objetivo:

Garantir que cada modulo envia os dados necessarios.

Entregas:

- revisar contrato em `modules/module-contract.md`;
- criar checklist por modulo;
- ajustar Redacao, Interpretacao, Tabuada e Ingles para preencher `metrics` e
  `artifacts` com campos minimos.

Risco se pular:

Relatorio bonito, mas sem dados confiaveis.

### Etapa 2: Indices e filtros de periodo

Objetivo:

Consultar historico por periodo sem lentidao ou gambiarras.

Entregas:

- migracao com indices em `activity_events`;
- filtro por periodo no Historico unificado;
- periodo personalizado em consultas.

Risco se pular:

Painel preso em ultimas semanas ou consultas lentas.

### Etapa 3: API de Acompanhamento por area

Objetivo:

Criar a camada que calcula a leitura longitudinal.

Entregas:

- endpoint de analise;
- agrupamento por area;
- tendencia;
- nivel de confianca;
- evidencias usadas;
- sem IA inicialmente, ou com IA opcional depois.

Risco se pular:

Cada tela calcula de um jeito e o produto perde consistencia.

### Etapa 4: Tela de Acompanhamento por area

Objetivo:

Substituir blocos antigos por uma leitura mais limpa.

Entregas:

- Onde olhar primeiro;
- cards por area;
- grafico por periodo;
- evidencias recolhidas;
- Historico unificado como auditoria.

Risco se pular:

Relatorio para pais nasce sem tela de origem confiavel.

### Etapa 5: Relatorio rascunho sem PDF

Objetivo:

Gerar um primeiro relatorio revisavel.

Entregas:

- tabela de relatorios;
- tabela de evidencias do relatorio;
- gerar rascunho;
- editar e salvar;
- marcar como revisado.

Risco se pular:

IA gera texto final sem controle humano.

### Etapa 6: Exportacao e fluxo escolar

Objetivo:

Preparar uso em reuniao.

Entregas:

- visualizacao para impressao;
- status de compartilhamento;
- possivel PDF;
- auditoria de apresentacao.

Risco se pular:

Relatorio fica bom internamente, mas ruim para reuniao real.

### Etapa 7: Calendario escolar configuravel

Objetivo:

Suportar escolas com bimestres e semestres reais.

Entregas:

- tabela de periodos escolares;
- tela simples de configuracao;
- filtros por bimestre/semestre/ano letivo.

Risco se pular:

O produto continua parecendo familiar, nao escolar.

## Riscos principais

### 1. Relatorio com conclusao sem lastro

Mitigacao:

- guardar evidencias usadas;
- mostrar "Ver evidencias desta conclusao";
- limitar conclusoes quando ha poucos dados.

### 2. Excesso de informacao para pais

Mitigacao:

- separar painel tecnico de relatorio para familia;
- selecionar poucas evidencias;
- usar linguagem acolhedora;
- colocar orientacao pratica.

### 3. Vazamento de conteudo adulto para crianca

Mitigacao:

- APIs infantis nunca retornam relatorio;
- `evidence_level` e `visibility` devem ser respeitados;
- testes especificos para Bloco Infantil.

### 4. Admin do negocio vendo dado pedagogico

Mitigacao:

- separar roles de negocio e roles pedagogicos;
- admin SaaS ve apenas agregados anonimos;
- relatorios individuais ficam fora do painel administrativo do negocio.

### 5. IA cara ou lenta

Mitigacao:

- calculo estruturado antes da IA;
- selecionar evidencias;
- cachear rascunhos;
- gerar relatorio somente por acao do adulto.

### 6. Dados antigos incompletos

Mitigacao:

- informar baixa confianca;
- nao forcar analise onde faltam artifacts;
- melhorar contrato daqui para frente.

## Decisoes recomendadas antes do codigo

1. O MVP do relatorio tera PDF ou apenas pagina imprimivel?
2. Relatorio sera salvo como snapshot historico desde o MVP?
3. Quem pode revisar: qualquer adulto vinculado ou apenas professor/coordenador?
4. O modo Familia tera relatorio para pais ou apenas sintese simples?
5. Escola precisara de calendario escolar ja no primeiro MVP escolar?
6. O relatorio pode ser compartilhado por link ou apenas exportado?
7. Quais campos minimos por modulo serao obrigatorios antes da primeira versao?

## Recomendacao final

Fazer a infraestrutura em camadas.

Nao comecar pelo relatorio final.

Sequencia recomendada:

```text
contrato de evidencias -> periodo e indices -> analise por area -> tela -> relatorio rascunho -> exportacao
```

Essa ordem preserva o que ja funciona, reduz risco de quebrar o portal e evita
que a IA vire uma camada solta sem evidencia.

