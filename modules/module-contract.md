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

## Feedback pontual e feedback geral

Cada módulo deve produzir feedback pontual da atividade. O portal usa vários feedbacks pontuais para montar um feedback geral da criança.

Regra importante:

- o módulo fala sobre aquela atividade;
- o portal fala sobre evolução ao longo do tempo;
- o portal não deve concluir algo amplo quando há pouca evidência;
- feedback geral precisa citar evidências por área.

Com o token no corpo:

```json
{
  "portal_event_token": "token",
  "activity_type": "analise_final",
  "title": "Redação sobre aventura",
  "metrics": {},
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
