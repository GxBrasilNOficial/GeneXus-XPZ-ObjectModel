# 00 - Readme GeneXus XPZ XML

## Papel do documento
indice

## Nivel de confianca predominante
alto

## Depende de
09-historico-e-inventario-publico.md

## Usado por
toda a base consolidada

## Objetivo
Ser o ponto de entrada principal da base consolidada em ate 10 arquivos, com ordem de leitura, limites metodologicos e regras absolutas para uso por outro agente GPT.

## Fontes consolidadas
- 00-readme-genexus-xpz-xml.md
- 26-guia-para-agente-gpt.md

## Origem incorporada - 00-readme-genexus-xpz-xml.md

## Papel do documento
indice

## Nível de confiança predominante
alto

## Depende de
00-inventario-da-base-documental.md

## Usado por
toda a base; em especial 26-guia-para-agente-gpt.md

## Objetivo
Ser o ponto de entrada principal da base GeneXus/XPZ consolidada.
Explicar escopo, ordem de leitura e regras absolutas para qualquer agente GPT usar esta documentação com segurança.

## Objetivo da base documental

Organizar conhecimento operacional e empírico sobre XMLs extraídos de `XPZ` GeneXus 18, com foco em análise estrutural, clonagem conservadora de objetos e tomada de decisão prudente sobre geração ou aborto de tentativa.

## Escopo

- leitura de XMLs internos extraídos de `XPZ`
- análise estrutural de objetos GeneXus
- catálogos de `Object/@type` e `Part/@type` observados
- avaliação conservadora de risco, clonagem e necessidade de molde estrutural comparável
- envelope XPZ observado em export real da KB

## Camadas da base

### Conceitual

- `00-readme-genexus-xpz-xml.md`
- `06-padroes-de-objeto-e-nomenclatura.md`
- `09-historico-e-inventario-publico.md`

### Empírica

- `01-base-empirica-geral.md`
- `04-webpanel-familias-e-templates.md`
- `05-transaction-familias-e-templates.md`

### Operacional

- `02-regras-operacionais-e-runtime.md`
- `03-risco-e-decisao-por-tipo.md`
- `07-open-points-e-checklist.md`
- `08-guia-para-agente-gpt.md`

## Ordem recomendada de leitura

1. `00-readme-genexus-xpz-xml.md`
2. `01-base-empirica-geral.md`
3. `02-regras-operacionais-e-runtime.md`
4. `03-risco-e-decisao-por-tipo.md`
5. `04-webpanel-familias-e-templates.md`
6. `05-transaction-familias-e-templates.md`
7. `07-open-points-e-checklist.md`
8. `08-guia-para-agente-gpt.md`
9. `09-historico-e-inventario-publico.md`

## Regras absolutas para qualquer agente GPT

- nunca inventar `Part type`
- nunca assumir importação ou build sem teste externo
- sempre preferir clonagem conservadora
- abortar quando faltar molde estrutural comparável ou contexto estrutural
- não promover `Hipótese` a `Inferência forte`
- não promover `Inferência forte` a `Evidência direta`

## Fluxo operacional resumido

1. identificar o tipo do objeto
2. consultar risco em `03-risco-e-decisao-por-tipo.md`
3. consultar indícios de obrigatoriedade em `03-risco-e-decisao-por-tipo.md`
4. consultar regras operacionais e runtime em `02-regras-operacionais-e-runtime.md`
5. aplicar clonagem conservadora apenas se o contexto estrutural combinar
6. validar antes de qualquer empacotamento

## Sobre o XPZ observado

- `Evidência direta`: no export real inspecionado nesta trilha, o arquivo `.xpz` continha um unico XML principal com raiz `<ExportFile>`.
- `Evidência direta`: nesse envelope observado, os blocos de primeiro nivel foram `KMW`, `Source`, `KnowledgeBase`, `Objects`, `Attributes` e `Dependencies`.
- `Evidência direta`: o bloco `KMW` trouxe `MajorVersion`, `MinorVersion` e `Build`.
- `Inferência forte`: para geracao orientada por esta base, o agente deve pensar primeiro em `objeto <Object>` e depois em `envelope XPZ observado`, e nao em um suposto `Objects.xml` isolado sem prova local.
- `Inferência forte`: os detalhes executaveis desse envelope ficam centralizados em `02-regras-operacionais-e-runtime.md`.

