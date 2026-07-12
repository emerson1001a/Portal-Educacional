# PRD: Matriz de Papeis

Status: fechado para a Etapa 1  
Data: 2026-07-09  
Proxima etapa: regras de acesso e Supabase

## Objetivo

Definir com clareza quem pode ver, criar, editar, executar e compartilhar informacoes dentro do Portal Educacional.

Esta matriz e a base para:

- regras de seguranca;
- politicas RLS no Supabase;
- navegacao entre area adulta e area infantil;
- telas do responsavel, professor e crianca;
- relatorios longitudinais;
- integracao futura dos modulos de redacao, leitura e tabuada.

## Ponderacao de produto

Esta etapa nao cria telas nem banco de dados. Ela define a regra antes da implementacao.

Isso evita um erro comum em produtos educacionais: construir primeiro a experiencia da crianca e depois tentar esconder informacoes sensiveis com ajustes visuais. Aqui a separacao nasce na arquitetura.

Decisao critica:

- a area infantil nao e uma versao simplificada do painel adulto;
- a area infantil e um ambiente proprio, com dados proprios e linguagem propria;
- qualquer informacao adulta precisa ser transformada em tarefa segura antes de chegar a crianca.

## Principio principal

O adulto acessa planejamento, percepcoes, metas, evidencias e relatorios.  
A crianca acessa apenas tarefas, atividades e feedback seguro.

A crianca nunca deve acessar observacoes sensiveis do adulto, relatorios tecnicos ou hipoteses pedagogicas internas.

## Papeis do MVP

### Responsavel

Pessoa adulta vinculada a uma crianca em contexto familiar.

Exemplos:

- pai;
- mae;
- tutor;
- responsavel legal;
- cuidador autorizado.

Responsabilidade principal:

- transformar percepcoes familiares em rotina de apoio pedagogico.

### Professor

Pessoa adulta vinculada a aluno, turma ou grupo de reforco.

Exemplos:

- professor da escola;
- tutor pedagogico;
- coordenador de reforco;
- profissional de acompanhamento escolar.

Responsabilidade principal:

- transformar objetivos pedagogicos em tarefas, evidencias e relatorios tecnicos para acompanhamento.

### Crianca ou aluno

Pessoa que executa as atividades.

Responsabilidade principal:

- praticar tarefas liberadas e receber feedback adequado ao seu momento.

### Administrador

Pessoa responsavel por configuracao operacional da plataforma.

Responsabilidade principal:

- manter modulos, configuracoes, modelos, integracoes, planos, cobranca e operacao do negocio funcionando.

Regra critica:

- administrador do negocio nao acessa dados pedagogicos individuais, textos, percepcoes, feedbacks privados, relatorios de criancas ou dados pessoais sensiveis de adultos e criancas;
- o painel administrativo deve trabalhar com dados operacionais, indicadores agregados, faturamento, uso por modulo, suporte tecnico e auditoria;
- o produto pode usar metricas anonimas ou agregadas para entender quantas criancas estao evoluindo, quantas estao com dificuldade por area/modulo e onde o produto precisa melhorar;
- consultas de melhoria do produto devem evitar identificacao individual e precisam respeitar tamanho minimo de amostra para reduzir risco de reidentificacao;
- acesso a qualquer dado especifico de uma crianca, adulto, escola ou turma identificavel so pode ocorrer com autorizacao explicita dos responsaveis legais ou da escola autorizada;
- qualquer necessidade excepcional de suporte que envolva conteudo individual deve depender de mecanismo especifico, autorizado, auditado e desenhado fora do acesso administrativo rotineiro.

## Niveis de informacao

### Nivel 1: infantil seguro

Pode aparecer para a crianca.

Inclui:

- tarefa do dia;
- instrucao simples;
- feedback positivo;
- proxima tentativa pequena;
- progresso visual simples.

Nao inclui:

