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
  projeto/              # Painel de acompanhamento do trabalho
  apps/
    portal/              # Portal web principal
    interpretacao/       # Copia paralela do modulo de Interpretacao
    redacao/             # Copia paralela do modulo de Redacao
  docs/                  # Decisões de produto e arquitetura
  supabase/              # Schema e políticas do banco
  modules/               # Contratos e futuros módulos plugáveis
```

## Documentação do projeto

A pasta `projeto/` funciona como painel de acompanhamento: etapa atual, roadmap, backlog e decisões.

A documentação oficial fica em `docs/`.

Comece por:

- `projeto/README.md`: estado atual do trabalho e como retomar uma nova janela do Codex;
- `docs/README.md`: índice da documentação e regra de decisão entre documentos;
- `docs/documento-do-projeto.md`: documento mestre do produto;
- `docs/arquitetura-de-papeis.md`: papéis, permissões e fronteiras entre adulto, professor e criança;
- `docs/guia-de-orientacao-pedagogica.md`: regras de linguagem, feedback e limites pedagógicos.

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

## Consolidação dos módulos

Interpretação de Texto e Missão Redação já foram copiadas para `apps/interpretacao` e `apps/redacao` como etapas da consolidação em monorepo. Os deploys antigos continuam ativos até as novas versões serem publicadas, testadas e conectadas ao Portal.
