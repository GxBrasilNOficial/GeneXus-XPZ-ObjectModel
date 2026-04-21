# 13 - KB Intelligence Fase 2 - Contrato Inicial

## Papel do documento
contrato operacional

## Nivel de confianca predominante
baixo a medio

## Depende de
11-plano-kb-intelligence-incremental.md, 12-kb-intelligence-fase-1-contrato.md, scripts/README-kb-intelligence.md

## Usado por
agentes que forem ampliar o indice tecnico reutilizavel sem perder o recorte validado da Fase 1

## Objetivo
Definir o primeiro incremento da Fase 2 do KB Intelligence, mantendo a ampliacao pequena, auditavel e validada em casos reais.

## Primeiro alvo aprovado

O primeiro alvo da Fase 2 e `DataProvider` como nova origem de relacoes.

Destinos continuam limitados a:

- `Procedure`
- `WebPanel`

## Padroes aceitos

O incremento reaproveita as regras ja validadas na Fase 1:

- `procedure_direct_call`
- `procedure_dot_call`
- `webpanel_dot_link`

Toda relacao deve vir de `Source efetivo`, com evidencia de arquivo, linha, snippet, regra e confianca.

## Fora do incremento

- `Transaction`
- `WorkWithForWeb`
- `DataProvider` como destino
- `for each`
- `.Load(...)`
- actions estruturadas de `WorkWithForWeb`
- chamadas dinamicas
- inferencia por layout visual
- comentario como chamada efetiva

## Gate minimo

Antes de considerar este incremento pronto:

- os 15 casos reais da Fase 1 devem continuar passando
- deve existir bateria propria da Fase 2 para `DataProvider`
- a bateria deve incluir casos positivos de chamada de `Procedure`
- a bateria deve incluir casos positivos de `.Link(...)` para `WebPanel`
- a bateria deve incluir casos negativos de comentarios em `DataProvider`
- a validacao deve ser executada contra `FabricaBrasil` com `-FailOnValidationFailure`

## Decisoes adiaveis

As decisoes abaixo nao bloqueiam o primeiro incremento:

- nome final da skill futura
- politica de snapshots pequenos versionados
- estrategia definitiva para linha exata em XML com `CDATA`
- segundo alvo da Fase 2

O segundo alvo da Fase 2 so deve ser escolhido depois que `DataProvider` estiver validado e registrado.