- preocupacoes do adulto;
- rotulos;
- diagnosticos;
- relatorio tecnico;
- comparacao com outras criancas;
- observacoes privadas.

### Nivel 2: pedagogico adulto

Pode aparecer para responsavel e professor autorizados.

Inclui:

- metas;
- evidencias;
- resumo de atividade;
- pontos de atencao;
- receitas de apoio;
- sugestoes de intervencao;
- historico longitudinal.

### Nivel 3: privado adulto

Pode aparecer apenas para o adulto que registrou ou para quem ele autorizou.

Inclui:

- percepcoes familiares;
- preocupacoes sensiveis;
- notas privadas;
- contexto familiar;
- observacoes que nao devem ir para a crianca.

### Nivel 4: operacional

Pode aparecer para administracao operacional e tecnica, sem expor conteudo pedagogico individual.

Inclui:

- logs;
- integracoes;
- tokens;
- configuracoes de modulo;
- dados tecnicos de execucao.
- metricas agregadas de uso;
- metricas anonimas de evolucao e dificuldade por modulo, area, faixa etaria, serie ou periodo, sempre com protecao contra reidentificacao;
- status de plano e cobranca;
- indicadores de ativacao, inatividade e suporte.

Nao inclui:

- textos de criancas;
- percepcoes de adultos;
- feedback adulto privado;
- relatorios longitudinais individuais;
- historico pedagogico individual identificavel.

## Objetos que precisam de classificacao

Todo dado sensivel deve nascer com classificacao clara. A Etapa 2 deve transformar isso em colunas, policies ou funcoes.

| Objeto | Classificacao padrao | Pode virar conteudo infantil? | Observacao |
|---|---|---|---|
| Percepcao do adulto | Nivel 3 | Nao diretamente | Precisa virar meta ou tarefa segura |
| Observacao pedagogica | Nivel 2 ou 3 | Nao diretamente | Pode alimentar plano adulto |
| Meta | Nivel 2 | Parcialmente | A crianca ve a tarefa, nao a formulacao sensivel |
| Tarefa | Nivel 1 ou 2 | Sim | Texto infantil deve ser revisado/gerado para crianca |
| Feedback infantil | Nivel 1 | Sim | Sempre positivo, curto e acionavel |
| Feedback adulto | Nivel 2 | Nao | Pode conter leitura mais completa |
| Evidencia bruta | Nivel 2 | Nao por padrao | Adulto/professor usa para acompanhar |
| Relatorio longitudinal | Nivel 2 | Nao | Conteudo adulto |
| Log tecnico | Nivel 4 | Nao | Operacional |
| Metrica agregada de negocio | Nivel 4 | Nao | Pode alimentar painel administrativo |
| Metrica anonima de evolucao | Nivel 4 | Nao | Pode melhorar produto se nao identificar crianca, adulto, escola ou turma pequena |

## Matriz de permissoes por area

