# PRD: Modulo de Ingles

## Contexto

O Portal Educacional foi desenhado para apoiar o desenvolvimento da crianca ao longo do tempo, com missoes curtas, feedback positivo e orientacao pratica para o adulto.

O modulo de Ingles deve seguir a mesma filosofia dos modulos de Redacao, Interpretacao e Tabuada:

- o adulto define a intencao pedagogica;
- a crianca recebe uma missao simples e possivel;
- o modulo registra evidencias;
- o portal mostra evolucao longitudinal;
- o feedback ao adulto ajuda a orientar o proximo passo sem culpa, rotulo ou alarme.

Este PRD documenta o desenho inicial do modulo. Ele nao autoriza implementacao imediata. A intencao e preparar a arquitetura e evitar decisoes apressadas quando o modulo for priorizado.

## Ponderacao de produto

O adulto pode usar linguagem tecnica de Ingles, como `verb to be`, `simple present`, `present continuous` e `question words`.

A crianca nao deve receber a missao com peso tecnico desnecessario. Para ela, a linguagem deve ser concreta:

```text
Vamos treinar frases sobre coisas que estao acontecendo agora.
```

em vez de:

```text
Hoje voce vai estudar present continuous.
```

Essa separacao protege a experiencia infantil e mantem o adulto no controle pedagogico.

## Objetivo

Criar um modulo de reforco inicial de Ingles para:

- treinar estruturas basicas;
- organizar vocabulario por blocos pequenos;
- transformar listas de palavras do adulto em pratica guiada;
- registrar acertos, duvidas e palavras trabalhadas;
- orientar o adulto sobre revisao curta e frequente.

O modulo nao deve nascer como curso completo de Ingles. Ele deve nascer como reforco orientado por necessidade.

## Recorte do MVP

O MVP do modulo de Ingles deve ser pequeno, testavel e conectado ao mesmo modelo de missoes do portal.

Ele deve responder a uma pergunta simples:

```text
Como transformar uma dificuldade concreta percebida pelo adulto em uma pratica curta de Ingles, com evidencias para acompanhar se a crianca esta ganhando seguranca?
```

O MVP nao deve tentar:

- cobrir todo o curriculo escolar de Ingles;
- substituir aula regular;
- avaliar conversacao;
- medir pronuncia;
- criar trilha completa de nivelamento;
- entregar muitas palavras ou regras de uma vez.

O primeiro valor do modulo deve ser ajudar o adulto a escolher uma pratica pequena e ajudar a crianca a concluir essa pratica com clareza.

## Herancas dos modulos atuais

O modulo de Ingles deve herdar o conhecimento pratico acumulado nos modulos de Redacao, Interpretacao e Tabuada.

Essas decisoes nao sao apenas esteticas. Elas nasceram de testes reais com criancas e devem orientar o desenho do modulo.

### Estrutura visual

O modulo deve usar uma estrutura familiar:

- cabecalho simples com nome da missao;
- indicador de etapa ou progresso;
- blocos de atividade com bordas claras;
- uma instrucao principal por vez;
- botao principal bem visivel;
- botao de saida/retorno menos destacado;
- mensagem clara quando a missao terminar;
- retorno ao portal infantil com status de missao concluida.

O layout deve evitar:

- muitos blocos abertos ao mesmo tempo;
- titulos repetidos competindo entre si;
- instrucoes longas dentro do bloco infantil;
- botoes importantes com aparencia apagada;
- acoes ambiguas como "retornar a missao" quando a crianca pode entender que a missao e o proprio modulo.

### Ensinamentos dos testes com criancas

Os testes reais mostraram regras importantes:

- a crianca precisa saber qual botao apertar agora;
- o botao pressionado deve reagir visualmente;
- a crianca precisa entender quando a atividade terminou;
- a missao concluida nao pode parecer pendente;
- a linguagem deve ser concreta e curta;
- a mesma palavra ou titulo repetido em varios lugares atrapalha;
- no celular, a experiencia deve aceitar digitacao e recursos nativos do teclado;
- se a crianca errar ou precisar completar, a orientacao deve explicar o proximo passo sem parecer bronca;
- o adulto deve receber evidencias, mas a crianca deve receber apenas o necessario para continuar animada.

### Padrao de blocos no Ingles

O modulo de Ingles deve trabalhar com blocos de exercicio.

Regra:

- uma missao pode ter mais de um bloco;
- cada bloco deve ter um unico formato de exercicio;
- dentro do bloco, o formato se repete para criar ritmo;
- as frases variam para evitar memorizacao mecanica;
- ao final de cada bloco, a crianca recebe uma devolutiva curta;
- ao final da missao, o portal recebe evidencias por bloco.

Exemplo:

