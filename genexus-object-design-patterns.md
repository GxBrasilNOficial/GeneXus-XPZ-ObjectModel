# Padrões de Desenho de Objetos GeneXus

## Objetivo

Este documento registra padrões de nomenclatura para objetos GeneXus custom.

Ele não trata de estrutura de `XPZ`, nem de regras de empacotamento. Esses assuntos permanecem separados em:

- [genexus-xpz-research.md](C:/Dev/Test/genexus-xpz-research.md)
- [genexus-xpz-generation-rules.md](C:/Dev/Test/genexus-xpz-generation-rules.md)

## Regra Geral

Ao criar objetos custom, usar prefixos consistentes por tipo de objeto.

Esses padrões foram confirmados por varredura observacional no `XPZ` real da KB, mas devem ser aplicados como convenção operacional para objetos novos e mantidos pela equipe.

## Prefixos por Tipo de Objeto

| Tipo de objeto | Prefixo padrão | Exemplo |
| --- | --- | --- |
| `WebPanel` | `wp` | `wpCotacaoDolar` |
| `Web Component` | `wc` | `wcItensPedido` |
| Prompt | `prompt` | `promptProduto` |
| `Procedure` | `proc` | `procBuscarCotacaoDolar` |
| `Structured Data Type` | `sdt` | `sdtCotacaoDolarItem` |
| `SDPanel` | `sd` | `sdLogin` |
| `Data Provider` | `dp` | `dpCotacoesPorPeriodo` |

## Tipos Sem Prefixo Obrigatório

Os tipos abaixo não seguem, nesta KB, um prefixo custom estável e não devem receber prefixo forçado por regra geral:

- `Transaction`
- `Domain`
- `Module`
- `Folder`
- `External Object`

Nesses casos, o padrão preferido é nome conceitual de negócio ou nome técnico claro, conforme a natureza do objeto.

## Exclusões

Os objetos abaixo não devem ser usados como base para inferir convenções custom:

- objetos gerados por `Work With`
- objetos `GAM`
- objetos importados de terceiros
- objetos de bibliotecas, design systems ou patterns nativos

## Observação

Esta convenção é anterior à geração de `XPZ`. Primeiro o objeto deve ser corretamente nomeado; depois, se necessário, ele pode ser empacotado para intercâmbio.
