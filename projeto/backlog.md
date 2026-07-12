# Backlog

## Agora

- Usar `projeto/painel-atual.md` como ponto de retomada em novas janelas do Codex.
- Testar o fluxo diario com Miguel e Gabriel por alguns dias, registrando confusoes, atritos e evidencias uteis.
- Validar `/api/supabase-status` em producao sempre que uma migracao parecer faltar.
- Testar missao com meta vinculada, prazo, nota adulta, progresso por item e retorno claro para a crianca.
- Testar se o historico unificado continua facil de interpretar depois de varios dias de atividades.
- Testar o primeiro relatorio longitudinal adulto com dados reais, verificando se a leitura por area, a base de evidencias e os indicadores ajudam na conversa com o responsavel/professor.
- Validar em producao a Interpretacao de Texto corrigida: perguntas devem se apoiar somente em evidencias do texto e o feedback final deve ficar visualmente destacado.
- Validar em producao o bloco "Meta Pedagogica": "Organizar Percepcao" deve devolver orientacao da IA ou uma meta segura de contingencia, sem erro tecnico para o adulto.
- Testar navegabilidade geral entre portal adulto, portal infantil, Redacao, Interpretacao e Tabuada, garantindo retorno claro ao portal infantil/principal.
- Testar o codigo curto infantil em producao quando a migracao recomendada estiver aplicada no Supabase.

## Proximo

- Validar o PRD de compartilhamento entre responsavel e professor antes de implementar convites e permissoes.
- Refinar historico de missoes concluidas na area infantil depois dos testes reais.
- Refinar primeira camada de gamificacao leve depois dos testes reais, mantendo foco em progresso proprio, sem ranking.
- Refinar relatorio longitudinal depois dos primeiros dias de uso real, especialmente clareza para reuniao e orientacao pratica do adulto.
- Interpretacao: permitir que tamanho e complexidade do texto sejam sugeridos pela IA e/ou pelo adulto, considerando evolucao longitudinal da crianca.
- Interpretacao: evitar que todo texto use a propria crianca como personagem; permitir uso ocasional, mas variar personagens e contextos.
- Interpretacao: em modo missao infantil, nao pedir confirmacao editavel de nome e idade; usar os dados do cadastro.
- Redacao: em modo missao infantil, remover campos editaveis "Seu nome" e "Sua idade" quando a crianca ja estiver identificada.
- Redacao: renomear "Missao 1: quem esta escrevendo?" para um titulo mais adequado, como "Missao Redacao" ou "Preparar Redacao".
- Redacao: ajustar "Missao 2: escolha o tipo" para ficar em sintonia com o novo titulo da missao.
- Redacao: destacar botoes de escolha do tipo de texto ("Uma historia", "Algo que aconteceu comigo", "Minha opiniao") com cor padrao ativa do projeto.
- Portal adulto: renomear bloco "Leituras salvas" para algo como "Registro de Percepcoes" e trocar "Salvar leitura do momento" por "Salvar Percepcao".
- Portal adulto: substituir ano de nascimento por data de nascimento para permitir contexto de mes, semana e dia do aniversario.
- Tabuada: em modo missao infantil, mostrar nome do aluno como nao editavel.
- Tabuada: adulto deve configurar "Modo Treino" e tabuadas a praticar antes da crianca iniciar.
- Tabuada: enviar dados ao portal principal no fim da atividade, nao a cada bloco fixo de tentativas.
- Tabuada: permitir que adulto defina quantidade de tentativas ou tempo de treino; IA pode sugerir carga pedagogica adequada para evitar estresse.
- Tabuada: avaliar mostrar o resultado por alguns milissegundos no inicio de cada nova tabuada como apoio de memorizacao.

## Mais tarde

- Unificacao visual e logica dos modulos.
- Catalogo de modulos plugaveis e jornadas de apoio.
- Painel administrativo do negocio: acompanhar usuarios, contas, criancas cadastradas, modulos utilizados, intensidade de uso, planos, cobranca, inadimplencia, usuarios inativos, churn, suporte, auditoria e indicadores operacionais.
- Painel administrativo nao deve acessar dados pedagogicos individuais, textos, percepcoes, feedbacks privados ou dados pessoais sensiveis de criancas e adultos; deve trabalhar com dados de negocio, metricas agregadas, cobranca, uso, suporte operacional e auditoria.
- Painel administrativo pode ter analytics anonimo para entender quantas criancas estao evoluindo, quantas estao com dificuldade por area/modulo e onde o produto precisa melhorar, sempre com dados agregados ou pseudonimizados, tamanho minimo de amostra e protecao contra reidentificacao.
- Qualquer consulta identificavel de crianca, adulto, turma ou escola so pode ocorrer com autorizacao explicita dos responsaveis legais ou da escola autorizada, alem de trilha de auditoria.
- Antes de criar o painel administrativo, revisar policies, funcoes e endpoints para separar `admin_operacional` de acesso pedagogico. O admin do negocio nao deve herdar permissao para ver criancas, relatorios, percepcoes ou evidencias individuais.
- Modelo escolar/enterprise: desenhar arquitetura com banco dedicado por escola, painel administrativo sem acesso pedagogico individual, contrato de tratamento de dados, auditoria, segregacao de ambientes e regras claras sobre quais dados podem ser usados em analytics anonimo.
- Preparar habilitacao futura por modulo, sem expor bloqueios comerciais para a crianca.
- Redacao: avaliar se o bloco lateral de missoes deve ser eliminado e integrado ao bloco principal, com a etapa evoluindo dentro do fluxo central.
- Definir arquitetura comercial/funcional por modulos plugaveis, sem alterar ou excluir modulos durante o periodo inicial de testes.

## Concluido recentemente

- Historico unificado com texto e feedback expansivel dos modulos, reduzindo espaco ocupado no painel adulto.
- Primeiro relatorio longitudinal adulto com metricas, base de evidencias, leitura por area, receita para o adulto e registros recentes.
- Resumo do Desenvolvimento com card "Base da leitura", separando atividades, metas, percepcoes e metas concluidas.
- Indicadores do momento com comparacao numerica por area nos ultimos 28 dias.
- Registro de percepcao adulto renomeado e com campo de observacao privada.
- Contexto de aniversario a partir da data de nascimento da crianca.
- Retorno claro da atividade infantil para a missao e remocao de tarefas concluidas da area infantil.
- Entrada infantil por codigo curto com tela orientada para a crianca e mesma configuracao das missoes acessadas por link.
- Area infantil interna alinhada as missoes liberadas, sem mostrar catalogo solto de modulos.
- Acoes adultas esclarecidas: abrir missao infantil para testar no mesmo computador e gerar link infantil para enviar a crianca.
- Primeira camada de gamificacao leve na area infantil: barra de progresso da missao e mensagens de avanco sem competicao.
- PRD inicial de compartilhamento responsavel/professor, com escopos, privacidade e revogacao.

## Pendente de decisao

- Produto deve priorizar inicialmente pais ou professores? Proposta atual: focar pais como publico primario inicial, mantendo arquitetura preparada para professores e turmas.
- Crianca maior precisara de PIN infantil em etapa posterior?
- Professor podera convidar responsavel por e-mail?
- Responsavel podera compartilhar relatorio com professor por link?
- Admin tera tela propria ou apenas acesso operacional inicial?
- Quais jornadas iniciais fazem sentido: leitura, escrita, matematica, idiomas, organizacao?
- A habilitacao comercial futura sera por conta, crianca, turma, escola ou pacote?
