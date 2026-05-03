# KB Intelligence - Guia Metodologico para Agentes

## Papel do documento
guia operacional

## Nivel de confianca predominante
medio

## Depende de
scripts/README-kb-intelligence.md, 02-regras-operacionais-e-runtime.md, 08-guia-para-agente-gpt.md

## Usado por
agentes que precisem responder perguntas funcionais curtas ou de impacto tecnico usando o KB Intelligence como trilha de triagem, sem substituir a leitura do XML oficial

---

## Principio metodologico

O indice orienta a ordem de leitura. O XML oficial fecha a conclusao quando a pergunta depender de semantica GeneXus.

O KB Intelligence pode reduzir custo de busca, orientar a trilha de leitura e organizar evidencias, mas a resposta final depende de:

- evidencia direta do indice, quando existir
- leitura adicional do XML oficial, quando a pergunta exigir semantica GeneXus
- classificacao explicita do que e inferencia forte, inferencia fraca ou hipotese

---

## Checklist antes de responder

- confirmar a pasta paralela da KB em uso
- ler `README.md` e `AGENTS.md` locais quando entrar em uma pasta de KB diferente da raiz metodologica
- confirmar o objeto sempre por `tipo + nome`
- localizar `KbIntelligence\kb-intelligence.sqlite`
- tratar `KbIntelligence\kb-intelligence.sqlite` como artefato canonico derivado da pasta paralela da KB
- tratar o SQLite como indice derivado, nao como fonte normativa
- se a triagem funcional sugerir que o canonico esta defasado em relacao ao comportamento esperado, nao regenerar durante a propria investigacao
- tratar regeneracao do canonico como acao operacional separada, explicita e validada
- usar `ObjetosDaKbEmXml` como fonte normativa quando a pergunta depender de semantica GeneXus
- nao usar `ArquivoMorto`, salvo pedido explicito de analise historica
- nao tocar em `logs/` locais, salvo pedido explicito

---

## Ordem minima de triagem

1. executar `object-info` para confirmar existencia e caminho do objeto
2. se o nome ou tipo ainda estiver incerto, executar `search-objects`
3. executar `impact-basic` para obter dependentes e dependencias diretas
4. escolher apenas as relacoes que mudam a trilha de leitura
5. executar `show-evidence` nessas relacoes
6. abrir o XML oficial somente nos pontos necessarios
7. responder separando evidencia direta, leitura adicional, inferencia forte e hipotese

Para perguntas funcionais curtas, `functional-trace-basic` pode substituir os passos 1 a 5, mas a resposta final continua exigindo separacao explicita de evidencia e limite.

---

## Quando parar no indice

Parar no indice quando a pergunta pedir apenas:

- onde revisar primeiro
- quais objetos cercam tecnicamente um objeto
- qual relacao tecnica justifica abrir determinado XML
- qual trilha minima de leitura deve ser seguida

Nesses casos, declarar que se trata de triagem tecnica direta, nao de prova funcional completa.

## Quando abrir o XML oficial

Abrir o XML oficial quando a pergunta depender de:

- `Source` efetivo
- `Rules`
- `parm(...)`
- eventos
- formulas
- propriedades com efeito semantico
- cadeia imediata de chamadas
- tipo de variavel, `ATTCUSTOMTYPE`, BC, `SDT`, `Domain` ou `ExternalObject`
- interpretacao de efeito funcional, validacao, persistencia, navegacao ou regra de negocio

---

## Estrutura obrigatoria da resposta funcional

### Evidencia direta

Registrar somente o que veio do indice ou da evidencia armazenada:

- comando usado
- objeto origem e destino com `tipo + nome`
- arquivo relativo
- linha registrada
- regra de extracao
- trecho tecnico curto

### Leitura adicional do XML

Registrar o que foi confirmado no XML oficial:

- arquivo oficial lido
- trecho ou bloco consultado
- papel do trecho na investigacao
- limite do que a leitura confirmou

