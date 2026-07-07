# Portal Educacional

Portal inicial para apresentar os servicos educacionais e organizar o acompanhamento dos alunos:

- Interpretacao de Texto: https://interpretacao-de-texto.vercel.app
- Missao Redacao: https://missao-redacao.vercel.app/
- Tabuada Inteligente: em preparacao para publicacao

Projeto estatico pronto para publicacao na Vercel.

## Supabase

O arquivo `supabase-schema.sql` cria o modelo inicial para:

- perfis de responsaveis/professores;
- criancas vinculadas aos responsaveis;
- sessoes de interpretacao e redacao;
- eventos unificados de atividade;
- snapshots de progresso;
- notas de desenvolvimento.

Rode o arquivo inteiro no SQL Editor do Supabase sempre que houver alteracao de schema.

## Variaveis da Vercel

Configure no projeto da Vercel:

```text
SUPABASE_URL
SUPABASE_ANON_KEY
SUPABASE_SERVICE_ROLE_KEY
```

A chave `SUPABASE_SERVICE_ROLE_KEY` fica apenas nas funcoes da Vercel. O navegador usa somente `/api/public-config`, que entrega a URL e a chave publica anonima.

Depois de cadastrar as variaveis na Vercel, acesse:

```text
/api/supabase-status
```

para conferir se o backend consegue conectar ao Supabase.

## Autenticacao

No painel do Supabase, confira tambem:

- Authentication > URL Configuration > Site URL: `https://portal-educacional-weld.vercel.app`
- Redirect URLs: `https://portal-educacional-weld.vercel.app`

O portal ja inclui cadastro, login, sair e fluxo de "esqueci minha senha".
