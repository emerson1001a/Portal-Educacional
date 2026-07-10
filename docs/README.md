# Documentacao do Projeto

Esta pasta e a fonte oficial de decisoes, definicoes, PRDs e regras de produto do Portal Educacional.

O objetivo e evitar que decisoes importantes fiquem espalhadas em conversas, arquivos soltos ou memoria informal. Sempre que o produto mudar de direcao, a decisao deve virar documento aqui.

## Como usar esta pasta

- `documento-do-projeto.md`: visao consolidada do produto, publico, promessa, modulos, dados, seguranca e roadmap.
- `arquitetura-de-papeis.md`: papeis, permissoes, fronteiras entre adulto, professor e crianca.
- `prd-matriz-de-papeis.md`: PRD fechado da Etapa 1, com matriz de permissoes, bloqueios e criterios de aceite.
- `prd-controle-de-acesso-supabase.md`: desenho da Etapa 2 para tabelas, vinculos, RLS e token infantil.
- `prd-portal-crianca.md`: experiencia infantil, token, missoes, limites de informacao e gamificacao futura.
- `prd-metas-e-tarefas.md`: fluxo de percepcao adulta, meta pedagogica, tarefa, missao infantil e evidencias.
- `prd-modulos-plugaveis.md`: arquitetura de modulos, jornadas de apoio e base para futura habilitacao comercial.
- `analise-schema-etapa-2.md`: comparacao entre o schema atual e a migracao proposta.
- `analise-schema-etapa-5.md`: comparacao entre PRD de metas/tarefas e o schema/migracoes existentes.
- `product-vision.md`: visao curta do produto e principios centrais.
- `guia-de-orientacao-pedagogica.md`: regras de linguagem, feedback, limites pedagogicos e material para revisao profissional.
- `deployment-plan.md`: plano de GitHub, Vercel e Supabase.
- `external-setup.md`: configuracoes externas ja usadas no projeto.
- `decisao-token-infantil.md`: escopos, expiracao e limites do link infantil.

## Onde ficam os PRDs

PRDs devem ficar nesta mesma pasta, com nomes iniciados por `prd-`.

Padrao recomendado:

```text
docs/
  prd-portal-adulto.md
  prd-portal-crianca.md
  prd-matriz-de-papeis.md
  prd-controle-de-acesso-supabase.md
  prd-metas-e-tarefas.md
  prd-relatorio-longitudinal.md
  prd-integracao-modulos.md
  prd-modulos-plugaveis.md
  prd-turma-e-professor.md
```

## Regra de decisao

Quando houver conflito entre documentos:

1. seguranca e privacidade da crianca prevalecem;
2. `guia-de-orientacao-pedagogica.md` prevalece para linguagem e limites de feedback;
3. `arquitetura-de-papeis.md` prevalece para permissoes;
4. `prd-matriz-de-papeis.md` prevalece para a matriz fechada da Etapa 1;
5. `documento-do-projeto.md` prevalece para direcao geral do produto;
6. PRDs prevalecem apenas dentro do escopo funcional especifico.

## Principio permanente

O portal deve ajudar adultos a apoiarem criancas com mais clareza, calma e evidencia, sem transformar dificuldade em rotulo, medo ou culpa.
