# Contrato de Modulo

Um modulo e qualquer experiencia de aprendizagem plugada ao Portal Educacional.

## Cadastro do modulo

Cada modulo deve ter:

```json
{
  "id": "interpretacao",
  "name": "Interpretacao de Texto",
  "area": "leitura",
  "description": "Leitura, perguntas e feedback para compreensao.",
  "url": "https://interpretacao-de-texto.vercel.app",
  "status": "available"
}
```

## Abertura a partir do portal

O portal pode abrir o modulo com parametros:

```text
?child_id=<uuid>
&child_name=<nome>
&portal_return_url=<url>
&portal_event_token=<token curto>
```

## Registro de resultado

O modulo deve enviar evidencias para:

```text
POST /api/activity-events
```

## Feedback pontual e feedback geral

Cada modulo deve produzir feedback pontual da atividade. O portal usa varios feedbacks pontuais para montar um feedback geral da crianca.

Regra importante:

- o modulo fala sobre aquela atividade;
- o portal fala sobre evolucao ao longo do tempo;
- o portal nao deve concluir algo amplo quando ha pouca evidencia;
- feedback geral precisa citar evidencias por area.

Com o token no corpo:

```json
{
  "portal_event_token": "token",
  "activity_type": "analise_final",
  "title": "Redacao sobre aventura",
  "metrics": {},
  "feedback": {
    "child": {
      "tone": "positive",
      "message": "Voce organizou bem a ideia principal.",
      "next_step": "Agora vamos melhorar uma parte do meio do texto."
    },
    "adult": {
      "summary": "A crianca tem boa ideia central e precisa fortalecer encadeamento.",
      "strengths": ["ideia principal clara"],
      "attention_points": ["ligacao entre acontecimentos"],
      "recipe": [
        "Peca para contar a historia oralmente em tres partes.",
        "Anote começo, meio e fim em cartoes.",
        "Depois peça para reescrever apenas o meio."
      ],
      "avoid_saying": ["Seu texto esta confuso."]
    }
  },
  "artifacts": {}
}
```
