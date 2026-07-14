# PRD: Consolidacao dos Modulos no Mesmo GitHub

## Contexto

O Portal Educacional hoje funciona como produto central, mas os modulos ainda estao em situacoes diferentes:

- Portal: `C:\Users\Emerson\Documents\Codex\PortalEducacional`;
- Tabuada: ja esta dentro do Portal, em `apps/portal/tabuada.html`;
- Redacao: esta em `C:\Users\Emerson\Documents\Codex\RedacaoMiguelGPT`;
- Interpretacao: esta em `C:\Users\Emerson\Documents\Codex\2026-07-04\es\work\Interpretacao-de-texto`.

A decisao de produto e tecnica e consolidar Redacao, Interpretacao e Tabuada no mesmo GitHub do Portal Educacional, mantendo a arquitetura plugavel e o contrato comum de evidencias.

## Critica e cuidado principal

Essa consolidacao faz sentido, mas nao deve ser feita de forma brusca.

Redacao e Interpretacao ja funcionam em producao e ja sao usados em testes reais. A migracao deve preservar os deploys atuais ate que cada modulo esteja copiado, revisado, testado e publicado a partir do novo repositorio sem perda de comportamento.

O objetivo nao e apenas juntar arquivos. O objetivo e reduzir divergencia entre produtos, facilitar manutencao, padronizar UX, padronizar retorno de evidencias e preparar o Portal para novos modulos.

## Objetivos

1. Ter um unico repositorio GitHub como fonte principal do Portal Educacional.
2. Organizar cada modulo em uma pasta propria.
3. Preservar deploys atuais ate a migracao ser validada.
4. Evitar vazamento de chaves, `.env`, arquivos locais ou historicos sensiveis.
5. Manter o contrato comum de modulos para missoes, evidencias, feedbacks e sinais da missao.
6. Preparar base para identidade visual comum e futuras jornadas por modulo.

## Fora do escopo inicial

- Reescrever Redacao do zero.
- Reescrever Interpretacao do zero.
- Trocar dominio publico no primeiro commit.
- Fundir todos os backends em uma unica API sem auditoria.
- Apagar repositorios antigos antes da validacao.
- Migrar dados historicos manualmente sem plano proprio.

## Estrutura alvo

Estrutura recomendada para o monorepo:

```text
PortalEducacional/
  apps/
    portal/
      index.html
      child.html
      tabuada.html
      api/
      lib/
    redacao/
      public/
      api/
      package.json
      vercel.json
    interpretacao/
      index.html
      api/
      data/
      package.json
      vercel.json
  modules/
    module-contract.md
  docs/
  projeto/
  supabase/
```

Observacao sobre a Tabuada:

No curto prazo, a Tabuada pode continuar em `apps/portal/tabuada.html`, pois ja esta integrada ao Portal. Em uma etapa posterior, ela pode virar `apps/tabuada/` se isso facilitar deploy, manutencao ou padronizacao visual.

## Estrategia de deploy

### Etapa segura recomendada

Usar o mesmo GitHub, mas manter projetos Vercel separados por pasta:

- `apps/portal` para o Portal;
- `apps/redacao` para Redacao;
- `apps/interpretacao` para Interpretacao.

Essa estrategia reduz risco porque cada modulo preserva seu proprio `package.json`, `vercel.json`, endpoints e variaveis.

## Decisao de migracao paralela

A migracao deve acontecer em paralelo:

1. copiar Redacao e Interpretacao para a area do Portal no monorepo;
2. manter as versoes atuais funcionando nos enderecos antigos;
3. publicar novas versoes em URLs paralelas da Vercel;
4. testar os fluxos com perfis ficticios;
5. trocar o cadastro de modulos do Portal para apontar para as novas URLs;
6. observar o uso real por um periodo curto;
7. somente depois desativar os projetos antigos.

Regra de seguranca:

- desativar nao significa apagar imediatamente;
- manter plano de retorno enquanto Miguel, Gabriel ou perfis reais estiverem testando;
- nao trocar o link antigo antes de confirmar que a nova versao registra evidencias, conclui missoes e retorna corretamente ao Portal;
- preservar os repositorios/projetos antigos como legado ate termos estabilidade.

### Etapa futura possivel

Depois de estabilidade, avaliar se faz sentido servir tudo por um unico dominio:

```text
portal-educacional.../
  /              Portal adulto
  /child.html    Portal infantil
  /redacao       Modulo Redacao
  /interpretacao Modulo Interpretacao
  /tabuada       Modulo Tabuada
```

Essa etapa exige revisao cuidadosa de rotas, APIs, rewrites e variaveis de ambiente.

## Plano de migracao

### Estado atual

- Interpretacao copiada para `apps/interpretacao`.
- Deploy antigo de Interpretacao deve continuar ativo.
- Portal ainda deve apontar para a URL antiga ate a nova copia ser validada em Vercel.
- Redacao ainda nao foi copiada para o monorepo.

### Fase 1: Inventario

