# Portal Educacional

Plataforma para pais e professores reforçarem o aprendizado de crianças e adolescentes com atividades digitais, metas pedagógicas e acompanhamento de evolução.

## Objetivo

O portal não é apenas uma página com links. Ele deve ajudar o adulto a responder:

- o que meu filho ou aluno precisa reforçar?
- qual atividade devo pedir agora?
- como falo isso de um jeito positivo?
- ele está evoluindo ao longo do tempo?

## Estrutura

```text
PortalEducacional/
  apps/
    portal/              # Portal web principal
  docs/                  # Decisões de produto e arquitetura
  supabase/              # Schema e políticas do banco
  modules/               # Contratos e futuros módulos plugáveis
```

## Princípios pedagógicos

- Feedback para a criança deve ser curto, positivo e acionável.
- Feedback para pais/professores deve ser mais completo, mas sempre com receita prática.
- Evitar linguagem alarmista, culpabilizante ou rótulos negativos.
- Evolução precisa ser visível por área, meta e evidência.

As regras detalhadas de linguagem, limites e orientação estão em `docs/guia-de-orientacao-pedagogica.md`.

## Módulos iniciais

- Interpretação de Texto
- Missão Redação
- Tabuada Inteligente

Novos módulos devem seguir o contrato em `modules/module-contract.md`.