| Area | Responsavel | Professor | Crianca | Admin |
|---|---|---|---|---|
| Login adulto | Sim | Sim | Nao | Nao no painel pedagogico |
| Login administrativo | Nao | Nao | Nao | Sim |
| Acesso infantil por link/codigo | Nao | Nao | Sim | Nao |
| Criar crianca | Sim | Sim, se autorizado | Nao | Nao |
| Ver crianca vinculada | Sim | Sim, se autorizado | Apenas a si mesma | Nao |
| Editar dados basicos da crianca | Sim | Sim, se autorizado | Nao | Nao |
| Registrar percepcao privada | Sim | Sim | Nao | Nao |
| Ver percepcao privada familiar | Autor | Nao, salvo compartilhamento | Nao | Nao por padrao |
| Ver observacao pedagogica do professor | Se compartilhada | Autor | Nao | Nao por padrao |
| Criar meta | Sim | Sim | Nao | Nao |
| Aprovar meta sugerida pela IA | Sim | Sim | Nao | Nao |
| Editar meta ativa | Sim | Sim, se autor ou autorizado | Nao | Nao |
| Encerrar meta | Sim | Sim, se autor ou autorizado | Nao | Nao |
| Criar tarefa | Sim | Sim | Nao | Nao |
| Liberar tarefa | Sim | Sim | Nao | Nao |
| Ver tarefa liberada | Sim | Sim | Sim | Nao |
| Executar tarefa | Nao | Nao | Sim | Nao |
| Enviar resposta | Nao | Nao | Sim | Nao |
| Ver feedback infantil | Sim | Sim | Sim | Nao |
| Ver feedback adulto | Sim | Sim | Nao | Nao |
| Ver evidencia bruta | Sim | Sim, se autorizado | Nao por padrao | Nao |
| Ver relatorio longitudinal | Sim | Sim, se autorizado | Nao | Nao |
| Gerar relatorio para reuniao | Sim | Sim | Nao | Nao |
| Criar turma | Nao no MVP familiar | Sim | Nao | Nao |
| Atribuir tarefa para turma | Nao | Sim | Nao | Nao |
| Configurar modulo | Nao | Nao | Nao | Sim |
| Ver metricas agregadas de uso | Nao | Nao | Nao | Sim |
| Ver metricas anonimas de evolucao | Nao | Nao | Nao | Sim |
| Rodar analises de melhoria do produto | Nao | Nao | Nao | Sim, apenas com dados anonimos/agregados |
| Gerenciar planos e cobranca | Nao | Nao | Nao | Sim |
| Ver usuarios inativos sem conteudo sensivel | Nao | Nao | Nao | Sim |
| Voltar da area infantil ao painel adulto | Com senha adulta | Com senha adulta | Nao | Com senha adulta |

## Matriz de bloqueios obrigatorios

| Bloqueio | Motivo | Criterio de aceite |
|---|---|---|
| Crianca nao acessa painel adulto | Protecao emocional e privacidade | Link, botao voltar ou URL direta nao devem abrir dados adultos sem confirmacao adulta |
| Crianca nao ve percepcao privada | Adulto pode escrever preocupacoes sensiveis | Toda percepcao deve ser classificada como adulta por padrao |
| Crianca nao ve relatorio tecnico | Relatorio pode conter pontos de atencao | Relatorio aparece apenas em sessao adulta |
| Sessao lembrada nao libera retorno adulto | Computador pode estar com a crianca | Retorno exige senha adulta ou mecanismo equivalente |
| Professor nao ve contexto familiar privado por padrao | Separacao escola-familia | Compartilhamento deve ser explicito |
| Responsavel nao ve dados de turma inteira | Privacidade dos outros alunos | Responsavel ve apenas criancas vinculadas |
| Admin nao acessa conteudo pedagogico individual | Minimizar exposicao e proteger privacidade | Painel admin usa dados de negocio e metricas agregadas, sem textos, percepcoes, feedbacks privados ou relatorios individuais |
| Metrica anonima nao pode reidentificar crianca | Privacidade e LGPD | Analises devem usar agregacao, pseudonimizacao quando necessario e tamanho minimo de amostra |

## Casos limite

### Mesmo adulto como responsavel e professor

Pode acontecer de um adulto atuar nos dois papeis.

Regra:

- o sistema deve permitir mais de um papel por perfil;
- a tela deve deixar claro em qual contexto o adulto esta atuando;
- observacoes familiares e pedagogicas continuam separadas.

### Crianca vinculada a mais de um responsavel

Regra:

- cada responsavel ve a crianca vinculada;
- notas privadas de um responsavel nao sao compartilhadas automaticamente;
- relatorios podem ser compartilhados se houver permissao.

### Professor acessando aluno com autorizacao familiar

Regra:

- professor acessa dados pedagogicos e evidencias autorizadas;
- contexto familiar privado fica oculto por padrao;
- relatorio para pais deve separar evidencias de interpretacoes.

### Crianca usando computador do adulto

Regra:

