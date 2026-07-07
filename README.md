# Portal Educacional

Plataforma para pais e professores reforcarem o aprendizado de criancas e adolescentes com atividades digitais, metas pedagogicas e acompanhamento de evolucao.

## Objetivo

O portal nao e apenas uma pagina com links. Ele deve ajudar o adulto a responder:

- o que meu filho ou aluno precisa reforcar?
- qual atividade devo pedir agora?
- como falo isso de um jeito positivo?
- ele esta evoluindo ao longo do tempo?

## Estrutura

```text
PortalEducacional/
  apps/
    portal/              # Portal web principal
  docs/                  # Decisoes de produto e arquitetura
  supabase/              # Schema e politicas do banco
  modules/               # Contratos e futuros modulos plugaveis
```

## Principios pedagogicos

- Feedback para a crianca deve ser curto, positivo e acionavel.
- Feedback para pais/professores deve ser mais completo, mas sempre com receita pratica.
- Evitar linguagem alarmista, culpabilizante ou rotulos negativos.
- Evolucao precisa ser visivel por area, meta e evidencia.

## Modulos iniciais

- Interpretacao de Texto
- Missao Redacao
- Tabuada Inteligente

Novos modulos devem seguir o contrato em `modules/module-contract.md`.
