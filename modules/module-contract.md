# Contrato de Módulo

Um módulo é qualquer experiência de aprendizagem plugada ao Portal Educacional.

## Cadastro do módulo

Cada módulo deve ter:

```json
{
  "id": "interpretacao",
  "name": "Interpretação de Texto",
  "area": "leitura",
  "description": "Leitura, perguntas e feedback para compreensão.",
  "url": "https://interpretacao-de-texto.vercel.app",
  "status": "available"
}
```

Campos recomendados para a arquitetura plugável:

- `short_name`: nome curto para botoes e cartoes;
- `area`: dominio amplo, como `leitura`, `escrita`, `matematica`, `idiomas` ou `organizacao`;
- `journey`: jornada de apoio relacionada, como `leitura_e_interpretacao` ou `ingles_inicial`;
- `skills`: habilidades pedagogicas observaveis que o modulo pode alimentar;
- `commercial_key`: chave futura para habilitacao por modulo, pacote ou plano;
- `status`: `available`, `planned`, `internal` ou `disabled`;
- `accent` e `icon`: apoio visual no portal.

Regra importante:

O modulo pode ser vendido, habilitado ou escondido no futuro, mas a crianca deve ver apenas atividades liberadas. A experiencia infantil nao deve exibir bloqueios comerciais.

## Abertura a partir do portal

O portal pode abrir o módulo com parâmetros:

```text
?child_id=<uuid>
&child_name=<nome>
&portal_return_url=<url>
&portal_event_token=<token curto>
```

## Registro de resultado

O módulo deve enviar evidências para:

```text
POST /api/activity-events
```

## Sinais transversais da missão

Todos os módulos devem tratar a missão como uma experiência curta, concluível e observável. Além das métricas próprias de cada área, o módulo deve enviar sinais transversais em `metrics` sempre que possível:

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

Regras de experiência:

- o tempo é invisível para a criança e não deve virar pressão;
- a autoavaliação da criança é opcional;
- a pergunta deve falar da missão, não da identidade da criança;
- respostas devem ser fechadas, curtas e não diagnósticas;
- esses sinais são contexto longitudinal, nunca julgamento isolado.

Valores recomendados para `child_self_assessment`:

- `calm`: Foi tranquilo;
- `needed_thinking`: Precisei pensar;
- `try_again`: Quero tentar de novo;
- `liked`: Gostei;
- `easy`: Foi fácil;
- `right_level`: Foi na medida;
- `hard_but_done`: Foi difícil, mas consegui;
- `practice_more`: Quero treinar mais esse assunto.

O portal pode exibir esses sinais no histórico adulto e combiná-los com acertos, tentativas, textos, feedbacks e metas. A IA deve usar essa camada para orientar o adulto com cautela, sem diagnóstico, sem ranking e sem conclusões amplas com poucos dados.

## Feedback pontual e feedback geral

Cada módulo deve produzir feedback pontual da atividade. O portal usa vários feedbacks pontuais para montar um feedback geral da criança.

Regra importante:

- o módulo fala sobre aquela atividade;
- o portal fala sobre evolução ao longo do tempo;
- o portal não deve concluir algo amplo quando há pouca evidência;
- feedback geral precisa citar evidências por área.
- novos dominios, como Ingles, devem seguir o mesmo contrato em vez de virar excecao.

Com o token no corpo:

```json
{
  "portal_event_token": "token",
  "activity_type": "analise_final",
  "title": "Redação sobre aventura",
  "metrics": {
    "started_at": "2026-07-14T10:00:00.000Z",
    "finished_at": "2026-07-14T10:08:30.000Z",
    "duration_seconds": 510,
    "completed": true,
    "child_self_assessment": "needed_thinking",
    "child_self_assessment_label": "Precisei pensar"
  },
  "feedback": {
    "child": {
      "tone": "positive",
      "message": "Você organizou bem a ideia principal.",
      "next_step": "Agora vamos melhorar uma parte do meio do texto."
    },
    "adult": {
      "summary": "A criança tem boa ideia central e precisa fortalecer encadeamento.",
      "strengths": ["ideia principal clara"],
      "attention_points": ["ligação entre acontecimentos"],
      "recipe": [
        "Peça para contar a história oralmente em três partes.",
        "Anote começo, meio e fim em cartões.",
        "Depois peça para reescrever apenas o meio."
      ],
      "avoid_saying": ["Seu texto está confuso."]
    }
  },
  "artifacts": {}
}
```
