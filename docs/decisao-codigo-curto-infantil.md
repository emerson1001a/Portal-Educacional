# Decisao: Codigo Curto Infantil

Data: 2026-07-10

## Decisao

O Portal Educacional deve oferecer dois caminhos de acesso infantil:

- link infantil, como caminho principal e mais simples;
- codigo curto, como alternativa para criancas maiores, sala de aula e situacoes em que copiar um link seja ruim.

O codigo curto nao sera tratado como login infantil permanente nesta fase.

Ele sera um atalho temporario para uma missao, uma sessao ou uma area infantil limitada. A permissao real continua sendo resolvida no servidor, com o mesmo cuidado do token infantil.

## Critica de produto

Ter codigo curto ajuda muito em sala de aula e com criancas que ja digitam sozinhas. Porem, se ele virar uma "senha fixa da crianca", o produto cria riscos desnecessarios:

- codigo compartilhado por muito tempo;
- crianca acessando sem contexto adulto;
- dificuldade de revogar;
- confusao entre area infantil e conta autenticada;
- aumento de suporte antes de o fluxo pedagogico estar maduro.

Por isso, a decisao correta agora e usar codigo curto como acesso temporario, nao como identidade permanente da crianca.

## Modelo recomendado

### Link infantil

Uso principal:

- criancas pequenas;
- uso em casa;
- adulto abrindo a atividade no mesmo aparelho;
- envio direto por WhatsApp, e-mail ou mensagem.

Exemplo:

```text
https://portal-educacional-weld.vercel.app/child.html?token=...
```

### Codigo curto

Uso principal:

- crianca maior digitando sozinha;
- professor escrevendo no quadro;
- turma de reforco;
- adulto evitando enviar um link longo;
- tarefa especifica com prazo.

Exemplos aceitaveis:

```text
LER-4821
RED-7394
MAT-8162
A7K9P2
```

Recomendacao:

- usar prefixo por area quando ajudar a orientar o adulto;
- aceitar codigo sem diferenciar maiusculas e minusculas;
- evitar caracteres ambiguos como `O`, `0`, `I` e `1` quando possivel.

### PIN infantil

PIN infantil fica como opcao futura.

Uso possivel no futuro:

- crianca maior com area recorrente;
- escola usando o portal com frequencia;
- necessidade de trocar de crianca no mesmo aparelho.

Fora de escopo agora:

- conta propria da crianca;
- recuperacao de senha infantil;
- PIN permanente;
- login infantil com e-mail.

## Escopo e expiracao

### Codigo de missao

Uso:

- abrir uma missao especifica;
- exibir apenas a tarefa liberada;
- permitir devolucao de evidencia ao adulto.

Expiracao:

- mesma regra do token `assignment`;
- padrao: 72 horas;
- maximo: 7 dias;
- se houver `due_at`, expira no menor prazo entre `due_at` e 7 dias.

### Codigo de sessao ou sala

Uso:

- professor liberando atividade durante uma aula;
- reforco presencial;
- sessao curta acompanhada por adulto.

Expiracao:

- recomendado: 2 a 8 horas;
- maximo: 24 horas, se houver necessidade operacional.

## Regras de seguranca

- O codigo curto deve resolver server-side para um acesso permitido.
- O banco nao deve depender de codigo puro persistido em texto aberto.
- Preferir guardar hash do codigo, como no token infantil.
- Codigo expirado nao abre atividade.
- Codigo revogado nao abre atividade.
- Codigo de missao nao mostra area adulta.
- Codigo de missao nao mostra percepcoes, notas privadas, metas adultas ou relatorio tecnico.
- Codigo de missao nao deve listar outras criancas.
- O sistema deve prever limite de tentativas antes de uso amplo em escola.

## Experiencia do adulto

Ao liberar uma missao, o adulto deve ver:

- botao para copiar link;
- codigo curto visivel;
- validade do acesso;
- acao para revogar ou gerar novo acesso no futuro.

Texto sugerido:

```text
Envie o link ou passe este codigo para a crianca.
Ele libera apenas esta missao por tempo limitado.
```

## Experiencia da crianca

Futuro ponto de entrada:

```text
/entrar
```

ou:

```text
/codigo
```

A tela deve pedir apenas:

```text
Digite o codigo da sua atividade.
```

Depois de validar, a crianca deve ir para a area infantil com a missao liberada.

Mensagem de erro:

```text
Esse codigo nao esta disponivel agora. Peca ajuda para um adulto.
```

## Impacto tecnico futuro

Implementacao provavel:

- tabela ou colunas para `access_code_hash`;
- endpoint `POST /api/child-code-session`;
- pagina infantil de entrada por codigo;
- rate limit por IP e por codigo;
- auditoria simples de tentativas;
- integracao com `child_access_tokens` ou tabela equivalente.

Preferencia:

- reutilizar o modelo de token infantil;
- tratar codigo curto como alias humano para um acesso com escopo;
- nao criar uma segunda arvore de permissao.

## Criterios de aceite futuro

- Adulto consegue gerar link e codigo para a mesma missao.
- Crianca consegue entrar por codigo sem ver area adulta.
- Codigo expirado falha com mensagem calma.
- Codigo errado nao informa detalhes sensiveis.
- Adulto consegue entender validade e escopo do acesso.
- Historico continua ligado a crianca, missao e modulo.
- Implementacao nao cria conta infantil permanente.
