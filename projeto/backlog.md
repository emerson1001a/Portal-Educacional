# Backlog

## Agora

- Usar `projeto/painel-atual.md` como ponto de retomada em novas janelas do Codex.
- Usar `projeto/checklist-teste-real.md` para registrar os testes reais sem depender de memoria ou impressao solta.
- Usar Pedro Antonio e Jose Carlos como perfis ficticios para testes de fluxo, preservando Miguel e Gabriel como casos reais.
- Testar o fluxo diario com Miguel e Gabriel por alguns dias, registrando confusoes, atritos e evidencias uteis.
- Validar `/api/supabase-status` em producao sempre que uma migracao parecer faltar.
- Repetir o teste ponta a ponta com Interpretacao e Tabuada: meta vinculada, missao infantil, atividade concluida, evidencia no adulto e fechamento da meta.
- Testar se o historico unificado continua facil de interpretar depois de varios dias de atividades.
- Testar o primeiro relatorio longitudinal adulto com dados reais, verificando se a leitura por area, a base de evidencias e os indicadores ajudam na conversa com o responsavel/professor.
- Validar em producao a Interpretacao de Texto corrigida: perguntas devem se apoiar somente em evidencias do texto e o feedback final deve ficar visualmente destacado.
- Validar em producao o bloco "Meta Pedagogica": "Organizar Percepcao" deve devolver orientacao da IA ou uma meta segura de contingencia, sem erro tecnico para o adulto.
- Testar navegabilidade geral entre portal adulto, portal infantil, Redacao, Interpretacao e Tabuada, garantindo retorno claro ao portal infantil/principal.
- Testar o codigo curto infantil em producao quando a migracao recomendada estiver aplicada no Supabase.

## Proximo

- Validar o PRD de compartilhamento entre responsavel e professor antes de implementar convites e permissoes.
- Refinar historico de missoes concluidas depois dos testes reais, avaliando se a separacao entre andamento e concluidas ficou clara.
- Refinar primeira camada de gamificacao leve depois dos testes reais, mantendo foco em progresso proprio, sem ranking.
- Refinar relatorio longitudinal depois dos primeiros dias de uso real, especialmente clareza para reuniao e orientacao pratica do adulto.
- Tabuada: permitir que adulto defina quantidade de tentativas ou tempo de treino; IA pode sugerir carga pedagogica adequada para evitar estresse.
- Redacao: criar fluxo de impressao e digitalizacao assistida para criancas com dificuldade de digitacao. Adulto imprime a proposta/folha, a crianca escreve a mao, a IA le/transcreve o texto, o adulto confere e corrige eventuais erros de leitura, e so entao a redacao entra no fluxo normal de analise, feedback, conclusao da missao e registro no portal adulto. Cuidado pedagogico: preservar autoria da crianca e registrar que houve transcricao assistida.

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

- Ajustes de teste da Tabuada: retorno ao Portal com marcacao de item concluido, multiplicacao sem quebra de linha, area de resposta reposicionada e fallback curto de tabuadas em missao infantil.
- Fluxo ponta a ponta da Redacao validado em teste real: adulto criou meta vinculada, crianca fez a redacao, evidencia voltou ao portal adulto e a meta foi revisada/fechada.
- Tabuada mostra a resposta por um instante antes da tentativa, apoiando memorizacao sem contar esse tempo como resposta.
- Interpretacao sugere tamanho/complexidade pela idade, esconde essa escolha da crianca em modo missao e evita usar o nome do aluno como personagem.
- Checklist de teste real para Miguel e Gabriel, com Pedro Antonio e Jose Carlos como perfis ficticios de teste.
- Redacao em modo missao infantil identifica a crianca pelo Portal, sem pedir nome/idade editaveis, e usa titulos/botoes mais claros na escolha do tipo.
- Interpretacao em modo missao infantil usa nome e idade recebidos do Portal, sem campos editaveis para a crianca.
- Tabuada em modo missao registra no portal apenas no fim da atividade, evitando eventos intermediarios no historico adulto.
- Tabuada em modo missao usa nome da crianca como campo nao editavel e trava modo/tabuadas quando configurados pelo adulto.
- Portal adulto com "Registros de percepcao", botao "Salvar percepcao" e cadastro por data de nascimento.
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
- Missoes adultas separadas entre andamento e concluidas, mantendo concluidas como evidencias do percurso.

## Pendente de decisao

- Produto deve priorizar inicialmente pais ou professores? Proposta atual: focar pais como publico primario inicial, mantendo arquitetura preparada para professores e turmas.
- Crianca maior precisara de PIN infantil em etapa posterior?
- Professor podera convidar responsavel por e-mail?
- Responsavel podera compartilhar relatorio com professor por link?
- Admin tera tela propria ou apenas acesso operacional inicial?
- Quais jornadas iniciais fazem sentido: leitura, escrita, matematica, idiomas, organizacao?
- A habilitacao comercial futura sera por conta, crianca, turma, escola ou pacote?
