# Validacao KB Intelligence Fase 2 - DataProvider - FabricaBrasil

## Papel do documento
historico de validacao

## Nivel de confianca predominante
medio

## Data da rodada
2026-04-21

## Repositorio metodologico
`C:\Dev\Knowledge\GeneXus-XPZ-Skills`

## Pasta paralela usada como laboratorio
`C:\Dev\Prod\Gx_FabricaBrasil`

## Fonte XML
`C:\Dev\Prod\Gx_FabricaBrasil\ObjetosDaKbEmXml`

## Objetivo
Registrar a primeira ampliacao controlada da Fase 2 do KB Intelligence, adicionando `DataProvider` como origem de relacoes em `Source` efetivo.

## Escopo

Incluido nesta rodada:

- origem: `DataProvider`
- destinos: `Procedure` e `WebPanel`
- regras: `procedure_direct_call`, `procedure_dot_call` e `webpanel_dot_link`
- evidencia: `Source efetivo`

Continuam fora:

- `Transaction`
- `WorkWithForWeb`
- `DataProvider` como destino
- `for each`
- `.Load(...)`
- actions estruturadas de `WorkWithForWeb`
- chamadas dinamicas
- comentarios como chamada efetiva

## Comandos executados

Regressao dos 15 casos da Fase 1:

```powershell
.\scripts\New-KbIntelligenceIndex.ps1 `
  -SourceRoot "C:\Dev\Prod\Gx_FabricaBrasil\ObjetosDaKbEmXml" `
  -OutputPath ".\Temp\kb-intelligence-phase2-regression.sqlite" `
  -ValidationReportPath ".\Temp\kb-intelligence-phase2-regression-validation.json" `
  -ValidationCasesPath ".\scripts\kb-intelligence-fabricabrasil.phase1.validation-cases.json" `
  -FailOnValidationFailure
```

Validacao dos casos de `DataProvider`:

```powershell
.\scripts\New-KbIntelligenceIndex.ps1 `
  -SourceRoot "C:\Dev\Prod\Gx_FabricaBrasil\ObjetosDaKbEmXml" `
  -OutputPath ".\Temp\kb-intelligence-phase2.sqlite" `
  -ValidationReportPath ".\Temp\kb-intelligence-phase2-validation.json" `
  -ValidationCasesPath ".\scripts\kb-intelligence-fabricabrasil.phase2.validation-cases.json" `
  -FailOnValidationFailure
```

Geracao do indice canonico da pasta paralela:

```powershell
.\scripts\New-KbIntelligenceIndex.ps1 `
  -SourceRoot "C:\Dev\Prod\Gx_FabricaBrasil\ObjetosDaKbEmXml" `
  -OutputPath "C:\Dev\Prod\Gx_FabricaBrasil\KbIntelligence\kb-intelligence.sqlite" `
  -ValidationReportPath "C:\Dev\Prod\Gx_FabricaBrasil\KbIntelligence\kb-intelligence-validation.json" `
  -ValidationCasesPath ".\scripts\kb-intelligence-fabricabrasil.phase2.validation-cases.json" `
  -FailOnValidationFailure
```

## Resultado da geracao

- `Procedure` lidas: 2302
- `WebPanel` lidos: 1198
- `DataProvider` lidos: 24
- objetos gravados no SQLite: 3524
- relacoes gravadas: 19405
- casos de regressao da Fase 1: 15 `passed`
- casos de validacao da Fase 2: 8 `passed`

## Casos de validacao da Fase 2

A bateria propria de `DataProvider` cobriu:

- chamadas diretas de `Procedure` em expressoes de `DataProvider`
- chamada direta de `Procedure` em `where`
- `.Link(...)` para `WebPanel`
- `.Link(...)` para `WebPanel` com parametros
- referencia comentada a `Procedure` sem relacao direta
- referencia comentada a `WebPanel` sem relacao direta

## Consultas reais executadas

`object-info` para `DataProvider:dpFixoSidebarItems`:

- objeto localizado em `DataProvider/dpFixoSidebarItems.xml`
- 21 relacoes de saida

`what-uses` para `DataProvider:dpFixoSidebarItems`:

- retornou relacoes diretas para `WebPanel` por `webpanel_dot_link`

`who-uses` para `Procedure:procRecentLinksLoad`:

- retornou usos vindos de `DataProvider`, `Procedure` e `WebPanel`

`show-evidence` para `DataProvider:dpFixoSidebarItems` -> `WebPanel:WWEmbarqueSaida`:

- evidencia direta em `DataProvider/dpFixoSidebarItems.xml`, linha 159, por `webpanel_dot_link`

## Conclusao

O primeiro incremento da Fase 2 foi implementado e validado para `DataProvider` como origem, sem abrir `Transaction`, `WorkWithForWeb`, `for each` ou `.Load(...)`.

O segundo alvo da Fase 2 permanece pendente de decisao futura e nao deve ser iniciado sem nova escolha explicita.
