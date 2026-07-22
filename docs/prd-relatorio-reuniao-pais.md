# PRD: Relatorio para Reuniao com Pais

## Status

Documento de trabalho.

Este PRD define o formato, a funcao e os limites do relatorio que a escola ou
o nucleo pedagogico pode apresentar aos pais ou responsaveis em reunioes de
acompanhamento.

Ele nao autoriza implementacao imediata. Antes de implementar, o produto deve
validar o mockup, auditar os dados disponiveis e garantir que o relatorio seja
gerado a partir das mesmas evidencias usadas no Acompanhamento por area.

## Relacao com outros documentos

Este PRD depende de:

- `docs/prd-analise-longitudinal-por-blocos.md`;
- `docs/guia-de-orientacao-pedagogica.md`;
- `docs/prd-metas-e-tarefas.md`;
- `docs/prd-sinais-da-missao.md`.

O relatorio para reuniao com pais nao deve criar uma logica paralela ao portal.
Ele deve ser uma versao comunicavel, revisavel e cuidadosa da analise
longitudinal ja existente no painel adulto.

## Contexto

O painel adulto existe para apoiar decisao pedagogica diaria ou semanal.

Uma reuniao com pais tem outro objetivo: traduzir o acompanhamento em uma
conversa clara, humana, defensavel e orientada a proximos passos.

O relatorio para pais nao deve ser um boletim, uma nota, um diagnostico ou uma
lista exaustiva de atividades.

Ele deve ajudar a escola a dizer:

```text
O que foi observado neste periodo?
Quais evidencias sustentam essa leitura?
O que avancou?
O que ainda precisa de continuidade?
Como a familia pode ajudar sem pressionar a crianca?
Qual sera o proximo passo da escola?
```

## Objetivo

Criar um relatorio que:

- ajude a escola a conduzir reunioes com pais;
- traduza evidencias em linguagem simples e segura;
- mostre a trajetoria da crianca em relacao a ela mesma;
- selecione evidencias representativas, sem despejar todo o historico;
- oriente a familia com acoes pequenas e possiveis;
- preserve a confianca da crianca, dos pais e da escola;
- possa ser revisado pela escola antes de ser compartilhado;
- diferencie relatorio para familia de relatorio tecnico interno.

## Publico

### Leitor principal

- pais;
- maes;
- responsaveis legais.

### Usuario que gera e revisa

- professor;
- coordenador pedagogico;
- nucleo de apoio pedagogico;
- responsavel autorizado pela escola.

### Quem nao deve acessar diretamente

A crianca nao deve acessar esse relatorio pelo Bloco Infantil.

O relatorio pode falar sobre a crianca, mas nao deve ser escrito para a
crianca.

## Pergunta central

O relatorio deve responder:

```text
Como explicar para a familia, com clareza e cuidado, a trajetoria da crianca no periodo e os proximos passos?
```

## Diferenca entre painel e relatorio

### Painel adulto

Funcao:

- acompanhar o dia a dia;
- criar meta;
- liberar missao;
- observar evidencias;
- ajustar rota.

Pergunta que responde:

```text
O que o adulto precisa observar e fazer agora?
```

### Relatorio para reuniao

Funcao:

- preparar conversa com pais;
- apresentar sintese do periodo;
- mostrar evidencias representativas;
- orientar continuidade em casa e na escola.

Pergunta que responde:

```text
Como comunicar o percurso da crianca para a familia?
```

## Periodos suportados

O relatorio deve poder ser gerado por:

- ultimos 30 dias;
- bimestre;
- semestre;
- ano letivo;
- periodo personalizado.

Para escolas, o periodo mais natural tende a ser:

- bimestre, para reunioes regulares;
- semestre, para devolutivas mais completas;
- ano letivo, para consolidacao da trajetoria.

O relatorio nao deve assumir "ultimas 4 semanas" como padrao fixo.

## Tipos de relatorio

### Relatorio bimestral para pais

Foco:

