# 17 - KB Intelligence Fase 6 - Contrato

## Papel do documento
contrato operacional

## Nivel de confianca predominante
baixo a medio

## Depende de
11-plano-kb-intelligence-incremental.md, 14-kb-intelligence-fase-3-contrato.md, 16-kb-intelligence-fase-5-contrato.md, scripts/README-kb-intelligence.md, 08-guia-para-agente-gpt.md

## Usado por
agentes que forem desenhar ou implementar suporte funcional por agentes sobre o KB Intelligence depois da consolidacao tecnica das fases anteriores

## Objetivo
Definir a Fase 6 do KB Intelligence como camada de suporte funcional assistido por agentes, baseada no indice tecnico ja validado e nas consultas operacionais existentes.

A Fase 6 deve ajudar o agente a responder perguntas funcionais mais amplas com custo menor de triagem, sem transformar o indice tecnico em fonte normativa, sem prometer prova funcional completa e sem apagar a separacao entre evidencia direta, leitura do XML oficial e inferencia.

## Principio da Fase 6

Suporte funcional nao nasce de relacao tecnica isolada.

O KB Intelligence pode reduzir custo de busca, orientar a trilha de leitura e organizar evidencias, mas a resposta funcional final continua dependendo de:

- evidencia direta do indice, quando existir
- leitura adicional do XML oficial, quando a pergunta exigir semantica GeneXus
- classificacao explicita do que e inferencia forte, inferencia fraca ou hipotese

## Escopo aceito da Fase 6

### Uso do indice como trilha de triagem

A Fase 6 pode combinar:

- `search-objects`
- `object-info`
- `who-uses`
- `what-uses`
- `show-evidence`
- `impact-basic`

para montar uma trilha curta de investigacao antes da leitura do XML oficial.

### Saida esperada para o agente

A resposta do agente na Fase 6 deve, quando aplicavel:

- localizar o objeto principal consultado
- indicar dependencias e dependentes tecnicos diretos relevantes
- apontar a evidencia tecnica que motivou a leitura adicional
- separar `Evidencia direta`, `Leitura adicional do XML`, `Inferencia forte` e `Hipotese`
- declarar explicitamente quando a pergunta funcional nao puder ser fechada apenas pelo indice

### Tipos de pergunta que a Fase 6 pode apoiar

- onde revisar primeiro para entender efeito tecnico de uma alteracao
- quais objetos parecem participar de um fluxo ou regra
- qual cadeia minima de leitura deve ser aberta no XML oficial
- quais evidencias sustentam ou enfraquecem uma suspeita funcional

## Fora do escopo da Fase 6

- responder funcionalidade ampla apenas com base no SQLite
- prometer comportamento runtime completo
- inferir regra de negocio sem indicar a base da inferencia
- substituir leitura de `Source`, `Rules`, formulas, eventos ou propriedades relevantes no XML oficial
- criar chat, RAG ou base narrativa extensa para humanos como entrega inicial
- alterar a fonte normativa `ObjetosDaKbEmXml`
- abrir novas relacoes semanticas da Fase 5 sem contrato proprio

## Regra de precedencia

- o indice tecnico continua sendo artefato derivado e orientador
- `ObjetosDaKbEmXml` continua sendo a fonte normativa
- quando o indice e o XML oficial parecerem tensionar a interpretacao, o XML oficial prevalece
- quando a resposta depender de semantica GeneXus nao coberta por evidencia direta do indice, o agente deve abrir o XML oficial antes de concluir

## Gate minimo

A Fase 6 so deve ser considerada aberta de forma util quando:

- a Fase 3 estiver operacional e estavel
- a Fase 5 estiver consolidada ou explicitamente encerrada para o recorte em questao
- o guia de uso por agentes separar claramente triagem tecnica e conclusao funcional
- houver pelo menos um fluxo de investigacao funcional pequeno documentado e rastreavel

## Artefatos esperados para abertura

- este contrato
- ajuste do plano mestre para apontar a abertura da Fase 6
- ajuste do guia operacional do agente para classificar evidencias na leitura funcional

## Primeiras entregas recomendadas

- um roteiro de investigacao funcional curta, ainda sem automacao nova
- exemplos pequenos de perguntas funcionais respondidas com trilha de evidencias
- decisao explicita sobre abrir ou nao uma skill futura especifica de KB Intelligence

O roteiro inicial desta fase deve ficar documentado em `18-kb-intelligence-fase-6-roteiro-investigacao-funcional.md`.

## Relacao com as fases anteriores

- a Fase 3 fornece as consultas operacionais base
- a Fase 4 garante inventario amplo de objetos
- a Fase 5 amplia as relacoes tecnicas para enriquecer a triagem

A Fase 6 deve consumir essas camadas, nao tentar misturar seus papeis.
