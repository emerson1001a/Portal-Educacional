# Documento do Projeto: Portal Educacional

## Resumo

O Portal Educacional e uma plataforma para pais, responsaveis e professores acompanharem e reforcarem o desenvolvimento escolar de criancas e adolescentes.

O produto organiza percepcoes do adulto, sugere metas pedagogicas, libera atividades nos modulos de aprendizagem, registra evidencias e mostra evolucao longitudinal.

O foco nao e comparar a crianca com outras criancas. O foco e mostrar progresso em relacao ao proprio percurso dela, com feedback positivo, pratico e seguro.

## Problema

Pais e professores frequentemente percebem dificuldades, mas nao sabem transformar essa percepcao em uma acao pequena, consistente e bem orientada.

Sem evidencias organizadas, a conversa costuma ficar vaga:

- "acho que ele nao presta atencao";
- "acho que ele tem dificuldade para escrever";
- "nao sei se esta melhorando";
- "nao sei o que pedir para ele fazer agora".

O portal existe para transformar essa aflicao em um processo observavel:

1. registrar a percepcao;
2. organizar uma meta;
3. indicar uma atividade;
4. acompanhar a execucao;
5. gerar feedback para a crianca;
6. orientar o adulto;
7. construir historico longitudinal.

## Publicos

### Responsaveis

Pais, maes e tutores que querem apoiar a crianca em casa, sem precisar dominar tecnicas pedagogicas.

Precisam de:

- clareza sobre o que observar;
- sugestoes de atividades;
- orientacao sobre como elogiar e corrigir;
- relatorio simples de evolucao;
- seguranca para saber quando continuar observando e quando buscar apoio externo.

### Professores

Professores, tutores e profissionais de reforco que acompanham uma ou varias criancas.

Precisam de:

- visao por aluno;
- visao por turma ou grupo;
- tarefas atribuidas;
- evidencias de execucao;
- relatorios para reuniao com pais;
- linguagem tecnica, mas cuidadosa e defensavel.

### Criancas e adolescentes

Usuarios que executam as atividades.

Precisam de:

- instrucoes claras;
- ambiente sem informacoes sensiveis;
- feedback curto, positivo e acionavel;
- experiencia que preserve autoria, autoestima e vontade de tentar.

## Promessa do produto

O Portal Educacional ajuda o adulto a saber:

- o que a crianca precisa reforcar;
- qual atividade pedir agora;
- como orientar sem pressionar;
- se a crianca esta evoluindo;
- quais evidencias sustentam essa leitura.

## Principios

1. A crianca nunca deve acessar conteudo sensivel do adulto.
2. Feedback infantil deve ser curto, positivo e direcionado a uma proxima tentativa.
3. Feedback adulto deve ser mais completo, mas sempre terminar com uma acao concreta.
4. A evolucao deve ser longitudinal e individual.
5. O sistema deve evitar rotulos, diagnosticos e alarmismo.
6. Quando houver pouca evidencia, a IA deve dizer que ainda e cedo para concluir.
7. A plataforma deve estar pronta para plugar novos modulos.

## Ambientes do produto

### Portal adulto

Ambiente autenticado para pais, responsaveis, professores e administradores.

Funcoes:

- cadastrar criancas;
- criar metas;
- atribuir tarefas;
- acompanhar modulos;
- ler relatorios;
- registrar percepcoes privadas;
- receber orientacao da IA;
- gerar relatorio longitudinal.

### Portal da crianca

Ambiente de execucao das atividades.

Funcoes:

- receber tarefas liberadas;
- abrir modulos;
- seguir orientacoes passo a passo;
- receber feedback seguro;
- devolver evidencias para o portal.

Nao deve exibir:

- percepcoes sensiveis do adulto;
- observacoes privadas;
- relatorios tecnicos;
- hipoteses pedagogicas internas;
- preocupacoes familiares ou escolares.

## Modulos iniciais

- Interpretacao de Texto;
- Missao Redacao;
- Tabuada Inteligente.

Cada modulo deve produzir feedback pontual da atividade. O portal consolida os sinais ao longo do tempo.

## Dados centrais

Entidades principais previstas:

- `profiles`: adultos autenticados;
- `children`: criancas e adolescentes;
- `child_guardians`: vinculos entre adultos e criancas;
- `classrooms`: turmas ou grupos;
- `classroom_students`: vinculo entre professor, turma e alunos;
- `learning_goals`: metas pedagogicas;
- `assignments`: tarefas atribuidas;
- `assignment_items`: itens de tarefa;
- `activity_sessions`: execucoes de atividade;
- `learning_evidence`: evidencias produzidas;
- `progress_snapshots`: retratos periodicos de evolucao;
- `adult_guidance`: orientacoes para adultos;
- `child_feedback`: feedbacks exibidos para criancas;
- `reports`: relatorios gerados.

## IA no produto

A IA pode apoiar:

- organizacao de percepcoes do adulto;
- sugestao de metas;
- escolha de tarefas;
- feedback durante atividades;
- resumo de evidencias;
- orientacao para pais e professores;
- relatorios longitudinais.

A IA nao deve:

- diagnosticar;
- rotular a crianca;
- sugerir conclusoes sem evidencia suficiente;
- expor informacoes adultas para a crianca;
- substituir avaliacao profissional quando houver sinais persistentes ou intensos.

## Relatorio longitudinal

O relatorio longitudinal e uma das partes mais valiosas do produto.

Ele deve mostrar:

- ponto de partida;
- metas trabalhadas;
- atividades realizadas;
- evidencias geradas;
- evolucao por habilidade;
- estrategias que funcionaram;
- pontos de atencao;
- proxima acao recomendada.

Para professores, o relatorio deve ajudar reunioes com pais com linguagem tecnica, palpavel, defensavel e apoiada por evidencias.

## Roadmap inicial

### Fase 1: Base segura

- separar area adulta e area da crianca;
- proteger retorno ao painel adulto;
- documentar papeis e permissoes;
- consolidar schema Supabase;
- garantir registros de evidencias.

### Fase 2: Tarefas

- permitir que adulto atribua tarefas;
- permitir que crianca veja tarefas liberadas;
- registrar conclusao;
- conectar modulos ao fluxo de tarefas.

### Fase 3: Evolucao longitudinal

- consolidar snapshots;
- criar comparacoes ao longo do tempo;
- gerar resumo por area;
- criar relatorio para pais e professores.

### Fase 4: Turmas e reforco

- criar turmas;
- permitir atribuicao por grupo;
- permitir visao do professor;
- gerar relatorios por aluno.

### Fase 5: Validacao profissional

- revisar regras de linguagem;
- revisar sinais para recomendacao de apoio externo;
- revisar frases da IA;
- documentar limites eticos e pedagogicos.

### Fase 6: Unificacao visual e logica dos modulos

- alinhar Redacao, Leitura e Tabuada ao mesmo visual;
- padronizar entrada da crianca;
- padronizar retorno ao portal;
- padronizar feedback infantil e feedback adulto;
- padronizar contrato de evidencias;
- garantir que todos os modulos respondam a tarefas atribuidas pelo adulto;
- fazer os modulos parecerem partes de uma plataforma unica.

## Decisoes em aberto

- Crianca deve acessar por codigo, link, PIN ou conta propria?
- Professor pode convidar responsaveis diretamente?
- Como tratar criancas vinculadas a mais de um adulto?
- Como controlar compartilhamento entre escola e familia?
- Quais indicadores entram no primeiro relatorio longitudinal?
- Quais frases precisam de validacao profissional antes de producao ampla?
