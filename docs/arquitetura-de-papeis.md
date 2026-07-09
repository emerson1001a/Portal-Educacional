# Arquitetura de Papeis e Permissoes

## Regra central

O adulto decide, configura e acompanha. A crianca executa, pratica e recebe apoio seguro.

A separacao entre adulto e crianca e uma regra estrutural do produto, nao apenas uma escolha visual.

## Papeis

### Responsavel

Pai, mae, tutor ou adulto responsavel pela crianca.

Pode:

- criar e editar criancas vinculadas a si;
- registrar percepcoes privadas;
- criar metas;
- aprovar metas sugeridas pela IA;
- liberar tarefas;
- abrir a area da crianca;
- ver historico, evidencias e relatorios;
- receber orientacao da IA;
- gerar relatorio para acompanhamento.

Nao pode:

- ver criancas sem vinculo;
- expor observacoes sensiveis na area infantil;
- alterar evidencias historicas como se fossem producao original da crianca.

### Professor

Adulto com funcao pedagogica, atuando com aluno individual, grupo ou turma.

Pode:

- criar turmas ou grupos de reforco;
- vincular alunos autorizados;
- atribuir tarefas por aluno ou grupo;
- acompanhar execucoes;
- registrar observacoes pedagogicas;
- gerar relatorios para reuniao com pais;
- receber sugestoes de intervencao pedagogica.

Nao pode:

- acessar dados familiares privados que nao foram compartilhados;
- criar diagnosticos;
- usar ranking competitivo como leitura principal de progresso;
- expor para a crianca observacoes tecnicas ou sensiveis.

### Crianca ou aluno

Usuario de execucao.

Pode:

- acessar tarefas liberadas;
- abrir modulos;
- responder atividades;
- receber feedback infantil;
- ver progresso simples e seguro;
- devolver evidencias ao portal.

Nao pode:

- acessar painel adulto;
- ver percepcoes privadas;
- ver relatorios tecnicos;
- ver preocupacoes registradas pelo adulto;
- criar ou alterar metas;
- liberar modulos por conta propria, salvo atividades livres explicitamente permitidas.

### Administrador

Papel operacional da plataforma.

Pode:

- configurar modulos;
- revisar integracoes;
- manter modelos de relatorio;
- revisar logs tecnicos;
- ajustar permissoes globais.

Nao deve:

- acessar conteudo sensivel sem necessidade operacional;
- alterar historico pedagogico sem trilha de auditoria.

## Matriz resumida

A matriz completa e fechada da Etapa 1 esta em `prd-matriz-de-papeis.md`.

Esta secao resume as permissoes principais para leitura rapida.

| Acao | Responsavel | Professor | Crianca | Admin |
|---|---:|---:|---:|---:|
| Entrar com e-mail e senha | Sim | Sim | Nao no inicio | Sim |
| Acessar por link/codigo infantil | Nao | Nao | Sim | Nao |
| Cadastrar crianca | Sim | Sim, se autorizado | Nao | Sim |
| Registrar percepcao privada | Sim | Sim | Nao | Nao |
| Criar meta | Sim | Sim | Nao | Sim |
| Aprovar meta sugerida por IA | Sim | Sim | Nao | Nao |
| Liberar tarefa | Sim | Sim | Nao | Sim |
| Executar tarefa | Nao | Nao | Sim | Nao |
| Ver feedback infantil | Sim | Sim | Sim | Sim |
| Ver feedback adulto | Sim | Sim | Nao | Sim, se necessario |
| Ver relatorio longitudinal | Sim | Sim | Nao | Sim, se necessario |
| Voltar da area infantil ao painel adulto | Com senha | Com senha | Nao | Com senha |

## Fluxos de acesso

### Adulto em casa

1. Responsavel entra com e-mail e senha.
2. Escolhe a crianca.
3. Registra percepcao ou escolhe meta.
4. Libera tarefas.
5. Abre a area da crianca ou envia link/codigo.
6. Crianca executa.
7. Responsavel recebe orientacao e historico.

### Crianca pequena

1. Adulto entra no portal.
2. Adulto seleciona a crianca.
3. Adulto abre a area infantil.
4. Crianca faz a atividade.
5. Para voltar ao painel adulto, o sistema pede senha do adulto.

### Crianca maior

1. Adulto libera tarefas.
2. Sistema gera link ou codigo infantil.
3. Crianca acessa diretamente a propria area.
4. Crianca executa tarefas liberadas.
5. Adulto acompanha depois.

### Professor em reforco

1. Professor entra no portal.
2. Escolhe turma ou aluno.
3. Define reforco por habilidade.
4. Libera tarefas.
5. Aluno acessa por codigo/link.
6. Professor acompanha evidencias.
7. Professor gera relatorio para reuniao com pais.

## Decisoes recomendadas

### Autenticacao infantil

Nao usar e-mail e senha para criancas no primeiro momento.

Recomendacao inicial:

- crianca pequena: adulto abre a area infantil;
- crianca maior: link ou codigo curto;
- sala de reforco: codigo por aluno ou tarefa.

### Retorno ao adulto

Sempre exigir confirmacao adulta para sair da area infantil e voltar ao painel adulto.

No estagio atual:

- e-mail do adulto preenchido automaticamente;
- senha exigida novamente;
- sessao lembrada nao deve liberar retorno automatico.

### Linguagem

Usar "apoio pedagogico e socioemocional seguro" em vez de "feedback psicologico" no produto.

O produto pode apoiar persistencia, confianca, rotina, tolerancia a erro e autoestima, mas nao deve sugerir avaliacao clinica sem profissional habilitado.

## Proximos PRDs derivados

- `prd-matriz-de-papeis.md` (fechado na Etapa 1)
- `prd-controle-de-acesso-supabase.md`
- `prd-portal-crianca.md`
- `prd-metas-e-tarefas.md`
- `prd-turma-e-professor.md`
- `prd-relatorio-longitudinal.md`