- o que foi trabalhado no ciclo;
- como a crianca respondeu;
- quais sinais apareceram;
- o que a escola pretende manter ou ajustar no proximo bimestre.

### Relatorio semestral para pais

Foco:

- trajetoria mais ampla;
- comparacao entre inicio, meio e fim do periodo;
- evidencias representativas;
- continuidade do plano.

### Relatorio anual ou por 4 bimestres

Foco:

- percurso completo;
- mudancas por bimestre;
- consolidacao de avancos;
- pontos que ainda precisam de continuidade;
- orientacao para o proximo ano ou ciclo.

## Estrutura recomendada

### 1. Cabecalho

Conteudo:

- nome da crianca;
- turma ou serie, quando existir;
- periodo analisado;
- data da reuniao;
- escola ou nucleo;
- professor ou responsavel pelo acompanhamento, quando aplicavel.

Exemplo:

```text
Relatorio de Acompanhamento Pedagogico
Aluno: Pedro Antonio
Periodo: 1o semestre de 2026
```

### 2. Abertura acolhedora

Funcao:

- contextualizar o relatorio;
- reduzir ansiedade;
- deixar claro que a analise observa percurso, nao rotulo.

Exemplo:

```text
Este relatorio apresenta uma sintese das atividades realizadas por Pedro Antonio
no periodo, com sinais observados, evidencias representativas e proximos passos
para continuidade do acompanhamento.
```

### 3. Sintese do periodo

Funcao:

- dar uma leitura geral em linguagem simples;
- destacar 2 ou 3 pontos principais;
- orientar onde a conversa deve focar.

Nao deve:

- substituir a analise por area;
- dizer genericamente "a crianca evoluiu" sem evidencias;
- trazer diagnosticos.

Exemplo:

```text
Pedro Antonio manteve boa participacao nas atividades do periodo. Em Tabuada,
os registros mostram melhora de fluencia. Em Redacao, houve pratica frequente,
mas a organizacao do texto ainda precisa de apoio guiado e continuidade.
```

### 4. O que foi trabalhado

Funcao:

- mostrar volume e distribuicao de praticas;
- permitir que os pais entendam o percurso sem ler todas as evidencias.

Formato recomendado:

- tabela curta;
- lista por area;
- sem graficos excessivos.

Exemplo:

```text
Redacao: 18 evidencias no semestre, distribuidas em 10 de 20 semanas.
Tabuada: 22 evidencias no semestre, distribuidas em 16 de 20 semanas.
Interpretacao: 7 evidencias no semestre, distribuidas em 5 de 20 semanas.
Ingles: 6 evidencias no semestre, distribuidas em 4 de 20 semanas.
```

### 5. Acompanhamento por area

Cada area deve apresentar:

- meta trabalhada no periodo, quando existir;
- leitura cuidadosa da meta;
- tendencia no periodo;
- volume de evidencias;
- distribuicao no tempo;
- nivel de confianca;
- leitura cuidadosa;
- proximo passo.

#### Redacao

Pergunta:

```text
Como a escrita esta evoluindo ao longo do tempo, considerando pratica, estrutura e continuidade?
```

Conteudo esperado:

- quantidade de redacoes;
- distribuicao no periodo;
- sinais de estrutura;
- exemplos representativos;
- orientacao para continuidade.

Exemplo:

```text
Pedro Antonio praticou Redacao com regularidade. A estrutura de comeco, meio e
fim aparece em formacao, mas ainda precisa de pratica guiada para ganhar mais
consistencia. O proximo ciclo deve manter textos curtos e trabalhar uma etapa
por vez.
```

Quando houver meta relacionada, o relatorio deve explicitar a conexao:

```text
Meta trabalhada: organizar redacoes com comeco, meio e fim.
Leitura da meta: ainda em construcao. Houve pratica suficiente no periodo, mas
os registros mostram que a estrutura ainda oscila. A recomendacao e manter a
meta no proximo ciclo com tarefas menores e mais guiadas.
```

