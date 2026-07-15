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

## Modelo de entrada do adulto

O modulo de Ingles deve nascer da percepcao do adulto, nao de uma trilha fixa de curso.

Exemplo realista:

```text
O adulto percebe que a crianca esta errando frases no present continuous.
Ele registra essa percepcao no portal.
A IA ajuda a transformar isso em uma missao curta.
A crianca pratica algumas frases.
O portal registra evidencias.
Depois de algumas missoes, o adulto e a IA conseguem observar se houve melhoria.
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

### Papel da IA nesse momento

A IA deve ajudar o adulto a transformar percepcao em missao.

Ela deve:

- identificar a habilidade provavel;
- propor uma missao pequena;
- sugerir quantidade de itens;
- explicar por que escolheu aquela dose;
- pedir confirmacao do adulto antes de liberar;
- registrar que aquilo e uma hipotese pedagogica, nao uma conclusao ampla.

Exemplo de devolutiva adulta:

```text
Pelo que voce descreveu, parece fazer sentido treinar present continuous com frases curtas sobre acoes acontecendo agora. Para hoje, eu sugiro 6 itens, sem misturar simple present ainda. Depois de duas ou tres missoes, conseguimos observar se esse ponto esta ficando mais seguro.
```

Regra de produto:

O adulto continua responsavel por escolher e liberar novas missoes. A IA apoia a organizacao pedagogica, mas nao deve criar uma sequencia longa automaticamente sem confirmacao.

O fluxo deve seguir a logica que ja existe no Portal Educacional:

1. o adulto escolhe o que quer melhorar;
2. o adulto transforma isso em uma missao para a crianca;
3. a IA ajuda a calibrar linguagem, dose e criterio de conclusao;
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

A IA deve:

1. limpar duplicidades;
2. identificar palavras muito dificeis para o nivel;
3. separar em blocos pequenos;
4. sugerir um primeiro bloco de pratica;
5. criar exercicios variados;
6. oferecer botao de ouvir para cada palavra trabalhada;
7. registrar quais palavras foram praticadas.

Requisito de audio no vocabulario:

- cada palavra do bloco de treino deve ter um botao simples de ouvir;
- o objetivo e ajudar a crianca a associar palavra escrita, significado e som;
- a crianca pode ouvir a palavra quantas vezes precisar;
- o MVP nao deve gravar voz, avaliar fala ou dar nota de pronuncia.

Regra pedagogica:

Se o adulto colar muitas palavras, a IA nao deve entregar tudo para a crianca de uma vez.

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
- revisar uma frase com uma dica da IA;
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

Cada missao deve escolher poucos formatos por vez. A crianca nao deve receber todos os tipos de exercicio em uma unica atividade.

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
- nivel aproximado;
- tema opcional;
- observacao adulta opcional;
- se a IA deve sugerir uma divisao da tarefa.

Campos propostos:

```json
{
  "module_id": "ingles",
  "skill": "present_continuous",
  "level": "iniciante",
  "target_items": 10,
  "topic": "rotina escolar",
  "vocabulary": ["read", "play", "eat", "study"],
  "adult_note": "Ele confunde is e are.",
  "ai_chunking": true
}
```

### Fluxo adulto recomendado

1. Adulto escolhe a crianca.
2. Adulto escolhe o modulo `Ingles`.
3. Adulto informa a necessidade:
   - habilidade tecnica;
   - tema ou lista de palavras;
   - observacao opcional;
   - quantidade desejada ou deixa a IA sugerir.
4. A IA devolve uma proposta curta:
   - o que sera treinado;
   - quantos itens;
   - por que essa dose e adequada;
   - o que observar depois.
5. Adulto confirma e libera a missao para a crianca.

Regra importante:

Se a observacao do adulto for ampla, vaga ou ansiosa, a IA pode sugerir observacao por mais algumas atividades antes de criar uma meta forte.

Exemplo:

```text
Ainda temos poucas evidencias. Para hoje, sugiro uma missao curta com 6 frases. Depois de duas ou tres praticas, teremos mais seguranca para definir uma meta.
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

## Regras da IA

A IA deve:

- quebrar conteudos grandes em blocos pequenos;
- sugerir reducao quando a missao estiver longa;
- adaptar exemplos ao nivel informado;
- explicar ao adulto a escolha pedagogica;
- nao diagnosticar dificuldade;
- nao usar tom alarmista;
- respeitar a diferenca entre linguagem adulta e infantil.
- preferir exemplos curtos e concretos;
- adaptar a missao ao numero de evidencias existentes;
- indicar quando a lista de palavras esta longa demais;
- explicar ao adulto por que reduziu a dose;
- nunca apresentar a crianca como "fraca em Ingles".

Quando houver poucos dados, a IA deve dizer:

```text
Ainda temos poucas evidencias. Vale fazer mais duas ou tres missoes curtas antes de definir uma meta mais precisa.
```

### Regras para transformar pedido adulto em missao

Quando o adulto pedir uma habilidade tecnica, a IA deve traduzir para uma missao infantil simples.

| Pedido adulto | Missao infantil |
| --- | --- |
| `verb to be` | Completar frases com `am`, `is` e `are`. |
| `simple present` | Treinar frases sobre coisas que acontecem sempre. |
| `present continuous` | Treinar frases sobre coisas que estao acontecendo agora. |
| `question words` | Escolher a palavra certa para fazer uma pergunta. |
| lista de vocabulario | Treinar um bloco pequeno de palavras com significado e som. |

Se o adulto trouxer varias dificuldades ao mesmo tempo, a IA deve sugerir comecar por uma.

Exemplo:

```text
Voce trouxe tres pontos. Para hoje, eu comecaria por present continuous, porque e uma pratica pequena e observavel. Depois usamos o resultado para decidir o proximo passo.
```

## Fora do MVP

Ficam fora da primeira versao:

- curso completo de Ingles;
- conversacao livre;
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

### Fase 2: Configuracao adulta

Permitir montar missao de Ingles com habilidade e lista de palavras em ambiente interno, ainda sem liberar para criancas reais.

Saida esperada:

- proposta de missao gerada pela IA;
- dose sugerida;
- texto infantil;
- criterios de conclusao;
- evidencias que seriam registradas.

### Fase 3: MVP do modulo

Implementar atividades com audio simples de escuta no vocabulario, sem avaliacao de fala:

- verb to be;
- simple present;
- present continuous;
- question words;
- vocabulary list.

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