- Listar arquivos de Redacao e Interpretacao.
- Identificar `.env`, chaves, logs, caches, `node_modules`, arquivos temporarios e arquivos que nao devem entrar no Git.
- Identificar endpoints existentes e nomes de rotas.
- Identificar variaveis usadas em cada app.
- Identificar URLs atuais em producao.

### Fase 2: Copia controlada

- Criar `apps/redacao/`.
- Criar `apps/interpretacao/`.
- Copiar somente codigo-fonte, arquivos publicos, `package.json`, `package-lock.json`, `vercel.json`, `README.md` e exemplos seguros.
- Nao copiar `.env`, chaves, `Chaves.txt`, `node_modules`, logs, caches, `.vercel`, `.git` interno ou arquivos locais de execucao.
- Manter os projetos antigos ativos durante toda a copia.

### Fase 3: Validacao local

Para cada modulo:

- instalar dependencias se necessario;
- rodar verificacao sintatica;
- iniciar localmente;
- abrir pela URL local;
- fazer um fluxo minimo de atividade;
- confirmar retorno ao Portal quando chamado com token de missao.

### Fase 4: Deploy paralelo

- Criar ou ajustar projeto Vercel apontando para a pasta do modulo no monorepo.
- Configurar variaveis de ambiente na Vercel do modulo.
- Fazer deploy paralelo sem trocar o link usado em producao.
- Testar URL nova com perfil ficticio.

Configuracao inicial para a Interpretacao:

```text
Root Directory: apps/interpretacao
Framework Preset: Other
Build Command: deixe vazio
Output Directory: deixe vazio
Install Command: npm install
```

Variaveis:

```text
OPENAI_API_KEY
OPENAI_MODEL=gpt-4.1-mini
```

Testes minimos depois do deploy:

- abrir `/`;
- abrir `/index.html`;
- abrir `/api` e confirmar a mensagem `OK - Interpretacao de Texto backend rodando`;
- criar uma missao de Interpretacao com perfil ficticio;
- concluir a atividade infantil;
- confirmar evidencia no historico adulto;
- confirmar que a missao saiu da lista de pendentes.

### Fase 5: Troca controlada de URL

- Atualizar `apps/portal/lib/modules.js` para apontar para a nova URL do modulo consolidado.
- Testar missao infantil.
- Testar evidencia no adulto.
- Testar fechamento de meta.
- Manter URL antiga disponivel por um tempo como plano de retorno.
- So depois de alguns testes reais, retirar o modulo antigo da operacao normal.

### Fase 6: Limpeza posterior

- Documentar repositorios antigos como legados.
- Evitar apagar repositorios antigos ate termos uso real validado.
- Revisar README e onboarding do projeto.

## Regras de seguranca

- Nunca copiar `.env` para o monorepo.
- Nunca copiar chaves OpenAI, Supabase ou secrets locais.
- Nunca copiar `Chaves.txt`.
- Nunca copiar `node_modules`.
- Nunca copiar `.vercel` ou credenciais locais.
- Variaveis devem ficar em `.env.example` e na Vercel/Supabase.
- Dados reais de criancas nao devem ser exportados para arquivos do repositorio.

## Contrato comum dos modulos

Cada modulo consolidado deve seguir `modules/module-contract.md`.

Campos esperados no retorno ao Portal:

- `activity_type`;
- `title`;
- `metrics`;
- `feedback.child`;
- `feedback.adult`;
- `artifacts`.

Campos transversais recomendados em `metrics`:

- `started_at`;
- `finished_at`;
- `duration_seconds`;
- `completed`;
- `child_self_assessment`;
- `child_self_assessment_label`.

## Criterios de aceite

### Para Redacao

- A crianca consegue iniciar a missao pelo Portal Infantil.
- O modulo reconhece nome e idade vindos do Portal.
- A crianca conclui a redacao.
- A versao final revisada e enviada ao Portal.
- O adulto ve texto, feedback e sinais de missao.
- A missao sai de pendente e aparece como concluida.
- O fluxo validado com Miguel nao perde sua logica pedagogica.

### Para Interpretacao

- A crianca inicia a leitura pelo Portal Infantil.
- O texto e as perguntas ficam coerentes.
- O feedback final fica visualmente destacado.
- A atividade concluida retorna ao Portal.
- O adulto ve leitura, perguntas/respostas, feedback e sinais de missao.
- A missao sai de pendente e aparece como concluida.

### Para Tabuada

- O modulo continua concluindo a missao corretamente.
- O adulto define tabuadas, dose ou modo quando a missao exigir.
- O historico adulto recebe apenas registro final em modo missao.
- Sinais de missao aparecem no historico adulto.

## Decisao recomendada

Comecar pela documentacao e inventario.

Depois, migrar Interpretação primeiro, porque o app e menor que a Redacao e permite validar o padrao de monorepo com menor risco.

Migrar Redacao depois, com mais cuidado, porque e o case pedagogico mais validado e nao deve perder o metodo de etapas que funcionou com o Miguel.
