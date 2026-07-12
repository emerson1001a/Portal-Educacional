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

O MVP deve conter cinco tipos de missao.

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
6. registrar quais palavras foram praticadas.

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

## Experiencia da crianca

A crianca deve receber:

- titulo simples;
- instrucao curta;
- uma questao por vez;
- reforco positivo imediato;
- possibilidade de tentar novamente;
- conclusao clara.

Exemplo:

```text
Missao de Ingles

Vamos treinar frases sobre coisas que estao acontecendo agora.
Faca uma parte pequena. Quando terminar, o adulto acompanha seu progresso.
```

## Tipos de exercicio

O MVP pode usar exercicios sem audio:

- multipla escolha;
- completar lacuna;
- ordenar palavras;
- ligar pergunta e resposta;
- escolher traducao simples;
- revisar palavra ja praticada.

Exercicios com audio e pronuncia devem ficar fora do MVP.

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
    "retry_count": 2
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

Quando houver poucos dados, a IA deve dizer:

```text
Ainda temos poucas evidencias. Vale fazer mais duas ou tres missoes curtas antes de definir uma meta mais precisa.
```

## Fora do MVP

Ficam fora da primeira versao:

- curso completo de Ingles;
- conversacao livre;
- avaliacao avancada de pronuncia;
- audio obrigatorio;
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
  "area": "ingles",
  "journey": "ingles_inicial",
  "description": "Vocabulario e frases simples com missoes curtas.",
  "url": "",
  "status": "planned",
  "accent": "english",
  "icon": "I",
  "skills": ["verb_to_be", "simple_present", "present_continuous", "question_words", "vocabulary_list"],
  "commercial_key": "module_english"
}
```

Observacao:

O campo `area` hoje pode exigir ampliacao do schema, pois as areas atuais foram desenhadas para leitura, escrita, matematica, organizacao e outro. Antes da implementacao, decidir se Ingles sera:

- uma nova area `ingles`; ou
- uma jornada dentro de `outro`; ou
- uma area academica generica com dominio especifico.

Recomendacao inicial: preparar `area = "ingles"` quando o modulo sair do PRD para implementacao.

## Criterios de aceite do PRD

O modulo de Ingles so deve ser implementado quando:

- o contrato de missoes por modulo estiver estavel;
- o portal adulto conseguir configurar missoes por modulo;
- o historico unificado conseguir exibir evidencias por habilidade;
- houver clareza sobre como armazenar `skill`, `vocabulary` e `common_errors`;
- a linguagem infantil e adulta estiver alinhada ao guia pedagogico;
- houver decisao sobre area/jornada `ingles`.

## Roadmap sugerido

### Fase 0: PRD

Documento conceitual, sem implementacao.

### Fase 1: Catalogo planejado

Adicionar Ingles como modulo `planned`, sem botao infantil ativo.

### Fase 2: Configuracao adulta

Permitir montar missao de Ingles com habilidade e lista de palavras, ainda sem modulo completo.

### Fase 3: MVP do modulo

Implementar atividades sem audio:

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

### Fase 5: Audio e pronuncia

Somente depois de validar o MVP textual.

## Decisao

O modulo de Ingles sera planejado como reforco plugavel, orientado por missoes curtas e evidencias.

O adulto podera informar conteudos tecnicos e listas de palavras. A crianca recebera uma experiencia simples, positiva e adaptada.

A prioridade do modulo nao e ensinar Ingles inteiro, mas ajudar o adulto a transformar uma necessidade concreta em pratica pequena, acompanhavel e documentada.
