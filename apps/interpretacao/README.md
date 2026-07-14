# Interpretação de Texto

Aplicativo HTML para atividades de interpretação de texto.

Esta pasta é a cópia paralela do módulo dentro do monorepo do Portal Educacional. A versão antiga deve continuar ativa até esta versão ser publicada, testada e conectada ao Portal.

## Como abrir localmente

1. Copie `.env.example` para `.env`.
2. Coloque sua chave da OpenAI em `OPENAI_API_KEY`.
3. Rode:

```bat
npm install
npm start
```

Depois acesse:

```text
http://localhost:3001/index.html
```

## Verificação

```bat
npm run check
```

## Publicação paralela na Vercel

Crie um projeto novo na Vercel usando o mesmo repositório `Portal-Educacional`, mas com estas configurações:

```text
Root Directory: apps/interpretacao
Framework Preset: Other
Build Command: deixe vazio
Output Directory: deixe vazio
Install Command: npm install
```

Variáveis de ambiente:

```text
OPENAI_API_KEY=<sua chave da OpenAI>
OPENAI_MODEL=gpt-4.1-mini
```

Depois do deploy, teste:

```text
/
/index.html
/api
```

Resultado esperado em `/api`:

```text
OK - Interpretacao de Texto backend rodando
```

Somente depois de testar uma missão infantil completa, o Portal deve trocar o link antigo pela nova URL.

## Observacao sobre o ChatGPT

Este repositorio agora tem backend proprio em `server.js`. Ele nao depende do projeto `RedacaoMiguelGPT`.

As funcoes com ChatGPT usam a variavel `OPENAI_API_KEY`. Se ela nao estiver configurada, o app usa respostas locais simples para a atividade continuar funcionando.

## Observação sobre sessões na Vercel

Em produção Vercel, as sessões temporárias da atividade ficam em memória do processo serverless. Isso é suficiente para o teste paralelo, mas deve ser observado nos testes reais. Se aparecer "Sessão não encontrada", o próximo passo técnico é mover o estado da atividade para o Portal/Supabase ou para o navegador da criança.