### Inferencia forte

Usar somente quando houver sinais convergentes:

- relacao tecnica direta no indice
- evidencia ancorada em linha
- XML oficial confirmando o contexto do trecho
- tipo ou variavel resolvida com seguranca

Mesmo nesses casos, nao transformar a inferencia em garantia runtime.

### Hipotese

Usar para o que ainda depende de leitura adicional, teste externo, build, execucao ou conhecimento funcional fora do recorte lido.

---

## Frases a evitar

- "o sistema certamente faz"
- "isso prova a regra de negocio"
- "o impacto funcional completo e"
- "basta olhar o indice"
- "nao precisa abrir o XML"
- "a procedure salva sempre"
- "o SDT e o payload completo"
- "a tela depende sempre dessa procedure"

## Frases preferidas

- "o indice mostra evidencia tecnica direta"
- "o XML oficial confirma este trecho"
- "a inferencia forte e"
- "permanece como hipotese"
- "para fechar a regra funcional completa, a leitura precisa seguir para"
- "isto e triagem tecnica, nao prova runtime completa"

---

## Exemplos sanitizados

Os exemplos abaixo usam nomes genericos de objetos GeneXus, sem referencia a KBs reais. Correspondencias com nomes reais de KB estao registradas em `GeneXus-XPZ-PrivateMap`.

### Exemplo 1 - Triagem de impacto tecnico antes de alterar uma Procedure

**Cenario:** o agente precisa avaliar o impacto de alterar `Procedure:procCalculaMovimentoEstoque` antes de modificar sua logica interna.

**Trilha minima:**

```powershell
# Passo 1: confirmar existencia
.\scripts\Query-KbIntelligenceIndex.ps1 `
  -IndexPath "...\KbIntelligence\kb-intelligence.sqlite" `
  -Query object-info `
  -ObjectType Procedure `
  -ObjectName procCalculaMovimentoEstoque `
  -Format text

# Passo 2: mapear impacto tecnico direto
.\scripts\Query-KbIntelligenceIndex.ps1 `
  -IndexPath "...\KbIntelligence\kb-intelligence.sqlite" `
  -Query impact-basic `
  -ObjectType Procedure `
  -ObjectName procCalculaMovimentoEstoque `
  -Limit 20 `
  -Format text
```

**Resultado esperado do `impact-basic`:**

- dependentes diretos: `WebPanel:wpConsultaMovimentos`, `DataProvider:dpResumoMovimentos`
- dependencias diretas: `Procedure:procRegistraLogOperacao`, `Transaction:TrnMovimento`

**Passo 3 (opcional): auditar relacao especifica**

```powershell
.\scripts\Query-KbIntelligenceIndex.ps1 `
  -IndexPath "...\KbIntelligence\kb-intelligence.sqlite" `
  -Query show-evidence `
  -SourceType WebPanel `
  -SourceName wpConsultaMovimentos `
  -TargetType Procedure `
  -TargetName procCalculaMovimentoEstoque `
  -Format text
```

**Resposta estruturada esperada:**

- Evidencia direta: chamada `procCalculaMovimentoEstoque.Call(...)` em `WebPanel/wpConsultaMovimentos.xml`, linha N, regra `procedure_dot_call`, confianca `direct`
- Leitura adicional do XML: abrir `Procedure/procCalculaMovimentoEstoque.xml` para revisar parametros e `Source` efetivo antes de alterar
- Inferencia forte: a alteracao pode afetar `wpConsultaMovimentos` e `dpResumoMovimentos`
- Hipotese: efeito em runtime depende da logica interna da procedure; nao confirmavel apenas pelo indice

---

### Exemplo 2 - Triagem funcional basica com `functional-trace-basic`

**Cenario:** o agente recebe pergunta funcional curta sobre `API:apiIntegracaoExterna` e precisa montar trilha inicial antes de abrir XML.

