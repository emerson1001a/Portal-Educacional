# PRD: Modulos Plugaveis e Jornadas de Apoio

## Contexto

O Portal Educacional nasceu de uma experiencia concreta de apoio ao desenvolvimento escolar: a crianca pratica com orientacao positiva, o adulto recebe uma leitura mais completa e o sistema organiza evidencias ao longo do tempo.

A plataforma nao deve ser pensada como um unico aplicativo de redacao, leitura ou tabuada. Ela deve ser uma base de acompanhamento longitudinal capaz de receber modulos de aprendizagem diferentes.

## Ponderacao de produto

A ideia de vender ou habilitar o produto por modulo e forte, mas precisa ser tratada com cuidado.

O produto nao deve falar com pais e professores apenas como "compre a materia X". A linguagem principal deve ser de jornada de apoio:

- leitura e interpretacao;
- escrita e redacao;
- matematica fundamental;
- ingles inicial;
- organizacao e rotina de estudos;
- acompanhamento longitudinal;
- relatorios para familia e escola.

Isso ajuda o adulto a comprar ou habilitar aquilo que resolve uma necessidade real, sem rotular a crianca e sem transformar uma dificuldade em identidade.

## Objetivo

Definir uma arquitetura de modulos plugaveis para que novos dominios possam entrar no portal sem refazer a base.

O portal deve continuar responsavel por:

- identidade do adulto;
- criancas e vinculos;
- permissoes;
- metas;
- missoes;
- historico unificado;
- leitura longitudinal;
- orientacao ao adulto;
- relatorios.

Cada modulo deve ser responsavel por:

- experiencia de pratica;
- feedback pontual da atividade;
- coleta de metricas especificas;
- devolucao de evidencias ao portal;
- linguagem infantil adequada ao seu dominio.

## Escopo desta decisao

Esta decisao prepara a arquitetura. Ela nao implementa agora:

- cobranca;
- planos pagos;
- checkout;
- bloqueio comercial por assinatura;
- modulo de Ingles;
- tela administrativa completa de catalogo.

Esses itens podem ser planejados depois, quando o ciclo central do portal estiver bem validado.

## Modelo conceitual

### Modulo

Um modulo e uma experiencia de aprendizagem plugada ao Portal Educacional.

Exemplos:

- `interpretacao`;
- `redacao`;
- `tabuada`;
- futuro `ingles_inicial`.

### Jornada

Uma jornada agrupa modulos e metas em torno de uma necessidade do adulto.

Exemplos:

- "ganhar confianca na escrita";
- "melhorar compreensao de textos";
- "fortalecer fatos basicos de multiplicacao";
- "construir vocabulario inicial em ingles".

### Habilidade

Uma habilidade e um sinal pedagogico acompanhado no tempo.

Exemplos:

- compreensao literal;
- inferencia;
- organizacao de ideias;
- inicio, meio e fim;
- fluencia de tabuada;
- vocabulario em ingles;
- autonomia;
- tolerancia a erro.

## Contrato minimo de catalogo

Cada modulo deve ter:

```json
{
  "id": "interpretacao",
  "name": "Interpretacao de Texto",
  "short_name": "Interpretacao",
  "area": "leitura",
  "journey": "leitura_e_interpretacao",
  "description": "Leitura, perguntas e feedback para compreensao.",
  "url": "https://interpretacao-de-texto.vercel.app",
  "status": "available",
  "accent": "reading",
  "icon": "L",
  "skills": ["compreensao_literal", "inferencia", "atencao_ao_texto"],
  "commercial_key": "module_reading"
}
```

Campos como `journey`, `skills` e `commercial_key` podem comecar apenas como metadados. Eles preparam a plataforma para filtro, relatorio, permissao e futura comercializacao por modulo.

## Status possiveis

- `available`: modulo publicado e utilizavel.
- `planned`: modulo planejado, exibido como futuro ou oculto conforme decisao de produto.
- `internal`: modulo em teste interno.
- `disabled`: modulo desativado.

## Regra de habilitacao

No futuro, uma conta, escola, turma ou crianca podera ter apenas alguns modulos habilitados.

Mesmo assim, a experiencia pedagogica nao deve dizer "voce nao comprou este modulo" para a crianca. A crianca deve ver apenas atividades liberadas.

Para o adulto, a linguagem pode ser:

- "modulo disponivel no seu plano";
- "modulo planejado";
- "fale conosco para habilitar";
- "em breve".

## Evidencias e artefatos

Todo modulo deve devolver ao portal um evento com:

- `service` ou `module_id`;
- `activity_type`;
- `title`;
- `metrics`;
- `feedback.child`;
- `feedback.adult`;
- `artifacts`.

O portal deve aceitar artefatos diferentes por modulo:

- texto produzido;
- texto lido;
- respostas;
- lista de palavras;
- audio;
- imagem;
- tempo de execucao;
- tentativas;
- acertos;
- revisoes.

## Exemplo futuro: Ingles

O modulo de Ingles nao deve ser implementado agora, mas deve caber na arquitetura.

Possiveis habilidades:

- vocabulario por tema;
- compreensao de comandos simples;
- associacao palavra-imagem;
- frases simples;
- escuta inicial;
- pronuncia, apenas em fase posterior.

Ponto de cuidado:

O modulo de Ingles nao deve nascer como um "jogo solto". Ele deve registrar evidencias que ajudem o adulto a entender se a crianca esta ganhando vocabulario, confianca e disposicao para tentar.

## Criterios de aceite

- Novos modulos podem ser adicionados ao catalogo sem alterar a estrutura central do portal.
- O portal consegue abrir modulos com token de retorno.
- O portal consegue receber evidencias de qualquer modulo que siga o contrato.
- O historico unificado separa feedback pontual de leitura longitudinal.
- A crianca ve apenas modulos e missoes liberados.
- O adulto consegue entender quais modulos estao disponiveis, planejados ou futuramente habilitaveis.
- A linguagem comercial futura nao deve criar rotulos, culpa ou medo.

## Decisao

O Portal Educacional sera tratado como plataforma de evolucao educacional com modulos plugaveis.

Os modulos podem sustentar uma futura estrategia comercial por jornada ou por dominio de aprendizagem, mas a experiencia principal do produto deve continuar centrada em apoio positivo, personalizacao, evidencias e evolucao longitudinal.
