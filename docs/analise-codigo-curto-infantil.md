# Analise Tecnica: Codigo Curto Infantil

Data: 2026-07-10

## Objetivo

Preparar a base tecnica para permitir que a crianca acesse uma missao por codigo curto, sem transformar esse codigo em login permanente.

Referencia de produto:

- `docs/decisao-codigo-curto-infantil.md`
- `docs/decisao-token-infantil.md`
- `docs/prd-portal-crianca.md`

## Decisao tecnica

O codigo curto deve reutilizar a tabela `child_access_tokens`.

Motivo:

- a tabela ja representa acesso infantil com escopo;
- ja possui `child_id`, `assignment_id`, `purpose`, `expires_at` e `revoked_at`;
- evita criar uma segunda fonte de permissao;
- preserva a regra de que crianca nao tem acesso adulto.

## Mudanca proposta no banco

Adicionar campos opcionais:

```text
access_code_hash text
access_code_prefix text
access_code_created_at timestamptz
access_code_attempts integer default 0
```

O codigo puro nao deve ser salvo.

`access_code_hash` deve funcionar como o `token_hash`: o servidor compara o hash recebido com o hash persistido.

## Fluxo futuro de API

### Geracao

Endpoint atual:

```text
POST /api/child-access-token
```

Evolucao futura:

- gerar token longo;
- opcionalmente gerar codigo curto;
- salvar `token_hash` e `access_code_hash`;
- devolver `child_url` e `access_code` ao adulto.

Resposta futura esperada:

```json
{
  "ok": true,
  "child_url": "https://.../child.html?token=...",
  "access_code": "LER-4821",
  "access": {
    "purpose": "assignment",
    "expires_at": "..."
  }
}
```

### Entrada por codigo

Endpoint futuro:

```text
POST /api/child-code-session
```

Entrada:

```json
{
  "code": "LER-4821"
}
```

Saida:

- dados seguros da crianca;
- missao liberada;
- token de sessao ou redirecionamento para `child.html`.

## Regras de seguranca

- Codigo expirado falha.
- Codigo revogado falha.
- Codigo errado nao informa se a crianca existe.
- Tentativas devem ser limitadas antes de uso amplo em sala.
- O codigo nao deve permitir listar todas as missoes da crianca se estiver ligado a uma tarefa especifica.
- O codigo nao deve retornar conteudo adulto.

## Ponderacao

O caminho mais simples seria criar um codigo visivel e salvar em texto no banco. Nao recomendo.

Mesmo sendo um produto educacional, codigo infantil pode circular em grupo, caderno, WhatsApp ou quadro de sala. Salvar apenas hash reduz impacto caso o banco ou logs sejam expostos.

## Arquivos propostos

- `supabase/migrations/20260710_child_short_codes.sql`
- `supabase/tests/20260710_child_short_codes_smoke.sql`

## Criterios de aceite da preparacao

- Migração adiciona campos sem apagar dados existentes.
- Smoke test retorna `ok` para colunas e indices esperados.
- Portal atual continua funcionando mesmo antes de a UI usar codigo curto.
- Implementacao futura pode gerar link e codigo para a mesma missao.