#### Tabuada

Pergunta:

```text
Como a fluencia esta evoluindo ao longo do tempo, considerando acertos, tempo e repeticao?
```

Exemplo:

```text
Em Tabuada, houve pratica distribuida e sinais de melhora em acertos e tempo de
resposta. A recomendacao e manter treinos curtos, aumentando variedade apenas
quando a atividade terminar com leveza.
```

#### Interpretacao

Pergunta:

```text
Como a compreensao de texto esta evoluindo ao longo do tempo, considerando acertos, complexidade e frequencia?
```

Exemplo:

```text
Em Interpretacao, Pedro apresentou bons sinais nas atividades realizadas. Como
houve menos evidencias no periodo, ainda vale manter observacao antes de afirmar
uma tendencia mais forte.
```

#### Ingles

Pergunta:

```text
Como a habilidade trabalhada esta evoluindo ao longo do tempo, considerando acertos, apoio e repeticao?
```

Exemplo:

```text
Em Ingles, os registros ainda estao em formacao. A recomendacao e manter a
mesma habilidade por mais algumas missoes curtas antes de trocar de conteudo.
```

### 6. Evidencias representativas

Funcao:

- sustentar a conversa;
- mostrar exemplos concretos;
- evitar que o relatorio vire uma lista de tudo.

Regras:

- selecionar poucas evidencias;
- explicar por que foram escolhidas;
- preferir evidencias de momentos diferentes do periodo;
- permitir abrir as evidencias completas no portal;
- evitar expor textos longos sem necessidade.

Para Redacao:

- uma evidencia inicial;
- uma evidencia intermediaria;
- uma evidencia recente.

Para Tabuada:

- uma evidencia inicial de fluencia;
- uma evidencia recente;
- principais fatos ou tabuadas trabalhadas.

Para Interpretacao:

- texto ou resumo do texto;
- tipo de pergunta;
- resposta ou padrao observado.

Para Ingles:

- habilidade treinada;
- tipo de exercicio;
- erro recorrente ou sinal de consolidacao.

### 7. Como a familia pode ajudar

Essa secao e obrigatoria.

Funcao:

- transformar analise em acao possivel;
- ajudar os pais a apoiarem sem pressionar;
- oferecer linguagem concreta para conversa em casa.

Formato:

- 2 ou 3 orientacoes simples;
- frases sugeridas;
- evitar tarefas longas para casa sem contexto.

Exemplo:

```text
Em casa, ajuda mais dividir a escrita em pequenas partes. Antes de pedir uma
redacao inteira, converse sobre tres perguntas: onde a historia comeca, o que
acontece no meio e como ela termina.
```

Frase sugerida:

```text
Vamos melhorar so uma parte hoje. Primeiro, vamos deixar claro onde a historia comeca.
```

### 8. Proximos passos da escola

Funcao:

- dizer o que a escola ou nucleo vai fazer no proximo ciclo;
- alinhar expectativa com a familia;
- mostrar continuidade.

Exemplo:

```text
No proximo periodo, o nucleo mantera missoes curtas de Redacao, com foco em
comeco, meio e fim. A Tabuada seguira com treinos breves para consolidar
fluencia, sem aumentar a carga de uma vez.
```

### 9. Fechamento positivo

Funcao:

- terminar com esperanca realista;
- valorizar continuidade;
- preservar confianca.

Exemplo:

```text
Pedro Antonio se beneficia de orientacoes por etapas e atividades curtas. A
continuidade do acompanhamento tende a apoiar sua seguranca e autonomia ao
longo dos proximos ciclos.
```

## Papel da IA

### A IA pode

- resumir evidencias;
- organizar a trajetoria;
- selecionar evidencias representativas;
- escrever primeira versao do relatorio;
- adaptar linguagem para pais;
- sugerir orientacoes praticas para casa;
- indicar quando ainda ha poucos dados;
- apontar quais evidencias sustentam cada conclusao.

### A IA nao pode