## Limites atuais da base

- `Evidência direta`: a base deriva de XMLs extraídos e não de testes de importação documentados nesta trilha.
- `Inferência forte`: ela reduz tentativa e erro, mas ainda não valida comportamento de IDE, importação ou build.
- `Hipótese`: alguns padrões podem se repetir em outras KBs GeneXus 18, mas isso ainda precisa de validação externa.

## Dependencias entre documentos

- `01` e `02` fundamentam a leitura conceitual.
- `10`, `11`, `12` e `30` sustentam o material empírico.
- `20` a `25` transformam o material empírico em heurística operacional conservadora.
- `26` diz como um agente GPT deve consumir o conjunto.


## Origem incorporada - 26-guia-para-agente-gpt.md

## Papel do documento
operacional

## Nível de confiança predominante
médio

## Depende de
00-readme-genexus-xpz-xml.md, 01-base-empirica-geral.md, 02-regras-operacionais-e-runtime.md, 03-risco-e-decisao-por-tipo.md, 22-tipos-prontos-para-geracao-conservadora.md, 03-risco-e-decisao-por-tipo.md, 02-regras-operacionais-e-runtime.md

## Usado por
qualquer agente GPT que precise responder perguntas ou tomar decisão operacional usando esta base

## Objetivo
Explicar como um agente GPT deve consultar esta base documental e como responder com prudência.
Padronizar quando avançar, quando exigir molde estrutural comparável e quando abortar.

## Ordem de consulta recomendada

1. ler `00-readme-genexus-xpz-xml.md`
2. identificar o tipo alvo e checar `03-risco-e-decisao-por-tipo.md`
3. ler `03-risco-e-decisao-por-tipo.md`
4. ler `02-regras-operacionais-e-runtime.md`
5. ler `02-regras-operacionais-e-runtime.md`
6. usar `10`, `11`, `12` e `30` para sustentar qualquer detalhe empírico específico

## Quando responder com mais confiança

- quando a pergunta for descritiva e estiver diretamente sustentada pelos XMLs ou tabelas empíricas
- quando a resposta puder ser classificada como `Evidência direta`
- quando o tipo alvo já estiver bem mapeado por frequência e exemplos comparáveis

## Quando responder com cautela

- quando a conclusão depender de frequência recorrente, mas sem teste externo
- quando a amostra do tipo for pequena
- quando a resposta tocar em edição segura, obrigatoriedade real, importação ou build

## Quando recusar geração de XPZ

- quando faltar molde bruto comparável suficientemente próximo
- quando o tipo estiver em risco `alto` ou `muito alto` sem contexto equivalente, exceto nos fluxos ja destravados de `Transaction` e `WebPanel`
- quando houver `pattern`, `parent` ou bloco raro ainda não compreendido
- quando a pergunta exigir afirmar sucesso de importação/build sem evidência externa

## Regra de decisão entre gerar, exigir molde ou abortar

### Gerar por clonagem conservadora

- apenas em cenário muito controlado
- apenas com molde do mesmo tipo e contexto estrutural comparável
- apenas preservando `Object/@type`, `parent*`, `moduleGuid` e `Part type` recorrentes
- para `Transaction`, usar familia estrutural inferida da propria base
- para `WebPanel`, usar familia estrutural inferida e molde interno muito proximo

### Exigir molde bruto comparável

- quando o tipo estiver em cautela alta
- quando a amostra for pequena
- quando o objeto depender de contexto estrutural explícito
- `Transaction` nao deve mais exigir molde externo
- `WebPanel` deve operar por familia estrutural e molde interno proximo

### Abortar

- quando o molde não for comparável
- quando a mudança exigir mexer em blocos opacos ou raros
- quando a solicitação pressuponha algo que a base não prova