```text
Missao: Present continuous
Bloco 1: completar lacuna - 10 exercicios
Bloco 2: escolher frase correta - 10 exercicios
```

Isso preserva previsibilidade para a crianca e melhora a leitura longitudinal para o adulto.

### Repeticao com variacao controlada

Quando o adulto pedir para repetir a mesma habilidade em mais de uma missao, o modulo deve repetir o padrao pedagogico, mas variar os itens.

O que repete:

- habilidade;
- tipo de raciocinio;
- formato do bloco;
- quantidade aproximada;
- linguagem de apoio.

O que varia:

- sujeito;
- verbo;
- contexto;
- alternativas;
- ordem dos itens;
- frases usadas recentemente.

Exemplo:

```text
Missao 1: She is ___ a book. (read / reads / reading)
Missao 2: They are ___ soccer. (play / plays / playing)
Missao 3: I am ___ my homework. (do / does / doing)
```

O objetivo e treinar `verb + ing` varias vezes sem fazer a crianca decorar a mesma tela.

### Geracao controlada por templates

No MVP, os exercicios devem ser gerados por templates controlados, nao por IA livre.

Exemplo de configuracao salva:

```json
{
  "module_id": "ingles",
  "skill": "present_continuous",
  "blocks": [
    {
      "exercise_type": "fill_ing",
      "target_items": 10
    },
    {
      "exercise_type": "choose_now_sentence",
      "target_items": 10
    }
  ],
  "variation_mode": "controlled",
  "avoid_recent_repetition": true
}
```

O modulo infantil usa essa configuracao para montar exercicios no momento da atividade, variando frases e registrando os templates usados.

## Papel da IA

No MVP, a IA nao deve ser obrigatoria para criar a missao nem para gerar livremente os exercicios.

MVP:

- adulto escolhe habilidade;
- adulto escolhe um ou mais blocos;
- adulto define quantidade ou usa uma sugestao padrao;
- modulo gera exercicios por templates controlados;
- portal registra evidencias.

Fase posterior:

- IA pode sugerir configuracao de missao a partir da percepcao do adulto;
- IA pode explicar por que uma dose e melhor do que outra;
- IA pode propor novos templates para revisao humana;
- IA pode ajudar na leitura longitudinal, com cuidado para nao diagnosticar.

Essa decisao reduz custo, aumenta previsibilidade e evita que a crianca receba exercicios inconsistentes.

## Modelo de entrada do adulto

O modulo de Ingles deve nascer da percepcao do adulto, nao de uma trilha fixa de curso.

Exemplo realista:

```text
O adulto percebe que a crianca esta errando frases no present continuous.
Ele registra essa percepcao no portal.
O adulto escolhe uma missao curta de present continuous.
A crianca pratica algumas frases.
O portal registra evidencias.
Depois de algumas missoes, o adulto consegue observar se houve melhoria com apoio da leitura longitudinal.
```

Esse modelo evita que o produto vire um curso generico de Ingles. O foco e reforco direcionado por necessidade.

### O que o adulto pode informar

O adulto deve poder entrar por dois caminhos:

1. Escolher uma habilidade tecnica conhecida.
2. Escrever uma percepcao em linguagem natural.

Exemplos de habilidade tecnica:

- `present continuous`;
- `simple present`;
- `verb to be`;
- `question words`;
- lista de vocabulario.

Exemplos de percepcao em linguagem natural:

```text
Ele confunde quando usar is e are.
```

```text
Ele nao percebe quando a frase fala de algo acontecendo agora.
```

```text
Ele tem uma lista de palavras da escola, mas ainda nao reconhece bem o significado.
```

Regra de produto:

O adulto continua responsavel por escolher e liberar novas missoes. No MVP, a organizacao deve ser feita por opcoes guiadas e templates. A IA pode apoiar em fase posterior, mas nao deve ser dependencia inicial.

O fluxo deve seguir a logica que ja existe no Portal Educacional:

1. o adulto escolhe o que quer melhorar;
2. o adulto transforma isso em uma missao para a crianca;
3. o sistema usa blocos e templates para manter a missao curta e consistente;
4. a crianca pratica;
5. o portal registra evidencias;
6. o adulto decide o proximo assunto com apoio da leitura longitudinal.

Isso vale para Ingles do mesmo modo que ja vale para leitura, redacao e tabuada. O modulo nao deve assumir que existe uma sequencia fixa para todas as criancas.

## Hipoteses pedagogicas iniciais

Estas hipoteses orientam o desenho, mas devem ser validadas com uso real e, depois, com especialista:

- uma crianca pode entender melhor Ingles quando a regra tecnica vira uma acao concreta;
- missoes curtas reduzem resistencia e aumentam chance de repeticao;
- escutar a palavra ajuda vocabulario, mas avaliacao de fala cedo demais pode aumentar ansiedade;
- listas grandes de palavras precisam ser quebradas em blocos pequenos;
- tempo de conclusao ajuda o adulto a calibrar dose, mas nao deve aparecer como pressao para a crianca;
- a autoavaliacao opcional da crianca pode indicar se a missao estava facil, dificil ou na medida.

Exemplo:

```text
Adulto: Miguel esta confundindo quando usar present continuous.
Crianca: Vamos treinar frases sobre coisas que estao acontecendo agora.
```

## Publico

### Adulto

Pais, responsaveis e professores que desejam indicar uma pratica de Ingles curta e acompanhavel.

O adulto pode informar:

- conteudo gramatical;
- lista de palavras;
- tema;
- nivel aproximado;
- observacao sobre dificuldade percebida;
- quantidade de exercicios desejada.

### Crianca

Criancas em idade escolar que precisam praticar Ingles com leveza, previsibilidade e senso de conclusao.

A crianca deve ver:

- uma missao por vez;
- textos curtos;
- instrucoes simples;
- feedback positivo;
- fim claro da atividade.

## Escopo MVP

O MVP deve comecar com um pacote pequeno de missoes. A prioridade inicial sera:

- `verb_to_be`;
- `simple_present`;
- `present_continuous`;
- `question_words` / perguntas em ingles;
- `vocabulary_list`;
- `guided_short_writing`.

O MVP deve conter seis tipos de missao.

### 1. Verb to be

Habilidade adulta:

- `verb_to_be`

Conteudos:

- `am`;
- `is`;
- `are`;
- afirmativa;
- negativa;
- interrogativa.

Exemplos de atividade:

- escolher entre `am`, `is`, `are`;
- completar frase curta;
- transformar frase afirmativa em pergunta;
- corrigir uma frase simples.

Linguagem para a crianca:

```text
Vamos completar frases curtas com am, is ou are.
```

### 2. Simple present

Habilidade adulta:

- `simple_present`

Conteudos:

- rotina;
- habitos;
- terceira pessoa;
- uso do `s` em `he/she/it`;
- frases afirmativas e negativas simples.

Exemplos:

- `I play`;
- `She plays`;
- `He likes`;
- `They study`.

Linguagem para a crianca:

```text
Vamos treinar frases sobre coisas que acontecem sempre ou muitas vezes.
```

### 3. Present continuous

Habilidade adulta:

- `present_continuous`

Conteudos:

- acoes acontecendo agora;
- `am/is/are + verb-ing`;
- frases afirmativas;
- perguntas simples;
- diferenca inicial entre rotina e acao acontecendo agora.

Exemplos:

- `I am reading`;
- `She is playing`;
- `They are eating`.

Linguagem para a crianca:

```text
Vamos treinar frases sobre coisas que estao acontecendo agora.
```

### 4. Question words

Habilidade adulta:

- `question_words`

Observacao:

O adulto pode conhecer como `interrogative pronouns`, mas no produto devemos preferir `question words`, por ser mais comum em Ingles escolar inicial.

Conteudos:

- `what`;
- `where`;
- `when`;
- `who`;
- `why`;
- `how`.

Exemplos de atividade:

- escolher a palavra de pergunta correta;
- ligar pergunta e resposta;
- completar perguntas curtas;
- diferenciar lugar, pessoa, tempo, motivo e modo.

Linguagem para a crianca:

```text
Vamos escolher a melhor palavra para fazer a pergunta.
```

### 5. Lista de palavras do adulto

Habilidade adulta:

- `vocabulary_list`

O adulto cola uma lista de palavras ou expressoes.

Exemplo:

```text
school, pencil, teacher, homework, friend
```

O modulo deve:

1. limpar duplicidades;
2. identificar palavras muito dificeis para o nivel;
3. separar em blocos pequenos;
4. sugerir um primeiro bloco de pratica por regra padrao;
5. criar exercicios variados;
6. oferecer botao de ouvir para cada palavra trabalhada;
7. registrar quais palavras foram praticadas.

Requisito de audio no vocabulario:

- cada palavra do bloco de treino deve ter um botao simples de ouvir;
- o objetivo e ajudar a crianca a associar palavra escrita, significado e som;
- a crianca pode ouvir a palavra quantas vezes precisar;
- o MVP nao deve gravar voz, avaliar fala ou dar nota de pronuncia.

Regra pedagogica:

Se o adulto colar muitas palavras, o modulo nao deve entregar tudo para a crianca de uma vez.

Exemplo de resposta adulta:

```text
Voce trouxe 42 palavras. Para hoje, sugiro comecar com 8. Depois usamos as demais em revisoes curtas.
```

Linguagem para a crianca:

```text
Vamos treinar algumas palavras de hoje, uma parte pequena por vez.
```

