# Decisao: Expiracao e Escopo do Token Infantil

Data: 2026-07-10

## Decisao

O acesso infantil sera feito por token com escopo limitado e expiracao por tempo.

O token infantil nao concede acesso adulto. Ele serve apenas para:

- abrir a area infantil;
- listar missoes liberadas;
- abrir modulos com contexto da crianca;
- permitir que modulos devolvam evidencias ao portal.

O codigo curto infantil, quando implementado, sera apenas uma forma humana de chegar ao mesmo tipo de acesso limitado. Ele nao cria permissao mais ampla nem conta permanente da crianca.

Documento relacionado:

- `docs/decisao-codigo-curto-infantil.md`.

## Escopos

### `child_area`

Uso:

- abrir a area infantil geral de uma crianca;
- mostrar missoes liberadas;
- permitir atividades livres quando configuradas.

Expiracao:

- padrao: 24 horas;
- maximo: 72 horas.

Motivo:

Esse link pode ser usado em casa ou em sala no mesmo dia. Como ele abre a area infantil geral, nao deve ficar valido por muitos dias.

### `assignment`

Uso:

- abrir uma missao especifica;
- limitar a experiencia infantil a uma tarefa liberada.

Expiracao:

- padrao: 72 horas;
- maximo: 168 horas, ou 7 dias.

Motivo:

Uma tarefa pode ser enviada por professor ou responsavel e feita em outro momento da semana. Ainda assim, nao deve virar um link permanente.

### `module_return`

Uso futuro:

- token tecnico para retorno de modulo ao portal.

Expiracao recomendada:

- 2 horas.

Estado atual:

O retorno dos modulos usa `portal_child_token` ou token assinado de atividade. A tabela ja preve `module_return`, mas a API publica de link infantil ainda nao gera esse escopo diretamente.

## Regras de seguranca

- O banco guarda apenas `token_hash`, nunca o token puro.
- Token expirado nao abre a area infantil.
- Token revogado nao abre a area infantil.
- Token infantil nao permite consultar relatorios, metas adultas, percepcoes ou notas privadas.
- Quando o token esta ligado a uma tarefa, a area infantil deve filtrar por essa tarefa.
- A crianca nunca deve ver mensagem de plano, pagamento ou bloqueio comercial.

## Ponderacao de produto

Links infantis precisam equilibrar praticidade e protecao.

Se forem curtos demais, pais e professores se frustram. Se forem longos demais, podem circular sem controle.

A regra escolhida preserva o uso real:

- pratica familiar diaria: 24 horas;
- tarefa especifica de professor ou responsavel: ate 7 dias;
- retorno tecnico de modulo: curto e invisivel para a crianca.

## Decisoes futuras

Ainda falta decidir:

- se havera PIN infantil;
- se professor podera gerar links por turma;
- se links poderao ser revogados manualmente pela interface.