## Frases que um agente deve evitar

- “isso certamente importa”
- “isso é obrigatório” sem base comparativa explícita
- “pode gerar tranquilo”
- “vai buildar”
- “é seguro editar” sem qualificação de risco e nível de evidência

## Tipos em maior cautela

- `Transaction`
- `WebPanel`
- `WorkWithForWeb`
- `Procedure`
- `Panel`
- `DataProvider`

## Tipos que ainda pedem molde bruto muito próximo

- todos os tipos em risco `alto` ou `muito alto`, exceto os fluxos operacionais ja destravados para `Transaction` e `WebPanel`
- `DesignSystem`, por amostra pequena
- `SDT`, quando a estrutura pai for relevante
- `Theme` e `PackagedModule`, mesmo sendo candidatos relativamente menos agressivos

## Decisao operacional atual para Transaction e WebPanel

- Evidência direta: a base contem 183 `Transaction` e 1196 `WebPanel`.
- Inferência forte: esse volume e suficiente para que um agente GPT tente execucao controlada em vez de apenas bloquear por falta de evidencia.
- Inferência forte: `Transaction` pode seguir por padrao estrutural inferido e molde interno da propria base.
- Inferência forte: `WebPanel` pode seguir por familia estrutural, desde que o molde interno seja cuidadosamente escolhido.
- Inferência forte: nao pedir mais exemplos para esses tipos deixa de ser regra geral; so faz sentido pedir novos exemplos quando o caso concreto continuar estruturalmente ambiguo.
- Hipótese: se a importacao falhar, o caso deve voltar como insumo para evoluir a propria base documental.

## Fórmula de resposta recomendada

1. classificar a afirmação como `Evidência direta`, `Inferência forte` ou `Hipótese`
2. citar o arquivo-base usado
3. declarar a limitação
4. recomendar próximo passo conservador

## Regras de materializacao

- Evidência direta: ao gerar `Transaction` ou `WebPanel`, o agente deve usar um molde XML completo
- Evidência direta: o agente nao deve materializar objeto final a partir de markdown ou exemplo sanitizado

### Transaction

- localizar um XML bruto do mesmo `Object/@type` e da familia estrutural mais proxima
- preservar `Object/@type`, `guid`, `parent*`, `moduleGuid`, `Part type` e ordem das `Part`
- editar somente nomes, descricoes e trechos internos sustentados pelo molde bruto
- abortar se a mudanca exigir criar atributo novo no `<Object>` ou bloco novo sem paralelo bruto

### WebPanel

- identificar primeiro a familia estrutural usando `04-webpanel-familias-e-templates.md`
- selecionar um molde bruto interno da mesma familia; nao usar um resumo textual como fonte final
- preservar `layout`, `events`, `variables`, `Part type`, controles e bindings do molde-base
- abortar se a familia nao estiver clara ou se o alvo exigir `grid`, `tab`, componente customizado ou contexto de `parent` ausente no bruto escolhido

## Regras de serializacao XPZ

- o objeto clonado deve continuar como XML bem-formado com raiz unica `<Object>`
- blocos `Source` e `InnerHtml` que vierem em `CDATA` devem permanecer em `CDATA`
- o agente deve incluir o objeto em `<Objects>` somente por clonagem de um envelope XPZ bruto real; se nao houver envelope bruto, deve recusar a serializacao final
- antes de empacotar, validar parse XML, presenca de todos os `Part type` recorrentes e coerencia entre objeto clonado e molde-base
- o agente nao deve afirmar “sem erro de importacao”; deve afirmar apenas que seguiu a especificacao mais conservadora disponivel

## Regras de fonte

- Fonte valida: XML bruto de objeto e envelope XPZ bruto real
- Fonte invalida: markdown desta base
- Fonte invalida: exemplos sanitizados incompletos de `04-webpanel-familias-e-templates.md`
- Fonte invalida: reconstrucoes livres baseadas em tabelas, frequencias ou descricoes
- Inferência forte: esta base documental decide, classifica e orienta; quem materializa e serializa e sempre o XML bruto comparavel





