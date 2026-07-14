# PRD: Sinais da Missao

## Contexto

O Portal Educacional acompanha criancas e adultos em uma caminhada de aprendizagem. Os modulos ja registram acertos, tentativas, textos, feedbacks e evidencias. Ainda falta padronizar sinais transversais que ajudem o adulto a entender a dose da missao e a vivencia da crianca sem transformar isso em cobranca.

Este PRD define uma camada simples de sinais da missao:

- tempo invisivel de execucao;
- autoavaliacao leve da crianca;
- leitura combinada pela IA;
- orientacao esperancosa para o adulto;
- incentivo positivo para a crianca.

## Principio

O portal cuida do percurso da crianca e da confianca do adulto.

A crianca deve sentir progresso, seguranca e vontade de continuar. O adulto deve receber indicadores reais, mas acompanhados de uma orientacao pratica, cuidadosa e esperancosa.

## Objetivo

Adicionar sinais simples ao final das missoes para ajudar o portal a responder:

- a missao estava na dose certa?
- a crianca concluiu com bom ritmo?
- houve esforco produtivo?
- a atividade gerou resistencia, cansaco ou vontade de tentar de novo?
- qual deve ser o proximo passo do adulto?

Esses sinais devem complementar, nao substituir, acertos, tentativas, textos, feedbacks e observacoes adultas.

## Escopo MVP

### 1. Tempo invisivel da missao

Cada modulo deve registrar:

- horario de inicio;
- horario de fim;
- duracao total;
- se a missao foi concluida ou abandonada.

Regra de experiencia infantil:

- a crianca nao deve ver cronometro;
- o tempo nao deve aparecer como pressao;
- nao deve haver ranking por velocidade;
- nao deve haver mensagem infantil comparando tempo.

Leitura adulta:

- "missao curta";
- "bom ritmo";
- "exigiu mais tempo";
- "foi concluida mesmo exigindo esforco";
- "vale reduzir a dose na proxima missao".

O tempo nunca deve ser interpretado sozinho.

### 2. Autoavaliacao leve da crianca

Ao final de cada missao, o modulo pode perguntar de forma opcional:

```text
Como foi essa missao para voce?
```

As respostas devem ser fechadas, simples e nao diagnosticas.

Para criancas menores:

- expressao tranquila: "Foi tranquilo";
- expressao pensando: "Precisei pensar";
- expressao tentando: "Quero tentar de novo";
- estrela ou coracao: "Gostei".

Para criancas maiores:

- "Foi facil";
- "Foi na medida";
- "Foi dificil, mas consegui";
- "Quero treinar mais esse assunto".

Regra:

- adaptar formato por idade;
- usar visual para menores;
- usar texto curto para maiores;
- nao usar campo livre no MVP;
- nao usar opcoes como "sou ruim", "fiquei triste" ou qualquer rotulo pessoal;
- perguntar sobre a missao, nao sobre a identidade da crianca.

### 3. Perfil de resposta da crianca

A autoavaliacao deve ser interpretada como sinal de contexto, nao como verdade absoluta.

Algumas criancas podem responder de forma brincalhona, resistente, impulsiva ou muito detalhada. O sistema deve evitar conclusoes a partir de uma resposta isolada.

Regra:

- observar padrao ao longo do tempo;
- cruzar com tempo, acertos, tentativas e conclusao;
- permitir que o adulto registre contexto quando necessario;
- nao gerar alerta por uma resposta isolada.

### 4. Sintese da IA

A IA pode combinar os sinais da missao para organizar uma leitura para o adulto.

Entradas possiveis:

- tempo invisivel;
- acertos;
- tentativas;
- pedidos de ajuda;
- autoavaliacao da crianca;
- tipo de atividade;
- dificuldade planejada pelo adulto;
- idade;
- historico anterior;
- metas ativas;
- evidencias recentes;
- observacoes do adulto.

A IA deve:

- organizar sinais;
- apontar padroes com cautela;
- sugerir proximo passo pequeno;
- orientar o adulto com frases praticas;
- proteger o adulto de panico ou culpa;
- proteger a crianca de rotulos.

A IA nao deve:

- diagnosticar;
- concluir algo amplo com poucos dados;
- chamar a crianca de resistente, lenta, insegura ou incapaz;
- transformar tempo em cobranca;
- recomendar excesso de tarefas;
- falar com tom alarmista.

Exemplo de leitura adulta:

```text
Hoje a missao exigiu um pouco mais de tempo, mas foi concluida. A crianca marcou que precisou pensar. Isso sugere esforco produtivo, nao fracasso. Para a proxima pratica, mantenha uma missao curta no mesmo assunto antes de aumentar a dificuldade.
```

Quando houver pouca evidencia:

```text
Ainda temos poucos sinais para definir um padrao. Vale fazer mais duas ou tres missoes curtas e observar se a mesma dificuldade aparece.
```

### 5. Devolutiva para a crianca

A crianca deve receber uma mensagem curta, concreta e positiva.

Exemplos:

```text
Voce terminou a missao de hoje. Cada tentativa ajuda um pouco.
```

```text
Hoje voce precisou pensar e conseguiu concluir. Isso tambem e progresso.
```

```text
Boa missao. Agora o adulto acompanha seu progresso.
```

Evitar:

- elogio exagerado;
- comparacao com outras criancas;
- linguagem tecnica;
- mencao a tempo;
- cobranca de desempenho.

## Evidencias no contrato dos modulos

Cada modulo deve poder enviar estes campos em `metrics`:

```json
{
  "started_at": "2026-07-14T10:00:00.000Z",
  "finished_at": "2026-07-14T10:08:30.000Z",
  "duration_seconds": 510,
  "completed": true,
  "child_self_assessment": "needed_thinking",
  "child_self_assessment_label": "Precisei pensar"
}
```

Nomes sugeridos para `child_self_assessment`:

- `calm`;
- `needed_thinking`;
- `try_again`;
- `liked`;
- `easy`;
- `right_level`;
- `hard_but_done`;
- `practice_more`.

## Relatorio adulto

O relatorio adulto deve tratar esses sinais como parte da leitura longitudinal.

Exemplos de texto:

```text
Nas ultimas missoes, a crianca concluiu as atividades, mas marcou com frequencia que precisou pensar. Isso pode indicar que a dose esta produtiva, desde que a rotina continue leve.
```

```text
Houve aumento de tempo em escrita, mas tambem conclusao das missoes. Para o adulto: manter uma tarefa curta e reforcar metodo antes de aumentar o tamanho.
```

## Fora do MVP

- campo livre para a crianca escrever como se sentiu;
- analise emocional automatica;
- graficos complexos de humor;
- ranking de tempo;
- pontuacao por velocidade;
- alerta clinico;
- diagnostico psicologico;
- comparacao entre criancas.

## Criterios de aceite

- Crianca pode concluir a missao sem responder a autoavaliacao.
- Autoavaliacao aparece em linguagem adequada a idade.
- Tempo e registrado sem ser mostrado para a crianca.
- Adulto recebe uma leitura simples, nao alarmista.
- IA combina sinais sem diagnosticar.
- Relatorio longitudinal usa sinais como contexto, nao como julgamento.
- O produto preserva esperança realista e metodo para o adulto.

