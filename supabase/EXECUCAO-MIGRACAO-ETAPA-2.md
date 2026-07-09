# Execucao da Migracao da Etapa 2

Migracao:

```text
supabase/migrations/20260709_access_control_foundation.sql
```

Status: pronta para revisao, ainda nao aplicada automaticamente.

## Ponderacao

Esta migracao mexe em seguranca, papeis e RLS. Ela deve ser rodada com calma no SQL Editor do Supabase, acompanhada de testes.

Nao e uma migracao visual. Se algo ficar errado aqui, o portal pode:

- bloquear acesso legitimo;
- liberar informacao sensivel;
- quebrar criacao de criancas;
- impedir leitura de evidencias.

Por isso, o caminho correto e:

1. revisar SQL;
2. rodar migracao;
3. rodar smoke test;
4. testar fluxo real do portal;
5. so depois adaptar interface e endpoints.

## Antes de rodar

Confirme:

- o portal atual esta funcionando;
- voce esta no projeto Supabase correto;
- voce tem acesso ao SQL Editor;
- existe um usuario adulto de teste;
- existe pelo menos uma crianca cadastrada para teste.

## Passo 1: abrir o SQL Editor

No Supabase:

1. abra o projeto do Portal Educacional;
2. va em SQL Editor;
3. crie uma nova query;
4. cole o conteudo de:

```text
supabase/migrations/20260709_access_control_foundation.sql
```

5. execute.

Resultado esperado:

- query executada sem erro;
- novas tabelas criadas;
- novas policies criadas;
- funcoes auxiliares atualizadas.

## Passo 2: rodar smoke test

Depois de rodar a migracao, execute:

```text
supabase/tests/20260709_access_control_smoke.sql
```

Resultado esperado:

- linhas com status `ok`;
- nenhuma linha com status `missing`.

## Passo 3: testar portal atual

No portal publicado:

1. entre com o adulto;
2. confirme que as criancas aparecem;
3. selecione uma crianca;
4. confirme que metas e historico carregam;
5. tente criar uma crianca de teste;
6. tente criar uma meta simples;
7. abra a area da crianca;
8. confirme que voltar ao adulto pede senha.

## Passo 4: testes de seguranca manual

Estes testes podem ser feitos gradualmente:

- responsavel ve apenas criancas vinculadas;
- professor so ve aluno quando houver vinculo;
- percepcao privada nao aparece para crianca;
- token infantil expirado nao deve funcionar quando implementado;
- feedback adulto nao aparece na area infantil;
- relatorio longitudinal nao aparece na area infantil.

## Se der erro

Nao tente corrigir direto no Supabase sem registrar o erro.

Anote:

- mensagem exata;
- linha aproximada;
- qual query estava sendo executada;
- se o erro ocorreu na migracao ou no smoke test.

Depois traga o erro para o Codex.

## Importante

Esta migracao ainda nao coloca a area infantil por token em funcionamento sozinha.

Ela cria a fundacao de banco. Depois ainda precisamos adaptar:

- endpoints;
- interface adulta;
- interface infantil;
- integracao dos modulos.
