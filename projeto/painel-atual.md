# Painel Atual do Projeto

Este arquivo e a leitura rapida para retomar o Portal Educacional sem depender da memoria da conversa.

## Estado do produto

O Portal Educacional ja funciona como plataforma inicial com:

- login adulto por Supabase;
- cadastro de criancas;
- area infantil separada por link temporario;
- criacao de missoes pelo adulto;
- retorno de evidencias dos modulos para o historico adulto;
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
- Crianca acessa a area infantil pelo link.
- Crianca conclui atividades.
- Portal adulto recebe historico e sinais de progresso.
- Missoes concluidas deixam de parecer pendentes na area infantil.

## O que ainda precisa observacao em teste real

- Clareza da navegacao entre adulto, crianca e modulos.
- Qualidade do feedback recebido pelo adulto.
- Se o historico esta facil de interpretar depois de varios dias de uso.
- Se as missoes ficam na dose certa para a crianca.
- Se a Tabuada registra evidencias sem poluir o historico.
- Se Interpretacao e Redacao mantem coerencia, navegabilidade e retorno claro.

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

1. Consolidar relatorio longitudinal do adulto.
2. Refinar historico unificado com textos expansivos de Redacao, Interpretacao e Tabuada.
3. Revisar navegabilidade e identidade visual dos modulos atuais.
4. Melhorar dose pedagogica das missoes com base nos testes de Miguel e Gabriel.
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
3. Abrir `projeto/roadmap.md`.
4. Verificar `git status`.
5. Escolher uma entrega pequena, testar e registrar commit.
