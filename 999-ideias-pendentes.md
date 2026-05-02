# Ideias Pendentes

## LlamaIndex / LangChain + vector store como alternativa ao indice SQLite atual

**Origem:** sugestao recebida em 2026-04-25 para exploracao futura.

### Problema concreto que motiva a ideia

Hoje o usuario GeneXus que trabalha com a pasta paralela via agente e obrigado a informar o nome exato do objeto que quer consultar. O custo de um agente varrer ate 15 mil arquivos XML do acervo em `ObjetosDaKbEmXml` sem um nome preciso e proibitivo — em tokens e em tempo. O indice SQLite mitiga isso com triagem estrutural, mas a busca continua dependendo de nome exato ou tipo conhecido.

O efeito pratico: o usuario que nao lembra o nome do objeto nao consegue explorar a KB de forma fluida; precisa saber o que procura antes de perguntar.

### Framework de orquestracao: LlamaIndex ou LangChain

Ambos resolvem o mesmo problema e suportam os mesmos vector stores (ChromaDB, Redis Stack). A escolha e de preferencia de ecossistema:

- **LlamaIndex**: especializado em indexacao e recuperacao de dados; API mais direta para RAG puro; escolha natural quando o unico objetivo e "indexar e buscar".
- **LangChain**: framework mais abrangente (agentes, chains, memoria, ferramentas, RAG); comunidade maior; util se o mesmo framework ja for usado em outras partes do projeto.

Para o caso especifico de indexar XMLs GeneXus e buscar por intencao funcional, ambos chegam no mesmo resultado.

### O que a camada vetorial resolveria

**Busca por intencao funcional**
Com embeddings vetoriais, uma pergunta como "qual procedure atualiza o saldo de estoque mensal?" localizaria o objeto correto mesmo sem o nome exato. O usuario descreveria o que precisa em linguagem natural e o agente encontraria os candidatos relevantes — invertendo a dependencia atual de nomenclatura precisa.

**Contexto recortado (chunking)**
Cada XML de objeto GeneXus pode ser extenso. Em vez de enviar o XML inteiro ao agente, o framework fatiaria em blocos logicos (`Source`, `Rules`, `Events`). A resposta usaria apenas os trechos realmente relevantes, reduzindo tokens e ruido.

**Custo de busca constante**
O vector store organiza vetores matematicamente. O custo de busca nao degrada com o crescimento do acervo.

### Opcoes de vector store

**ChromaDB**
Proposito unico, simples de instalar, disk-first por padrao. Boa opcao para comecar.

**Redis Stack**
Redis com modulo de busca vetorial (RediSearch / HNSW). Open source e gratuito. Nao tem versao nativa para Windows, mas roda sem custo via WSL2 ou Docker Desktop — ambos gratuitos e funcionais no Windows 11 Pro. Com 32 GB de RAM, o custo de memoria e irrelevante: os 15 mil XMLs da KB grande ocupam 180 MB em disco; os embeddings correspondentes ficam estimados em 200-300 MB de vetores (modelo de 1536 dimensoes, ~2,5 chunks por objeto). Redis tem vantagem em velocidade bruta por ser in-memory, e o LlamaIndex ja o suporta como backend nativo.

### Perguntas a responder antes de decidir

- Qual o custo de geracao dos embeddings para o acervo? Precisa de API externa ou modelo local funciona com qualidade suficiente?
- O ganho de descoberta por intencao compensa a complexidade de manter dois indices (SQLite estrutural + vetorial)?
- Adotar LlamaIndex/LangChain + vector store exigiria reescrever os wrappers locais (`Query-*KbIntelligence.ps1`, gate, etc.) em todas as pastas paralelas?
- O chunking por bloco logico do XML (`Source`, `Rules`, `Events`) e viavel dado o formato dos XMLs GeneXus?

## Baseline conhecido no sanity e na revisao de objeto legado

**Origem:** ideia discutida em 2026-04-29 e adiada para frente separada.

### Problema concreto que motiva a ideia

Hoje a trilha distingue bem `xmlWellFormed`, `sourceSanityStatus` e os gates minimos de `Source`, mas ainda nao expressa de forma curta e operacional a comparacao entre um delta novo e o XML oficial ja aceito do mesmo objeto.

