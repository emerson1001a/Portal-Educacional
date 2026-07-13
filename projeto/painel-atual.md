# Painel Atual do Projeto

Este arquivo e a leitura rapida para retomar o Portal Educacional sem depender da memoria da conversa.

## Estado do produto

O Portal Educacional ja funciona como plataforma inicial com:

- login adulto por Supabase;
- cadastro de criancas;
- area infantil separada por link temporario;
- entrada infantil por codigo curto preparada para uso quando a migracao recomendada estiver aplicada;
- criacao de missoes pelo adulto;
- retorno de evidencias dos modulos para o historico adulto;
- resumo do desenvolvimento com base da leitura separando evidencias, metas e percepcoes;
- relatorio longitudinal adulto com metricas, leitura por area, base de evidencias e plano curto;
- modulos conectados: Redacao, Interpretacao e Tabuada;
- Tabuada configuravel por missao quando a migracao `assignment_items.config` esta aplicada;
- Ingles documentado como modulo futuro, sem implementacao imediata.

## Principio central

O adulto organiza a intencao pedagogica. A crianca recebe apenas uma missao curta, positiva e executavel.

O portal deve mostrar evolucao longitudinal, sempre comparando a crianca com ela mesma e evitando linguagem de rotulo, diagnostico ou pressao.

## O que esta pronto para uso real

- Adulto cria conta e entra no portal.
- Adulto cadastra criancas.
- Adulto cria missoes com um ou mais modulos.
- Crianca acessa a area infantil pelo link ou por codigo curto, quando disponivel.
- Adulto consegue abrir a missao infantil no mesmo computador para testar ou entregar a tarefa.
- Crianca conclui atividades.
- Portal adulto recebe historico e sinais de progresso.
- Missoes concluidas deixam de parecer pendentes na area infantil.
- Adulto consegue abrir um relatorio longitudinal inicial para reuniao ou acompanhamento.
- Indicadores do momento comparam evidencias, continuidade, metas e areas praticadas.

## O que ainda precisa observacao em teste real

- Usar `projeto/checklist-teste-real.md` para registrar sessoes com Miguel e Gabriel sem transformar o uso em burocracia.
- Usar Pedro Antonio e Jose Carlos como perfis ficticios quando for preciso testar fluxo sem misturar com casos reais.
- Clareza da navegacao entre adulto, crianca e modulos.
- Qualidade do feedback recebido pelo adulto.
- Se o historico e o relatorio continuam faceis de interpretar depois de varios dias de uso.
- Se as missoes ficam na dose certa para a crianca.
- Se a diferenca entre "Abrir missao infantil" e "Gerar link infantil" esta clara para o adulto.
- Se a entrada por codigo curto e simples o suficiente para criancas e sala de aula.
- Se a Tabuada registra evidencias sem poluir o historico.
- Se Interpretacao e Redacao mantem coerencia, navegabilidade e retorno claro.
- Se o adulto entende a diferenca entre evidencia do modulo, meta pedagogica e percepcao privada.

## Banco e migracoes

Fonte de verdade: `docs/supabase-migrations-checklist.md`.

Validacao rapida em producao:

```text
/api/supabase-status
```

Leitura do resultado:

- `status: "ready"`: banco pronto para o fluxo atual;
- `summary.required.missing`: falta algo obrigatorio;
- `summary.recommended.missing`: melhoria recomendada, mas nao necessariamente bloqueia o portal;
- migracao de Ingles e preparacao futura, nao precisa ser rodada para os testes atuais.

## Proximas prioridades sugeridas

1. Testar relatorio longitudinal com dados reais de Miguel e Gabriel por alguns dias.
2. Revisar navegabilidade e identidade visual dos modulos atuais, agora partindo do fluxo de missao infantil como referencia.
3. Melhorar dose pedagogica das missoes com base nos testes reais.
4. Definir modelo de compartilhamento responsavel/professor sem expor dados sensiveis.
5. Depois dos testes reais, decidir se o foco inicial comercial e pais, professores ou ambos com entradas diferentes.

## Regras que nao podemos esquecer

- Crianca nunca ve percepcao sensivel do adulto.
- Adulto recebe orientacao completa, mas com linguagem acolhedora e pratica.
- Crianca recebe feedback curto, positivo e orientado a proxima acao.
- O produto nao diagnostica.
- Quando sugerir apoio profissional, a frase deve ampliar apoio, nao assustar ou rotular.
- Gamificacao deve reforcar progresso proprio, nao ranking ou comparacao com outras criancas.
- Modulos futuros devem ser plugaveis sem quebrar o historico central.

## Como retomar em nova janela

1. Ler este arquivo.
2. Abrir `projeto/backlog.md`.
3. Abrir `projeto/checklist-teste-real.md` se estivermos analisando uso real ou massa de teste.
4. Abrir `projeto/roadmap.md`.
5. Verificar `git status`.
6. Escolher uma entrega pequena, testar e registrar commit.