```powershell
.\scripts\Query-KbIntelligenceIndex.ps1 `
  -IndexPath "...\KbIntelligence\kb-intelligence.sqlite" `
  -Query functional-trace-basic `
  -ObjectType API `
  -ObjectName apiIntegracaoExterna `
  -Limit 20 `
  -Format text
```

**Resultado esperado:**

- objeto localizado: `API/apiIntegracaoExterna.xml`
- dependencias diretas resolvidas: `Procedure:procProcessaEntradaItem`, `SDT:sdtItemDadosBasicos`
- literais `CustomType` redundantes suprimidos quando ha relacao resolvida equivalente
- XMLs indicados para leitura: `API/apiIntegracaoExterna.xml`, `Procedure/procProcessaEntradaItem.xml`

**Resposta estruturada esperada:**

- Evidencia direta: relacoes tecnicas diretas retornadas pelo indice para `apiIntegracaoExterna`
- Leitura adicional do XML: abrir `API/apiIntegracaoExterna.xml` para revisar contrato da API e parametros; abrir `Procedure/procProcessaEntradaItem.xml` para verificar o que a procedure faz com os dados recebidos
- Inferencia forte: a API recebe entrada e delega processamento a `procProcessaEntradaItem`; o SDT `sdtItemDadosBasicos` e o tipo de dados trafegado
- Hipotese: persistencia, validacoes e regras de negocio dependem de leitura do `Source` efetivo das procedures; nao confirmavel apenas pelo indice

---

### Exemplo 3 - Objeto nao encontrado

**Cenario:** o agente consulta um objeto que nao existe no indice.

```powershell
.\scripts\Query-KbIntelligenceIndex.ps1 `
  -IndexPath "...\KbIntelligence\kb-intelligence.sqlite" `
  -Query object-info `
  -ObjectType Procedure `
  -ObjectName procNaoExisteNaKb `
  -Format text
```

**Resultado esperado:** falha clara com indicacao de que o objeto nao foi encontrado. Nao tentar localizar por heuristica fora do indice, nao buscar por nome parecido, nao varrer `ObjetosDaKbEmXml`.

**Resposta estruturada esperada:**

- Evidencia direta: objeto nao encontrado no indice
- Proximos passos: confirmar nome e tipo com o usuario; se o indice puder estar defasado, oferecer regeneracao

---

### Exemplo 4 - Terminologia: via edicao web versus via BC

Este exemplo registra a terminologia correta para descrever as duas formas de interacao com uma `Transaction` GeneXus.

**Via edicao web:** fluxo pelo formulario da transacao na IDE ou no runtime web. As `Rules` e `Events` com tag `[web]` se aplicam. O usuario (ou um WebPanel de entrada) salva, cancela ou edita o registro pela interface da propria transacao.

**Via BC (Business Component):** a `Transaction` e instanciada como Business Component por uma procedure ou outro objeto GeneXus. As chamadas `.Load(...)`, `.Save()`, `.Delete()`, `.Check()`, `.Insert()` e `.Update()` sao feitas programaticamente. As `Rules` com tag `[bc]` se aplicam.

**Quando usar cada termo na resposta:**

- ao descrever acoes do usuario (salvar formulario, cancelar registro, editar campo): usar "via edicao web"
- ao descrever chamadas feitas por procedures ou automacoes: usar "via BC"
- nao misturar os dois contextos na mesma afirmacao sem declarar explicitamente a qual contexto cada parte se refere

---

## Gate de qualidade da resposta

Antes de responder, confirmar:

- o objeto foi tratado por `tipo + nome`
- a evidencia direta nao foi misturada com inferencia
- a leitura do XML foi citada separadamente quando ocorreu
- toda conclusao funcional tem limite declarado
- hipoteses nao foram escritas como fatos
- o indice nao foi descrito como fonte normativa
- o XML oficial prevalece quando houver tensao interpretativa