Em objeto legado grande, isso gera ruido de decisao:

- warning antigo do baseline oficial pode ser lido como defeito novo do delta
- piora nova pode passar despercebida sob o argumento de que "o objeto ja era ruim"
- o agente pode misturar sanidade absoluta do XML com comparacao relativa contra o estado oficial anterior

### Ideia de melhoria

Adicionar, em frente separada, uma camada comparativa explicita e distinta do sanity absoluto, com saidas como:

- `same as official baseline`
- `worse than official baseline`
- `better than official baseline`
- `no official baseline compared`

Essa camada nao substituiria `xmlWellFormed`, `sourceSanityStatus` nem os gates metodologicos atuais. Ela serviria para comparar o delta com o baseline oficial quando houver XML oficial comparavel do mesmo objeto.

### Perguntas a responder antes de decidir

- O que exatamente conta como `official baseline` em cada fluxo: XML oficial atual em `ObjetosDaKbEmXml`, ultimo delta aceito, ou outro marco explicitamente documentado?
- A comparacao deve nascer primeiro como regra metodologica de handoff/revisao, ou ja como evolucao automatizada do `Test-GeneXusSourceSanity.ps1`?
- Como impedir que baseline ruim vire permissao implicita para aceitar piora nova?

## Wrapper compartilhado para auditoria de naming de `ObjetosDaKbEmXml`

**Origem:** avaliacao de sugestao de agente externo em 2026-05-01.

### Problema concreto que motiva a ideia

A verificacao de naming dos diretorios de container em `ObjetosDaKbEmXml` e executada hoje como procedimento narrado pelo agente seguindo o bloco `8.g2` da `xpz-kb-parallel-setup`. O fluxo esta bem especificado — cobre todos os diretorios sem excecao, exige leitura de pelo menos um XML por diretorio, mapeia o GUID de `Object/@type` para o nome canonico via catalogo e produz saida estruturada em tabela — mas depende de interpretacao local do agente a cada sessao.

O risco pratico nao e de ambiguidade na regra, mas de variancia entre execucoes: agentes distintos podem diferir na forma de localizar o XML, nomear as colunas da tabela ou reportar a evidencia, mesmo seguindo a mesma secao da skill.

### Ideia de melhoria

Adicionar ao motor compartilhado um script `Test-KbNamingAudit.ps1` que:

- receba como entrada o caminho de `ObjetosDaKbEmXml`
- liste todos os subdiretorios presentes
- leia pelo menos um XML por diretorio, extraia o elemento raiz ou `Object/@type`
- mapeie o GUID para o nome canonico usando o mesmo catalogo ja consumido por `Build-KbIntelligenceIndex.py`
- emita saida estruturada por diretorio com as colunas `Diretorio`, `Tipo real encontrado`, `Status` e, quando divergente, `Nome canonico esperado`
- retorne `NAMING_OK` quando todos os diretorios estiverem conformes ou `NAMING_DIVERGENTE: <lista>` quando houver inversao

O wrapper local de cada pasta paralela chamaria esse script e repassaria o resultado ao handoff, em vez de o agente executar o mapeamento inline.

### O que justificaria implementar agora vs. aguardar

O limiar de maturidade ainda nao foi atingido. O conjunto de tipos de container auditados e finito (Folder, Module, PackagedModule, Attribute) e o `8.g2.vii` ja tem criterio de parada curta bem definido. A implementacao faria sentido quando houver: (a) evidencia de handoffs superficiais recorrentes por variancia de execucao artesanal entre sessoes, ou (b) tres ou mais KBs paralelas ativas produzindo tabelas de naming inconsistentes.

### Perguntas a responder antes de decidir

- O catalogo de GUIDs em `01a-catalogo-e-padroes-empiricos.md` ja esta em formato consumivel por um script PowerShell, ou exigiria extracao adicional?
- O script deve ficar no motor compartilhado (ao lado de `Build-KbIntelligenceIndex.py`) ou como wrapper exemplo desta skill, seguindo o padrao dos `*.example.ps1`?
- A saida estruturada do script deve ser consumida diretamente pelo `Test-*KbSetupAudit.ps1` ou reportada separadamente no handoff?
- Como manter sincronia entre o catalogo de GUIDs e o mapeamento interno do script sem duplicar a fonte autoritativa?