### 6. Pequena escrita guiada

Habilidade adulta:

- `guided_short_writing`

Objetivo:

Ajudar a crianca a produzir uma frase ou pequeno paragrafo em Ingles com apoio de etapas, sem transformar a atividade em redacao longa.

Conteudos iniciais:

- frase sobre rotina;
- frase sobre algo acontecendo agora;
- mini apresentacao pessoal;
- descricao simples de pessoa, lugar ou objeto;
- uso de vocabulario praticado anteriormente.

Exemplos de atividade:

- montar uma frase a partir de palavras dadas;
- completar uma frase sobre si mesmo;
- escrever 2 ou 3 frases guiadas;
- revisar uma frase com uma dica do sistema;
- usar palavras treinadas em uma mini producao.

Linguagem para a crianca:

```text
Vamos escrever uma frase pequena em Ingles, uma parte de cada vez.
```

Regra pedagogica:

A pequena escrita guiada deve nascer depois de alguma pratica de estrutura ou vocabulario. Ela nao deve pedir producao livre grande no inicio. A crianca precisa sentir que consegue construir algo pequeno.

Regra de evidencia:

O portal deve registrar a frase final, a habilidade relacionada e se houve apoio de revisao. A leitura longitudinal deve observar se a crianca passa a usar mais palavras e estruturas com menos ajuda ao longo do tempo.

## Matriz inicial de exercicios por assunto

Esta matriz nao fecha o desenho final. Ela registra os primeiros tipos de exercicio que parecem coerentes com cada assunto, para evitar que o modulo fique generico demais.

Regra de produto:

Cada missao pode ter um ou mais blocos. Cada bloco deve ter apenas um formato de exercicio.

Exemplo:

```text
Missao: Present continuous
Bloco 1: completar lacuna - 10 exercicios
Bloco 2: escolher a frase correta - 10 exercicios
```

Dentro de cada bloco, o modulo varia frases, sujeitos, verbos e alternativas, mas mantem a mesma logica de resposta. Isso cria ritmo para a crianca e permite que o adulto compare desempenho por formato.

### Verb to be

Objetivo da missao:

- reconhecer quando usar `am`, `is` e `are`;
- praticar afirmativa, negativa e pergunta simples.

Exercicios iniciais:

1. Completar lacuna:

```text
She ___ happy.

( ) am
( ) is
( ) are
```

2. Escolher a frase correta:

```text
Qual frase esta melhor?

( ) He are my friend.
( ) He is my friend.
( ) He am my friend.
```

3. Transformar em pergunta com alternativas:

```text
Frase: You are ready.
Pergunta:

( ) Are you ready?
( ) You are ready?
( ) Is you ready?
```

Evidencias:

- erros entre `is` e `are`;
- erros entre `am` e `is`;
- dificuldade maior em pergunta ou negativa.

### Simple present

Objetivo da missao:

- reconhecer frases sobre rotina ou habito;
- praticar o `s` em `he`, `she` e `it`;
- diferenciar sujeito singular e plural em frases simples.

Exercicios iniciais:

1. Completar verbo:

```text
She ___ soccer every day.

( ) play
( ) plays
( ) playing
```

2. Escolher frase de rotina:

```text
Qual frase fala de algo que acontece sempre?

( ) I am eating now.
( ) I eat breakfast every day.
( ) I ate breakfast yesterday.
```

3. Corrigir uma frase curta:

```text
He play tennis.

Qual fica melhor?

( ) He plays tennis.
( ) He playing tennis.
( ) He are play tennis.
```

Evidencias:

- esquecimento do `s` na terceira pessoa;
- confusao entre rotina e acao acontecendo agora;
- acertos por sujeito.

### Present continuous

Objetivo da missao:

- reconhecer acoes acontecendo agora;
- praticar `am/is/are + verb-ing`;
- comparar, de forma inicial, acao atual e rotina.

Exercicios iniciais:

1. Completar a frase:

```text
They ___ playing now.

( ) am
( ) is
( ) are
```

2. Escolher a melhor forma com `-ing`:

```text
She is ___ a book.

( ) read
( ) reads
( ) reading
```

3. Escolher a frase que fala de agora:

```text
Qual frase fala de algo acontecendo agora?

( ) He plays every day.
( ) He is playing now.
( ) He played yesterday.
```

4. Montar frase guiada:

```text
Palavras: is / Maria / studying / now

Resposta esperada: Maria is studying now.
```

Evidencias:

- confusao entre `is` e `are`;
- ausencia de `-ing`;
- confusao entre `simple_present` e `present_continuous`;
- necessidade de apoio para ordenar frase.

### Question words / perguntas em ingles

Objetivo da missao:

- escolher a palavra de pergunta adequada;
- relacionar pergunta com tipo de resposta;
- praticar perguntas curtas.