- sessao adulta lembrada nao libera painel adulto dentro da area infantil;
- retorno ao adulto exige senha, PIN adulto ou mecanismo equivalente;
- links adultos precisam validar sessao adulta e permissao.

### Link infantil compartilhado indevidamente

Regra:

- link/codigo infantil nao deve expor dados adultos;
- link deve abrir apenas tarefas liberadas;
- idealmente deve ter expiracao ou escopo limitado na Etapa 2.

## Fluxos aprovados

### Fluxo familiar com crianca pequena

1. Responsavel entra no portal adulto.
2. Seleciona a crianca.
3. Escolhe ou cria meta.
4. Libera uma tarefa.
5. Abre a area infantil.
6. Crianca executa.
7. Para voltar ao adulto, o sistema pede senha adulta.
8. Responsavel ve evidencias e orientacao.

### Fluxo familiar com crianca maior

1. Responsavel entra no portal adulto.
2. Libera tarefas.
3. Sistema gera link ou codigo infantil.
4. Crianca acessa a area infantil.
5. Crianca ve apenas tarefas liberadas.
6. Responsavel acompanha depois.

### Fluxo professor com reforco

1. Professor entra no portal adulto.
2. Seleciona turma ou aluno.
3. Define meta ou reforco.
4. Atribui tarefas.
5. Aluno acessa por link ou codigo.
6. Sistema registra evidencias.
7. Professor gera relatorio longitudinal para reuniao.

## Decisoes fechadas nesta etapa

1. A crianca tera experiencia propria, separada do painel adulto.
2. No MVP, crianca nao precisa de e-mail e senha.
3. Acesso infantil pode ser por abertura do adulto, link ou codigo.
4. Voltar ao painel adulto exige confirmacao adulta.
5. Percepcoes privadas nunca aparecem na area infantil.
6. Professor e responsavel podem ter visoes diferentes da mesma crianca, respeitando compartilhamento.
7. Relatorio longitudinal e conteudo adulto.
8. Feedback infantil e sempre curto, positivo, seguro e acionavel.
9. O sistema deve permitir que um perfil adulto tenha mais de um papel.
10. A Etapa 2 deve prever expiracao ou limitacao de escopo para acesso infantil por link/codigo.

## Riscos identificados

### Risco 1: adulto escrever algo sensivel

Mitigacao:

- toda percepcao nasce como privada adulta;
- o sistema deve transformar percepcao em meta pedagogica antes de qualquer uso infantil;
- a crianca recebe apenas tarefa e feedback seguro.

### Risco 2: professor e familia misturarem contextos

Mitigacao:

- separar observacao familiar, observacao pedagogica e relatorio compartilhado;
- exigir permissao explicita para compartilhamento.

### Risco 3: crianca acessar relatorio tecnico

Mitigacao:

- area infantil nao consulta endpoints adultos;
- URLs adultas exigem sessao adulta;
- retorno adulto exige senha.

### Risco 4: comparacao inadequada entre alunos

Mitigacao:

- relatorios priorizam evolucao da propria crianca;
- visao de turma deve servir ao planejamento do professor, nao a ranking para crianca ou familia.

## Checklist de aceite da Etapa 1

- [x] Papeis principais definidos.
- [x] Niveis de informacao definidos.
- [x] Objetos de informacao classificados.
- [x] Matriz de permissoes criada.
- [x] Bloqueios obrigatorios documentados.
- [x] Casos limite mapeados.
- [x] Fluxos adulto-crianca-professor definidos.
- [x] Decisoes fechadas registradas.
- [x] Riscos principais mapeados.
- [x] Base pronta para Etapa 2: regras de acesso/Supabase.

## Saida para a Etapa 2

A proxima etapa deve transformar esta matriz em:

- tabelas;
- relacionamentos;
- politicas RLS;
- funcoes seguras;
- endpoints;
- testes de acesso.

Documento recomendado para a proxima etapa:

```text
docs/prd-controle-de-acesso-supabase.md
```
