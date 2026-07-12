# Backlog

## Agora

- Usar `projeto/painel-atual.md` como ponto de retomada em novas janelas do Codex.
- Testar o fluxo diario com Miguel e Gabriel por alguns dias, registrando confusoes, atritos e evidencias uteis.
- Validar `/api/supabase-status` em producao sempre que uma migracao parecer faltar.
- Testar missao com meta vinculada, prazo, nota adulta, progresso por item e retorno claro para a crianca.
- Melhorar o historico unificado para mostrar texto e feedback dos modulos de forma expansivel, sem ocupar espaco demais.
- Consolidar o primeiro desenho do relatorio longitudinal adulto.
- Validar em producao a Interpretacao de Texto corrigida: perguntas devem se apoiar somente em evidencias do texto e o feedback final deve ficar visualmente destacado.
- Validar em producao o bloco "Meta Pedagogica": "Organizar Percepcao" deve devolver orientacao da IA ou uma meta segura de contingencia, sem erro tecnico para o adulto.
- Revisar navegabilidade geral entre portal adulto, portal infantil, Redacao, Interpretacao e Tabuada, garantindo retorno claro ao portal infantil/principal.
- Confirmar se o codigo curto infantil sera testado agora ou se continua como melhoria recomendada para sala de aula.

## Proximo

- Definir modelo de compartilhamento entre responsavel e professor.
- Especificar primeira camada de gamificacao leve para a area infantil.
- Refinar historico de missoes concluidas na area infantil depois dos testes reais.
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

- Relatorio longitudinal.
- Unificacao visual e logica dos modulos.
- Catalogo de modulos plugaveis e jornadas de apoio.
- Preparar habilitacao futura por modulo, sem expor bloqueios comerciais para a crianca.
- Redacao: avaliar se o bloco lateral de missoes deve ser eliminado e integrado ao bloco principal, com a etapa evoluindo dentro do fluxo central.
- Definir arquitetura comercial/funcional por modulos plugaveis, sem alterar ou excluir modulos durante o periodo inicial de testes.

## Pendente de decisao

- Produto deve priorizar inicialmente pais ou professores? Proposta atual: focar pais como publico primario inicial, mantendo arquitetura preparada para professores e turmas.
- Crianca maior precisara de PIN infantil em etapa posterior?
- Professor podera convidar responsavel por e-mail?
- Responsavel podera compartilhar relatorio com professor por link?
- Admin tera tela propria ou apenas acesso operacional inicial?
- Quais jornadas iniciais fazem sentido: leitura, escrita, matematica, idiomas, organizacao?
- A habilitacao comercial futura sera por conta, crianca, turma, escola ou pacote?