Exercicios iniciais:

1. Completar pergunta com alternativa:

```text
___ is your name?

( ) What
( ) Where
( ) When
```

2. Escolher pergunta para uma resposta:

```text
Resposta: I live in Brazil.

Qual pergunta combina?

( ) Where do you live?
( ) When do you live?
( ) Who do you live?
```

3. Ligar palavra ao tipo de resposta:

```text
Where -> lugar
Who -> pessoa
When -> tempo
```

4. Completar parte da frase:

```text
___ are you sad?
Because I lost my pencil.

( ) Why
( ) Where
( ) Who
```

Evidencias:

- troca entre `where` e `when`;
- dificuldade com `why`;
- dificuldade em associar pergunta e resposta;
- habilidade de identificar pessoa, lugar, tempo, motivo e modo.

### Lista de vocabulario

Objetivo da missao:

- reconhecer significado;
- associar palavra escrita e som;
- praticar um bloco pequeno de palavras.

Exercicios iniciais:

1. Ouvir e escolher a palavra:

```text
[Ouvir]

( ) school
( ) pencil
( ) teacher
```

2. Escolher significado:

```text
teacher

( ) professor
( ) caderno
( ) recreio
```

3. Completar frase simples com palavra do bloco:

```text
My ___ is very kind.

( ) teacher
( ) pencil
( ) book
```

4. Revisao espaçada:

```text
Palavra vista ontem: homework
O que significa?
```

Evidencias:

- palavras reconhecidas;
- palavras que exigiram mais repeticao de audio;
- palavras confundidas;
- palavras reutilizadas em frase.

### Pequena escrita guiada

Objetivo da missao:

- usar uma estrutura ou vocabulario em uma pequena producao;
- preservar autoria da crianca;
- orientar revisao curta, sem transformar em redacao longa.

Exercicios iniciais:

1. Completar frase pessoal:

```text
I like ___.
```

2. Montar frase com palavras dadas:

```text
Palavras: I / am / studying / English
```

3. Escrever duas frases com apoio:

```text
Escreva uma frase dizendo o que voce faz todos os dias.
Depois escreva uma frase dizendo o que voce esta fazendo agora.
```

4. Revisao guiada de uma coisa:

```text
Sua frase ja tem uma boa ideia. Agora vamos melhorar apenas o verbo.
```

Evidencias:

- estrutura usada;
- quantidade de apoio necessario;
- vocabulario reutilizado;
- melhora depois da revisao;
- diferenca entre primeira tentativa e versao final, quando fizer sentido registrar.

## Configuracao da missao pelo adulto

O adulto deve poder escolher:

- tipo de missao;
- conteudo principal;
- lista de palavras, quando aplicavel;
- quantidade de itens;
- nivel de apoio da missao;
- tema opcional;
- observacao adulta opcional;
- blocos de exercicio da missao.

Campos propostos:

```json
{
  "module_id": "ingles",
  "skill": "present_continuous",
  "support_level": "high",
  "target_items": 10,
  "topic": "rotina escolar",
  "vocabulary": ["read", "play", "eat", "study"],
  "adult_note": "Ele confunde is e are.",
  "blocks": [
    {
      "exercise_type": "fill_ing",
      "target_items": 10
    }
  ],
  "variation_mode": "controlled",
  "avoid_recent_repetition": true
}
```

### Nivel de apoio

O produto deve evitar rotular a crianca como fraca ou forte em Ingles. A escolha feita pelo adulto deve ser tratada como `nivel de apoio` da missao, nao como capacidade fixa da crianca.

Niveis iniciais:

- `high`: instrucoes em portugues, frases em Ingles e feedback em portugues;
- `medium`: comandos mais curtos, ainda com feedback em portugues;
- `low`: mais comandos em Ingles, mantendo dica em portugues quando houver erro.

Exemplo de feedback no erro:

```text
Quase. They combina com are: They are.
```

Esse feedback deve ser curto, positivo e util no momento do erro. O sistema tambem deve registrar o padrao do erro para acompanhamento longitudinal, por exemplo `verb_to_be.choose.they_are.am_vs_are`.

### Fluxo adulto recomendado

1. Adulto escolhe a crianca.
2. Adulto escolhe o modulo `Ingles`.
3. Adulto informa a necessidade:
   - habilidade tecnica;
   - tema ou lista de palavras;
   - observacao opcional;
   - quantidade desejada;
   - um ou mais blocos de exercicio.
4. O sistema mostra uma proposta curta:
   - o que sera treinado;
   - quantos itens;
   - quais blocos fazem parte da missao;
   - o que observar depois.
5. Adulto confirma e libera a missao para a crianca.

Regra importante:

Se a observacao do adulto for ampla, vaga ou ansiosa, o MVP deve permitir que o adulto escolha uma missao pequena e observavel, sem tentar transformar a observacao em conclusao ampla.

Exemplo:

```text
Para hoje, escolha uma missao curta. Depois de duas ou tres praticas, o portal tera mais evidencias para apoiar a proxima escolha.
```

## Experiencia da crianca

A crianca deve receber:

- titulo simples;
- instrucao curta;
- uma questao por vez;
- botao simples para ouvir a pronuncia de palavras e frases curtas;
- reforco positivo imediato;
- possibilidade de tentar novamente;
- conclusao clara.

Exemplo:

```text
Missao de Ingles

Vamos treinar frases sobre coisas que estao acontecendo agora.
Faca uma parte pequena. Quando terminar, o adulto acompanha seu progresso.
```

### Fluxo infantil recomendado

1. A crianca entra pela missao liberada.
2. Ve uma explicacao curta, sem excesso tecnico.
3. Resolve um item por vez.
4. Recebe feedback imediato simples.
5. Pode ouvir palavras ou frases curtas quando fizer sentido.
6. Ao final, recebe uma mensagem clara de conclusao.
7. Opcionalmente responde como se sentiu na missao, com botoes simples.
8. Retorna ao portal infantil com a missao marcada como concluida.

Exemplos de autoavaliacao infantil:

- Foi tranquilo.
- Precisei pensar.
- Quero treinar mais.
- Foi dificil, mas consegui.

Essa resposta nao deve virar nota. Ela e um sinal para o adulto calibrar a proxima dose.

## Tipos de exercicio

O MVP pode usar exercicios textuais com apoio simples de audio:

- multipla escolha;
- completar lacuna;
- ordenar palavras;
- ligar pergunta e resposta;
- escolher traducao simples;
- revisar palavra ja praticada.
- ouvir a pronuncia de uma palavra ou frase curta antes de responder.

O audio do MVP deve ser apenas um apoio de escuta, acionado por um botao pequeno como "ouvir". A crianca pode ouvir a pronuncia, repetir se quiser e seguir a atividade.

Ficam fora do MVP gravacao de voz, avaliacao automatica de pronuncia e pontuacao de fala.

## Politica de audio

O audio no MVP deve ser de escuta, nao de avaliacao.

Permitido:

- botao `Ouvir` em palavras de vocabulario;
- botao `Ouvir` em frases curtas quando isso ajudar a atividade;
- repetir o audio quantas vezes a crianca quiser;
- usar audio como apoio antes de responder.

Nao permitido no MVP:

- gravar voz da crianca;
- avaliar pronuncia;
- dar nota de fala;
- comparar pronuncia com padrao nativo;
- pedir que a crianca fale obrigatoriamente.

Ponderacao:

Ouvir pode ajudar muito. Avaliar fala cedo demais pode mudar a atividade de pratica para exposicao. Isso deve ficar para uma fase posterior, depois de validacao pedagogica.

## Evidencias enviadas ao portal

O modulo deve enviar ao portal um `activity_event` com:

```json
{
  "service": "ingles",
  "activity_type": "grammar_practice",
  "title": "Treino de Ingles",
  "metrics": {
    "skill": "present_continuous",
    "target_items": 10,
    "completed_items": 10,
    "correct_items": 8,
    "accuracy_pct": 80,
    "vocabulary_count": 4,
    "retry_count": 2,
    "duration_seconds": 420,
    "completed": true,
    "child_self_assessment": "needed_thinking",
    "child_self_assessment_label": "Precisei pensar"
  },
  "feedback": {
    "child": {
      "tone": "positive",
      "message": "Voce terminou o treino de hoje. Algumas frases ja ficaram mais seguras.",
      "next_step": "Mostre para o adulto acompanhar."
    },
    "adult": {
      "summary": "A pratica mostrou boa resposta em frases com I am. Ainda vale revisar she is e they are.",
      "strengths": ["completou a missao", "acertou a maior parte das frases"],
      "attention_points": ["revisar diferenca entre is e are"],
      "recipe": ["Amanha, revise 5 frases curtas usando she is e they are."],
      "avoid_saying": ["Voce ja deveria saber isso.", "Ingles e dificil para voce."]
    }
  },
  "artifacts": {
    "skill": "present_continuous",
    "items": [],
    "vocabulary": ["read", "play", "eat", "study"],
    "common_errors": ["is_are_confusion"]
  }
}
```

## Sinais longitudinais especificos de Ingles

O portal deve conseguir acompanhar a evolucao por sinais pequenos e acumulaveis.

Sinais recomendados:

