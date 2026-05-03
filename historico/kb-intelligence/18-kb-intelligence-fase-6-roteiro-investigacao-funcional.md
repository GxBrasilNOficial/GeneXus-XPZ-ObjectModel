# 18 - KB Intelligence Fase 6 - Roteiro de Investigacao Funcional

## Papel do documento
guia operacional

## Nivel de confianca predominante
baixo a medio

## Depende de
17-kb-intelligence-fase-6-contrato.md, 14-kb-intelligence-fase-3-contrato.md, 08-guia-para-agente-gpt.md, scripts/README-kb-intelligence.md

## Usado por
agentes que precisem responder perguntas funcionais com apoio do KB Intelligence sem confundir triagem tecnica com prova funcional

## Objetivo
Oferecer um roteiro curto e repetivel para investigar perguntas funcionais com apoio do indice tecnico, reduzindo custo de busca sem substituir a leitura do XML oficial.

## Principio do roteiro

O indice orienta a ordem de leitura.

O XML oficial fecha a conclusao quando a pergunta depender de semantica GeneXus.

## Classificacao obrigatoria da resposta

Toda resposta funcional guiada por este roteiro deve separar, quando aplicavel:

- `Evidencia direta`: o que veio diretamente do indice e da evidencia armazenada
- `Leitura adicional do XML`: o que foi confirmado no `ObjetosDaKbEmXml`
- `Inferencia forte`: conclusao provavel sustentada por mais de um sinal convergente
- `Hipotese`: possibilidade ainda aberta que nao pode ser tratada como fato

## Fluxo minimo

1. identificar o objeto principal por `tipo + nome`
2. consultar `object-info` ou `search-objects` para confirmar existencia e arquivo
3. consultar `impact-basic` para mapear dependencias e dependentes tecnicos diretos
4. usar `show-evidence` nas relacoes que realmente mudam a trilha de leitura
5. decidir se a pergunta ja pode ser respondida tecnicamente ou se exige leitura do XML oficial
6. abrir o XML oficial apenas nos pontos necessarios
7. responder classificando explicitamente o grau da conclusao

## Quando parar no indice

Parar no indice e responder apenas com triagem tecnica quando a pergunta for do tipo:

- quais objetos parecem participar do efeito
- onde revisar primeiro
- quais dependencias diretas cercam o objeto
- qual relacao tecnica justificou abrir determinado XML

Nesses casos, nao inventar explicacao funcional completa.

## Quando abrir o XML oficial

Abrir o XML oficial quando a pergunta depender de:

- `Source` efetivo
- `Rules`
- `parm(...)`
- formulas
- eventos
- propriedades que alterem semantica
- cadeia imediata de chamadas ou de tipos

## Perguntas-modelo que este roteiro suporta

- "se eu alterar este objeto, onde devo revisar primeiro?"
- "quais objetos parecem participar desta regra?"
- "ha indicio tecnico de que este fluxo passa por esta procedure?"
- "qual e a menor cadeia de leitura para validar esta suspeita?"

## Perguntas que este roteiro ainda nao fecha sozinho

- "qual e a regra de negocio completa?"
- "qual e o comportamento runtime garantido?"
- "qual e o fluxo funcional inteiro do modulo?"
- "o sistema certamente faz X em todos os cenarios?"

Nesses casos, o agente deve reduzir escopo, abrir XML adicional ou declarar limite metodologico.

## Exemplo de estrutura de resposta

### Evidencia direta

- `impact-basic` indicou dependencias diretas relevantes
- `show-evidence` confirmou a relacao tecnica que motivou a leitura

### Leitura adicional do XML

- o `Source` ou a propriedade aberta no XML confirmou o ponto funcional necessario

### Inferencia forte

- existe um sinal convergente razoavel, mas ainda nao ha prova runtime completa

### Hipotese

- permanece uma possibilidade que exigiria leitura adicional ou teste externo

## Saida desejada

O agente deve produzir respostas curtas, rastreaveis e honestas sobre limite de confianca.

O ganho esperado da Fase 6 nao e "adivinhar funcionalidade", mas reduzir o custo para chegar ao trecho certo do XML oficial.

Exemplos curtos desse uso ficam em `19-kb-intelligence-fase-6-exemplos-investigacao-funcional.md`.