- diagnosticar;
- rotular;
- comparar com outras criancas;
- afirmar certeza sem base;
- esconder baixa confianca;
- substituir revisao da escola;
- gerar relatorio final sem possibilidade de revisao humana.

## Fluxo de geracao

1. Adulto seleciona crianca.
2. Adulto escolhe periodo.
3. Portal monta Acompanhamento por area.
4. Portal cruza metas, missoes e evidencias no periodo.
5. Adulto clica em `Gerar relatorio para reuniao`.
6. IA gera rascunho com base em evidencias rastreaveis.
7. Escola revisa e edita o texto.
8. Portal marca o relatorio como revisado.
9. Escola exporta ou compartilha com pais.

## Revisao humana obrigatoria

O relatorio para pais deve ser revisavel antes de qualquer compartilhamento.

Estados sugeridos:

- rascunho;
- em revisao;
- revisado;
- compartilhado;
- arquivado.

O produto deve deixar claro:

```text
Este relatorio deve ser revisado pela escola antes de ser apresentado a familia.
```

## Privacidade e acesso

O relatorio pode conter dados sensiveis da trajetoria pedagogica.

Regras:

- a crianca nao acessa pelo Bloco Infantil;
- outros pais nao acessam;
- professor so acessa alunos sob sua responsabilidade;
- admin do negocio nao acessa relatorios individuais;
- compartilhamento externo deve ser registrado;
- escola deve poder gerar PDF ou copia revisada quando autorizado.

## Linguagem

### Preferir

- sinais observados;
- evidencias do periodo;
- precisa de continuidade;
- esta em formacao;
- se beneficia de;
- proximo passo;
- pratica guiada;
- atividades curtas;
- em relacao ao proprio percurso.

### Evitar

- nao evoluiu;
- fracassou;
- deficiencia;
- problema grave;
- atraso;
- incapacidade;
- baixo desempenho como rotulo;
- comparacao com outros alunos.

## Exemplo de trecho para pais

```text
Pedro Antonio participou das atividades do nucleo ao longo do semestre. Em
Tabuada, os registros mostram pratica distribuida e sinais de melhora em
fluencia. Em Redacao, houve participacao regular, mas a organizacao do texto
ainda precisa de apoio guiado. Para o proximo ciclo, a escola mantera atividades
curtas, com foco em comeco, meio e fim.

Em casa, a melhor ajuda e conversar por partes, sem exigir uma redacao inteira
de uma vez. Uma frase simples pode ajudar: "Vamos pensar primeiro onde a
historia comeca?"
```

## Criterios de aceite

O relatorio para reuniao com pais sera considerado aceitavel quando:

- permitir escolher periodo;
- nascer do Acompanhamento por area;
- relacionar metas trabalhadas com evidencias do periodo;
- mostrar evidencias usadas;
- separar leitura por area;
- indicar volume e distribuicao das evidencias;
- ter linguagem segura para pais;
- incluir orientacao pratica para casa;
- incluir proximos passos da escola;
- permitir revisao humana antes de compartilhamento;
- evitar diagnostico, rotulo e comparacao;
- poder ser exportado ou apresentado em formato adequado para reuniao.

## Questoes abertas

- O relatorio deve ter versao PDF no MVP?
- A escola precisa assinar ou aprovar formalmente o relatorio?
- O relatorio deve ser salvo como snapshot historico?
- Quem pode editar o relatorio depois de revisado?
- Como registrar que o relatorio foi apresentado aos pais?
- O responsavel deve conseguir comentar ou confirmar recebimento?
- Quais evidencias devem aparecer completas e quais devem aparecer resumidas?

## Proximos passos

1. Validar este PRD com o mockup do Acompanhamento por area.
2. Criar mockup visual do relatorio para pais.
3. Auditar dados necessarios por modulo.
4. Definir o contrato de `report_snapshot`.
5. Definir fluxo de revisao humana.
6. Implementar geracao de rascunho com IA.
7. Implementar exportacao ou visualizacao para reuniao.