- habilidade treinada;
- palavras praticadas;
- palavras que precisaram de repeticao;
- estruturas com mais erro;
- quantidade de itens;
- acertos;
- tentativas;
- tempo invisivel de conclusao;
- autoavaliacao opcional da crianca;
- se a missao foi concluida sem abandono;
- se a mesma habilidade apareceu em missoes anteriores.

Exemplos de `common_errors`:

- `is_are_confusion`;
- `am_is_confusion`;
- `missing_third_person_s`;
- `present_simple_vs_continuous`;
- `question_word_choice`;
- `word_meaning_confusion`.

O feedback longitudinal nao deve concluir dificuldade ampla com uma unica missao. Deve combinar evidencias ao longo do tempo.

## Feedback ao adulto

O feedback adulto deve conter:

- o que foi praticado;
- onde a crianca mostrou seguranca;
- onde vale revisar;
- uma receita curta para casa;
- limite de conclusao quando houver poucos dados.

Exemplo:

```text
Hoje ele praticou frases com present continuous. Foi bem em I am e she is. Ainda oscilou em they are.

Receita: amanha faca 5 frases curtas com they are, sem cobrar velocidade. O foco e reconhecer o padrao.
```

## Feedback para a crianca

O feedback infantil deve:

- ser curto;
- reconhecer esforco;
- apontar um proximo passo pequeno;
- evitar termos de dificuldade permanente.

Exemplos bons:

```text
Boa! Voce terminou a missao de hoje.
```

```text
Essa parte ficou melhor depois da segunda tentativa.
```

```text
Vamos guardar uma dica: quando for mais de uma pessoa, geralmente usamos are.
```

Evitar:

```text
Voce errou muito o present continuous.
```

```text
Voce nao sabe usar is e are.
```

## IA futura

No MVP inicial de exercicios estruturados, a IA nao e obrigatoria para montar missoes nem gerar exercicios. O modulo deve funcionar com escolhas guiadas do adulto e templates controlados.

Em fase posterior, a IA pode apoiar o adulto quando houver percepcao aberta, lista grande de palavras ou duvida sobre dose. Nessa fase, ela deve:

- sugerir reducao quando a missao estiver longa;
- explicar ao adulto a escolha pedagogica;
- nao diagnosticar dificuldade;
- nao usar tom alarmista;
- respeitar a diferenca entre linguagem adulta e infantil;
- preferir exemplos curtos e concretos;
- adaptar a sugestao ao numero de evidencias existentes;
- indicar quando a lista de palavras esta longa demais;
- nunca apresentar a crianca como "fraca em Ingles".

Quando houver poucos dados, a IA futura pode dizer:

```text
Ainda temos poucas evidencias. Vale fazer mais duas ou tres missoes curtas antes de definir uma meta mais precisa.
```

### Excecao futura: pequena escrita guiada

Na pequena escrita guiada, a IA deve entrar como componente obrigatorio quando essa parte for implementada.

Motivo:

- a crianca pode produzir frases imprevisiveis;
- o sistema precisa entender a tentativa;
- a revisao deve escolher apenas um ponto pequeno de melhora;
- o feedback precisa preservar autoria e autoestima;
- templates fixos nao sao suficientes para orientar uma producao aberta.

Essa etapa fica fora do primeiro prototipo. Antes dela, o modulo deve validar os exercicios estruturados de `verb to be`, `simple present` e `present continuous`.

#### Niveis da escrita guiada

A escrita guiada em Ingles nao deve ter um unico fluxo para todas as criancas.

O modulo deve escolher ou permitir que o adulto escolha um nivel de andaime:

1. **Frase unica**

   Para criancas em nivel inicial ou com pouco repertorio.

   Exemplo:

   ```text
   Complete uma frase pequena em Ingles.

   I like ______.
   ```

2. **Tres frases guiadas**

   Para criancas que ja conseguem juntar ideias simples.

   Exemplo:

   ```text
   Frase 1: diga quem aparece.
   Frase 2: diga o que esta acontecendo.
   Frase 3: diga algo que voce gosta ou percebe.
   ```

3. **Fluxo avancado inspirado na Redacao**

   Para criancas com mais repertorio em Ingles.

   Esse modo pode reaproveitar principios do modulo de Redacao:

   - uma etapa por vez;
   - orientacao no momento certo;
   - validacao antes de continuar;
   - revisao de apenas um ponto;
   - feedback positivo;
   - registro da versao final no portal.

Regra pedagogica:

O modulo deve permitir que uma crianca comece com uma frase unica sem parecer que recebeu uma atividade "menor". A linguagem deve preservar progresso e possibilidade:

```text
Hoje vamos construir uma frase boa em Ingles. Uma frase bem feita ja e um passo importante.
```

### Traducao de pedido adulto em missao infantil

Mesmo sem IA obrigatoria no MVP, o produto deve manter um mapa claro entre pedido adulto e linguagem infantil.

| Pedido adulto | Missao infantil |
| --- | --- |
| `verb to be` | Completar frases com `am`, `is` e `are`. |
| `simple present` | Treinar frases sobre coisas que acontecem sempre. |
| `present continuous` | Treinar frases sobre coisas que estao acontecendo agora. |
| `question words` | Escolher a palavra certa para fazer uma pergunta. |
| lista de vocabulario | Treinar um bloco pequeno de palavras com significado e som. |

Se o adulto trouxer varias dificuldades ao mesmo tempo, o sistema deve sugerir comecar por uma habilidade principal.

Exemplo:

```text
Voce trouxe tres pontos. Para hoje, escolha uma habilidade principal. Uma missao curta de present continuous pode ser uma boa primeira observacao.
```

## Fora do MVP

Ficam fora da primeira versao:

- curso completo de Ingles;
- conversacao livre;
- IA livre gerando exercicios diretamente para a crianca;
- IA obrigatoria para criar missao;
- pequena escrita guiada com IA;
- avaliacao avancada de pronuncia;
- audio obrigatorio em todas as atividades;
- reconhecimento de fala;
- ranking;
- gamificacao complexa;
- certificado;
- classificacao formal de nivel.

## Integracao com modulos plugaveis

Catalogo futuro:

```json
{
  "id": "ingles",
  "name": "Ingles Inicial",
  "short_name": "Ingles",
  "area": "idiomas",
  "journey": "ingles_inicial",
  "description": "Vocabulario e frases simples com missoes curtas.",
  "url": "",
  "status": "planned",
  "accent": "english",
  "icon": "I",
  "skills": ["verb_to_be", "simple_present", "present_continuous", "question_words", "vocabulary_list", "guided_short_writing"],
  "commercial_key": "module_english"
}
```

Observacao:

O campo `area` hoje pode exigir ampliacao do schema, pois as areas atuais foram desenhadas para leitura, escrita, matematica, organizacao e outro. Antes da implementacao, decidir se Ingles sera:

- uma nova area ampla `idiomas`; ou
- uma jornada dentro de `outro`; ou
- uma area especifica `ingles`.

Recomendacao inicial: usar `area = "idiomas"` e `journey = "ingles_inicial"`.

Motivo:

- permite Ingles agora sem fechar a arquitetura contra Espanhol ou outro idioma no futuro;
- preserva `ingles` como modulo ou jornada, nao como categoria rigida;
- combina melhor com a ideia de modulos plugaveis comercializaveis por dominio.

## Criterios de aceite do PRD

O modulo de Ingles so deve ser implementado quando:

- o contrato de missoes por modulo estiver estavel;
- o portal adulto conseguir configurar missoes por modulo;
- o historico unificado conseguir exibir evidencias por habilidade;
- houver clareza sobre como armazenar `skill`, `vocabulary` e `common_errors`;
- a linguagem infantil e adulta estiver alinhada ao guia pedagogico;
- houver decisao sobre area/jornada `idiomas` e `ingles_inicial`.

## Roadmap sugerido

### Fase 0: PRD

Documento conceitual, sem implementacao.

### Fase 1: Catalogo planejado e contrato

Adicionar Ingles como modulo `planned`, sem botao infantil ativo.

Validar tambem:

- `area = idiomas`;
- `journey = ingles_inicial`;
- payload de `activity_event`;
- sinais longitudinais especificos;
- formato de configuracao adulta.
- local do modulo como `apps/ingles` no monorepo.

### Fase 2: Configuracao adulta

Permitir montar missao de Ingles com habilidade e lista de palavras em ambiente interno, ainda sem liberar para criancas reais.

Saida esperada:

- missao configurada por habilidade e blocos;
- dose definida pelo adulto ou padrao do sistema;
- texto infantil;
- criterios de conclusao;
- evidencias que seriam registradas.

### Fase 3: MVP do modulo

Implementar atividades com audio simples de escuta no vocabulario, sem avaliacao de fala:

- verb to be;
- simple present;
- present continuous;
- question words;
- vocabulary list;
- guided short writing.

### Fase 4: Memoria longitudinal

Relatorios por:

- habilidade;
- palavras treinadas;
- estruturas com mais erro;
- revisoes recomendadas.

### Fase 5: Fala e pronuncia avaliada

Somente depois de validar o MVP textual e o apoio de audio por escuta.

## Decisao

O modulo de Ingles sera planejado como reforco plugavel, orientado por missoes curtas e evidencias.

O adulto podera informar conteudos tecnicos e listas de palavras. A crianca recebera uma experiencia simples, positiva e adaptada.

A prioridade do modulo nao e ensinar Ingles inteiro, mas ajudar o adulto a transformar uma necessidade concreta em pratica pequena, acompanhavel e documentada.
