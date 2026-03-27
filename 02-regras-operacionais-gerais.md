# 02 - Regras Operacionais Gerais

## Papel do documento
operacional

## Nivel de confianca predominante
medio

## Depende de
01-base-empirica-geral.md, 03-risco-e-decisao-por-tipo.md

## Usado por
04-webpanel-familias-e-templates.md, 05-transaction-familias-e-templates.md, 08-guia-para-agente-gpt.md

## Objetivo
Consolidar regras de geracao, clonagem conservadora, materializacao, serializacao XPZ e validacoes minimas para execucao controlada.

## Fontes consolidadas
- 02-genexus-xpz-generation-rules.md
- 20-guia-de-clonagem-segura.md
- 24-resumo-operacional-para-gerador-xpz.md

## Origem incorporada - 02-genexus-xpz-generation-rules.md

## Papel do documento
operacional

## Nível de confiança predominante
médio

## Depende de
01-genexus-xpz-research.md, 22-tipos-prontos-para-geracao-conservadora.md, 23-mapa-de-risco-por-tipo.md, 24-resumo-operacional-para-gerador-xpz.md

## Usado por
20-guia-de-clonagem-segura.md, 24-resumo-operacional-para-gerador-xpz.md, 26-guia-para-agente-gpt.md

## Objetivo
Registrar regras conservadoras para qualquer tentativa futura de geração de XPZ.
Explicitar o que a base já sustenta e o que ainda permanece apenas heurístico.

## Premissa

Este arquivo não assume que a geração sintética de `XPZ` já esteja provada para qualquer cenário. Ele traduz apenas o que pode ser sustentado pelo inventário bruto e pelos XMLs extraídos desta KB.

## Regras com classificação explícita

### Regra 1

- `Evidência direta`: os objetos extraídos são compostos por um nó `<Object ...>` com metadados e, em muitos casos, múltiplos blocos `<Part type="...">`.
- `Inferência forte`: qualquer geração futura de `XPZ` deve preservar essa forma básica por objeto, em vez de tentar reduzir tudo a um XML simplificado de campos soltos.

### Regra 2

- `Evidência direta`: objetos do mesmo diretório extraído compartilham o mesmo GUID em `Object/@type`.
- `Inferência forte`: ao gerar objetos, o `Object/@type` precisa ser coerente com o grupo/tipo que se deseja representar.
- `Hipótese`: um `Object/@type` incorreto pode até importar em alguns cenários, mas a chance de inconsistência estrutural é alta.

### Regra 3

- `Evidência direta`: vários objetos dependem de `parent`, `parentGuid`, `parentType` e `moduleGuid`.
- `Inferência forte`: uma geração segura deve manter esses vínculos quando o objeto observado os utiliza.
- `Hipótese`: omitir esses vínculos pode causar importação parcial, reposicionamento inesperado na KB ou perda de associação lógica.

### Regra 4

- `Evidência direta`: o acervo mostra conjuntos recorrentes de `Part type` por grupo como `Procedure`, `WebPanel`, `Transaction`, `SDT` e `SubTypeGroup`.
- `Inferência forte`: a geração deve partir de objetos-modelo reais do mesmo tipo, e não de um conjunto de `Part type` inventado.

### Regra 5

- `Evidência direta`: `WorkWithForWeb` contém `parentType` apontando para `Transaction` e carrega `<Data Pattern="...">`.
- `Inferência forte`: objetos gerados por pattern parecem depender mais do contexto do objeto pai do que objetos isolados como `Domain` simples.
- `Hipótese`: gerar pattern objects sem o contexto correspondente pode resultar em imports frágeis ou semanticamente incompletos.

### Regra 6

- `Evidência direta`: o inventário bruto trabalha no nível de objeto extraído, sem registrar alterações globais de KB, versão ou ambiente.
- `Inferência forte`: uma política conservadora de geração deve priorizar pacotes focados em objetos, evitando expandir o escopo para metadados globais sem necessidade comprovada.
- `Hipótese`: esse recorte mínimo tende a reduzir efeito colateral, mas isso ainda precisa de teste de importação controlado.

### Regra 7

- `Evidência direta`: o inventário atual conseguiu ler `7219` XMLs sem erros estruturais.
- `Inferência forte`: antes de empacotar qualquer geração, é razoável exigir ao menos XML bem-formado e consistência interna dos atributos observados.
- `Hipótese`: uma validação adicional por diff estrutural contra objetos-modelo do mesmo tipo deve aumentar a taxa de sucesso de importação.

## Política prática sugerida

- `Inferência forte`: para um primeiro gerador, começar pelos tipos com estrutura mais legível no acervo, como `Domain`, `SDT`, `Procedure` e talvez `WebPanel` simples.
- `Inferência forte`: tratar `Transaction`, `WorkWithForWeb`, `ThemeClass`, `SubTypeGroup` e objetos de pattern como classes de maior risco estrutural.
- `Hipótese`: objetos com menos `Part type`, menos relacionamentos aparentes e menos dependência de pattern devem ser os melhores candidatos iniciais para geração automatizada.

## O que este acervo ainda não prova

- `Evidência direta`: o inventário bruto não registra testes de importação, build ou execução.
- `Hipótese`: portanto, qualquer regra de geração aqui ainda é preparatória e não conclusiva.


## Origem incorporada - 20-guia-de-clonagem-segura.md

## Papel do documento
operacional

## Nível de confiança predominante
médio

## Depende de
10-matriz-part-types-por-tipo.md, 11-campos-estaveis-vs-variaveis.md, 12-diffs-estruturais-por-tipo.md, 23-mapa-de-risco-por-tipo.md

## Usado por
24-resumo-operacional-para-gerador-xpz.md, 26-guia-para-agente-gpt.md

## Objetivo
Traduzir a análise empírica em orientação prudente para clonagem conservadora de objetos.
Indicar o que preservar, o que merece template real e onde o risco cresce.

Este guia e operacional, mas conservador.

- Evidência direta: ele se baseia em recorrencia de atributos, Part type, parent/module e blocos textuais observados.
- Inferência forte: pode alterar aqui significa bom candidato para clonagem controlada, nao garantia de importacao.

## API

- Evidência direta: template recomendado: escolher objeto do mesmo diretório e mesmo Object/@type = 36e32e2d-023e-4188-95df-d13573bac2e0.
- Inferência forte: preservar guid, type, parent* e moduleGuid ate entender explicitamente a mudanca desejada.
- Inferência forte: blocos com Source, nomes e descricoes textuais sao candidatos mais plausiveis para edicao controlada quando aparecem de forma recorrente.
- Hipótese: blocos raros ou quase sempre vazios podem ser estruturais/reservados e merecem template real antes de alteracao.
- Nivel de confianca atual da clonagem: baixo.
- Evidência direta: Part type mais recorrentes: 9f577ec2-27f4-4cf4-8ad5-f3f50c9d69b5; ad3ca970-19d0-44e1-a7b7-db05556e820c; babf62c5-0111-49e9-a1c3-cc004d90900a; c44bd5ff-f918-415b-98e6-aca44fed84fa; e4c4ade7-53f0-4a56-bdfd-843735b66f47.
- Evidência direta: objetos com parent: 1/1; com pattern: 0/1.

## DataProvider

- Evidência direta: template recomendado: escolher objeto do mesmo diretório e mesmo Object/@type = 2a9e9aba-d2de-4801-ae7f-5e3819222daf.
- Inferência forte: preservar guid, type, parent* e moduleGuid ate entender explicitamente a mudanca desejada.
- Inferência forte: blocos com Source, nomes e descricoes textuais sao candidatos mais plausiveis para edicao controlada quando aparecem de forma recorrente.
- Hipótese: blocos raros ou quase sempre vazios podem ser estruturais/reservados e merecem template real antes de alteracao.
- Nivel de confianca atual da clonagem: baixo.
- Evidência direta: Part type mais recorrentes: 1d8aeb5a-6e98-45a7-92d2-d8de7384e432; 9b0a32a3-de6d-4be1-a4dd-1b85d3741534; ad3ca970-19d0-44e1-a7b7-db05556e820c; babf62c5-0111-49e9-a1c3-cc004d90900a; e4c4ade7-53f0-4a56-bdfd-843735b66f47.
- Evidência direta: objetos com parent: 24/24; com pattern: 0/24.

## DesignSystem

- Evidência direta: template recomendado: escolher objeto do mesmo diretório e mesmo Object/@type = 78b3fa0e-174c-4b2b-8716-718167a428b5.
- Inferência forte: preservar guid, type, parent* e moduleGuid ate entender explicitamente a mudanca desejada.
- Inferência forte: blocos com Source, nomes e descricoes textuais sao candidatos mais plausiveis para edicao controlada quando aparecem de forma recorrente.
- Hipótese: blocos raros ou quase sempre vazios podem ser estruturais/reservados e merecem template real antes de alteracao.
- Nivel de confianca atual da clonagem: medio.
- Evidência direta: Part type mais recorrentes: 36982745-cb77-47a3-bc04-9d0d764ff532; 75e52d99-6edd-4bad-a1d7-dcc9b7f000ef; babf62c5-0111-49e9-a1c3-cc004d90900a; c6b14574-4f5f-4e35-aaa7-e322e88a9a10.
- Evidência direta: objetos com parent: 1/2; com pattern: 0/2.

## PackagedModule

- Evidência direta: template recomendado: escolher objeto do mesmo diretório e mesmo Object/@type = c88fffcd-b6f8-0000-8fec-00b5497e2117.
- Inferência forte: preservar guid, type, parent* e moduleGuid ate entender explicitamente a mudanca desejada.
- Inferência forte: blocos com Source, nomes e descricoes textuais sao candidatos mais plausiveis para edicao controlada quando aparecem de forma recorrente.
- Hipótese: blocos raros ou quase sempre vazios podem ser estruturais/reservados e merecem template real antes de alteracao.
- Nivel de confianca atual da clonagem: alto.
- Evidência direta: Part type mais recorrentes: babf62c5-0111-49e9-a1c3-cc004d90900a; ed1b7b1c-2aaf-46eb-9ec5-db348f6fa3fc; a5e6a251-2df0-44d8-adab-1da237574326.
- Evidência direta: objetos com parent: 2/16; com pattern: 0/16.

## Panel

- Evidência direta: template recomendado: escolher objeto do mesmo diretório e mesmo Object/@type = d82625fd-5892-40b0-99c9-5c8559c197fc.
- Inferência forte: preservar guid, type, parent* e moduleGuid ate entender explicitamente a mudanca desejada.
- Inferência forte: blocos com Source, nomes e descricoes textuais sao candidatos mais plausiveis para edicao controlada quando aparecem de forma recorrente.
- Hipótese: blocos raros ou quase sempre vazios podem ser estruturais/reservados e merecem template real antes de alteracao.
- Nivel de confianca atual da clonagem: baixo.
- Evidência direta: Part type mais recorrentes: b4378a97-f9b2-4e05-b2f8-c610de258402; babf62c5-0111-49e9-a1c3-cc004d90900a.
- Evidência direta: objetos com parent: 7/7; com pattern: 7/7.

## Procedure

- Evidência direta: template recomendado: escolher objeto do mesmo diretório e mesmo Object/@type = 84a12160-f59b-4ad7-a683-ea4481ac23e9.
- Inferência forte: preservar guid, type, parent* e moduleGuid ate entender explicitamente a mudanca desejada.
- Inferência forte: blocos com Source, nomes e descricoes textuais sao candidatos mais plausiveis para edicao controlada quando aparecem de forma recorrente.
- Hipótese: blocos raros ou quase sempre vazios podem ser estruturais/reservados e merecem template real antes de alteracao.
- Nivel de confianca atual da clonagem: baixo.
- Evidência direta: Part type mais recorrentes: 528d1c06-a9c2-420d-bd35-21dca83f12ff; 763f0d8b-d8ac-4db4-8dd4-de8979f2b5b9; 9b0a32a3-de6d-4be1-a4dd-1b85d3741534; ad3ca970-19d0-44e1-a7b7-db05556e820c; babf62c5-0111-49e9-a1c3-cc004d90900a; c414ed00-8cc4-4f44-8820-4baf93547173.
- Evidência direta: objetos com parent: 2281/2281; com pattern: 0/2281.

## SDT

- Evidência direta: template recomendado: escolher objeto do mesmo diretório e mesmo Object/@type = 447527b5-9210-4523-898b-5dccb17be60a.
- Inferência forte: preservar guid, type, parent* e moduleGuid ate entender explicitamente a mudanca desejada.
- Inferência forte: blocos com Source, nomes e descricoes textuais sao candidatos mais plausiveis para edicao controlada quando aparecem de forma recorrente.
- Hipótese: blocos raros ou quase sempre vazios podem ser estruturais/reservados e merecem template real antes de alteracao.
- Nivel de confianca atual da clonagem: baixo.
- Evidência direta: Part type mais recorrentes: 5c2aa9da-8fc4-4b6b-ae02-8db4fa48976a; babf62c5-0111-49e9-a1c3-cc004d90900a.
- Evidência direta: objetos com parent: 591/594; com pattern: 0/594.

## Theme

- Evidência direta: template recomendado: escolher objeto do mesmo diretório e mesmo Object/@type = c804fdbd-7c0b-440d-8527-4316c92649a6.
- Inferência forte: preservar guid, type, parent* e moduleGuid ate entender explicitamente a mudanca desejada.
- Inferência forte: blocos com Source, nomes e descricoes textuais sao candidatos mais plausiveis para edicao controlada quando aparecem de forma recorrente.
- Hipótese: blocos raros ou quase sempre vazios podem ser estruturais/reservados e merecem template real antes de alteracao.
- Nivel de confianca atual da clonagem: alto.
- Evidência direta: Part type mais recorrentes: 43b86e51-163f-44af-ac5a-e101541b1a71; babf62c5-0111-49e9-a1c3-cc004d90900a; c31007a6-01d3-4788-95b3-425921d47758.
- Evidência direta: objetos com parent: 0/7; com pattern: 0/7.

## Transaction

- Evidência direta: template recomendado: escolher objeto do mesmo diretório e mesmo Object/@type = 1db606f2-af09-4cf9-a3b5-b481519d28f6.
- Inferência forte: preservar guid, type, parent* e moduleGuid ate entender explicitamente a mudanca desejada.
- Inferência forte: blocos com Source, nomes e descricoes textuais sao candidatos mais plausiveis para edicao controlada quando aparecem de forma recorrente.
- Hipótese: blocos raros ou quase sempre vazios podem ser estruturais/reservados e merecem template real antes de alteracao.
- Nivel de confianca atual da clonagem: baixo.
- Evidência direta: Part type mais recorrentes: 264be5fb-1b28-4b25-a598-6ca900dd059f; 4c28dfb9-f83b-46f0-9cf3-f7e090b525d5; 9b0a32a3-de6d-4be1-a4dd-1b85d3741534; ad3ca970-19d0-44e1-a7b7-db05556e820c; babf62c5-0111-49e9-a1c3-cc004d90900a; c44bd5ff-f918-415b-98e6-aca44fed84fa.
- Evidência direta: objetos com parent: 183/183; com pattern: 0/183.

## WebPanel

- Evidência direta: template recomendado: escolher objeto do mesmo diretório e mesmo Object/@type = c9584656-94b6-4ccd-890f-332d11fc2c25.
- Inferência forte: preservar guid, type, parent* e moduleGuid ate entender explicitamente a mudanca desejada.
- Inferência forte: blocos com Source, nomes e descricoes textuais sao candidatos mais plausiveis para edicao controlada quando aparecem de forma recorrente.
- Hipótese: blocos raros ou quase sempre vazios podem ser estruturais/reservados e merecem template real antes de alteracao.
- Nivel de confianca atual da clonagem: baixo.
- Evidência direta: Part type mais recorrentes: 763f0d8b-d8ac-4db4-8dd4-de8979f2b5b9; 9b0a32a3-de6d-4be1-a4dd-1b85d3741534; ad3ca970-19d0-44e1-a7b7-db05556e820c; babf62c5-0111-49e9-a1c3-cc004d90900a; c44bd5ff-f918-415b-98e6-aca44fed84fa; d24a58ad-57ba-41b7-9e6e-eaca3543c778.
- Evidência direta: objetos com parent: 1195/1196; com pattern: 0/1196.

## WorkWithForWeb

- Evidência direta: template recomendado: escolher objeto do mesmo diretório e mesmo Object/@type = 78cecefe-be7d-4980-86ce-8d6e91fba04b.
- Inferência forte: preservar guid, type, parent* e moduleGuid ate entender explicitamente a mudanca desejada.
- Inferência forte: blocos com Source, nomes e descricoes textuais sao candidatos mais plausiveis para edicao controlada quando aparecem de forma recorrente.
- Hipótese: blocos raros ou quase sempre vazios podem ser estruturais/reservados e merecem template real antes de alteracao.
- Nivel de confianca atual da clonagem: baixo.
- Evidência direta: Part type mais recorrentes: a51ced48-7bee-0001-ab12-04e9e32123d1; babf62c5-0111-49e9-a1c3-cc004d90900a.
- Evidência direta: objetos com parent: 183/183; com pattern: 183/183.



## Origem incorporada - 24-resumo-operacional-para-gerador-xpz.md

## Papel do documento
operacional

## Nível de confiança predominante
médio

## Depende de
20-guia-de-clonagem-segura.md, 21-indicios-de-obrigatoriedade.md, 22-tipos-prontos-para-geracao-conservadora.md, 23-mapa-de-risco-por-tipo.md

## Usado por
02-genexus-xpz-generation-rules.md, 26-guia-para-agente-gpt.md

## Objetivo
Concentrar as instruções práticas mais curtas para um gerador GPT orientado por clonagem conservadora.
Funcionar como resumo decisório sem esconder os limites da evidência.

## Premissa

- Evidência direta: este resumo deriva apenas do acervo XML extraído e dos relatórios `10` a `16`.
- Inferência forte: ele serve para reduzir tentativa e erro por clonagem conservadora.
- Hipótese: ele nao substitui validacao real por importacao, abertura na IDE e build.

## Algoritmo sugerido de geracao por clonagem

1. Escolher o tipo alvo e localizar um template real do mesmo diretório e do mesmo `Object/@type`.
2. Preferir template do mesmo contexto estrutural do alvo:
   mesmo uso de `parent`, mesmo uso de `pattern`, mesma familia de objeto.
3. Preservar integralmente `Object/@type`, `guid`, `parent`, `parentGuid`, `parentType`, `moduleGuid` e todos os `Part type` recorrentes do template.
4. Alterar primeiro apenas nomes, descricoes e blocos textuais claramente recorrentes.
5. Rejeitar a clonagem se surgir qualquer bloco raro, opaco ou ausente no template comparavel.
6. So empacotar depois de validar XML bem-formado e diff estrutural contra o template-base.

## Quando abortar a geracao

- Inferência forte: abortar quando o tipo estiver em risco `alto` ou `muito alto` e nao houver template suficientemente proximo.
- Inferência forte: abortar quando o objeto alvo exigir `pattern` ou contexto de `parent` nao representado no template.
- Inferência forte: abortar quando o template comparavel tiver mais de um bloco raro/exclusivo que ainda nao foi entendido.
- Hipótese: abortar tambem quando a mudanca pretendida exigir alterar blocos nao textuais pouco recorrentes.

## Quando exigir template real

- Evidência direta: exigir template real muito proximo para `API`, `DataProvider`, `Panel`, `Procedure` e `WorkWithForWeb`.
- Evidência direta: exigir template real tambem para `DesignSystem`, por causa da amostra muito pequena.
- Inferência forte: para `SDT`, `Theme` e `PackagedModule`, um template real proximo continua sendo a opcao mais segura, mesmo quando a estrutura pareca menos agressiva.

## Politica para Transaction

- Evidência direta: existem 183 `Transaction` no acervo.
- Inferência forte: usar padrao estrutural inferido da propria base em vez de bloquear execucao por falta de exemplo.
- Inferência forte: escolher uma familia simples e estruturalmente proxima do alvo.
- Inferência forte: nao abortar so por ausencia de template externo; a referencia principal passa a ser template interno da propria base.
- Hipótese: os erros por objeto devem ser tratados incrementalmente para refinar os documentos.

## Politica para WebPanel

- Evidência direta: existem 1196 `WebPanel` no acervo.
- Inferência forte: identificar primeiro a familia estrutural antes de gerar.
- Inferência forte: escolher o template interno mais proximo, sem generalizar `WebPanel` como tipo homogeneo.
- Inferência forte: manter todos os `Part type` recorrentes do template escolhido.
- Hipótese: abortar apenas quando nao houver familia estrutural identificavel ou quando a proximidade do template continuar ambigua.

## Quando aceitar apenas experimento conservador

- Inferência forte: `PackagedModule` e `Theme` sao os melhores candidatos relativos do recorte, mas apenas para experimento muito controlado.
- Inferência forte: `SDT` pode entrar nessa mesma trilha somente quando houver template muito proximo e preservacao rigorosa de `parent`.
- Inferência forte: `Transaction` e `WebPanel` ficam desbloqueados para execucao controlada usando a propria base como fonte de templates internos.
- Hipótese: nenhum tipo deste acervo deveria ser liberado para geracao automatica ampla sem uma rodada externa de validacao.

## Validacoes minimas antes de empacotar

- XML bem-formado.
- `Object/@type` coerente com o tipo clonado.
- `Part type` recorrentes preservados.
- `parent*` e `moduleGuid` preservados quando presentes no template.
- Revisao manual dos campos textuais alterados.
- Diff estrutural curto entre template-base e clone.

## Estrategia incremental recomendada

- Inferência forte: comecar por provas de conceito extremamente pequenas.
- Inferência forte: manter o escopo por tipo e por template, sem misturar familias estruturais diferentes.
- Inferência forte: para `Transaction` e `WebPanel`, priorizar execucao controlada e retroalimentar a base com os erros observados.
- Inferência forte: so depois de casos externos bem-sucedidos vale endurecer linguagem como "obrigatorio", "editavel com baixo risco" ou "apto para geracao conservadora".

## Ajuste no algoritmo

- Inferência forte: `Transaction` nao deve abortar apenas por ausencia de template externo.
- Inferência forte: `WebPanel` deve abortar apenas quando nao houver familia estrutural identificavel ou template interno suficientemente proximo.

## Regras de materializacao

- Evidência direta: a materializacao final de `Transaction` e `WebPanel` deve partir de um XML bruto real do mesmo `Object/@type`.
- Inferência forte: nunca montar um objeto do zero a partir de descricao em markdown; sempre clonar um XML bruto comparavel e editar o clone.

### Transaction

- preservar `Object/@type`, `guid`, `parent*`, `moduleGuid` e inventario completo de `Part` do template-base
- nao remover `Part` recorrente nem trocar a ordem dos blocos
- alterar apenas campos textuais, nomes e trechos internos que tenham paralelo claro em outros `Transaction` da mesma familia
- se um atributo do no `<Object>` nao existir no template bruto, nao inventar esse atributo no clone
- se surgir referencia a `parent`, modulo ou pattern que nao exista no template comparavel, abortar

### WebPanel

- escolher primeiro a familia estrutural e so depois o template interno real
- preservar `Object/@type`, `guid`, `parent*`, `moduleGuid`, quantidade de `Part` e a ordem dos blocos
- manter `layout`, `events`, `variables` e todos os `Part type` recorrentes do template selecionado
- nao substituir controles, bindings ou componentes raros por texto livre; se nao houver equivalente estrutural no template, abortar
- usar exemplos sanitizados apenas como apoio de leitura; a materializacao final deve vir do XML bruto correspondente

## Regras de serializacao XPZ

- Evidência direta: o XML do objeto deve continuar com raiz unica `<Object>` e permanecer bem-formado apos qualquer edicao
- Evidência direta: cada `Part` deve manter seu atributo `type` e seu conteudo no mesmo bloco estrutural do template-base
- Inferência forte: quando o template bruto usar `<![CDATA[...]]>` em `Source` ou `InnerHtml`, o clone deve manter `CDATA`; nao converter esses blocos em texto escapado
- Inferência forte: o objeto so deve ser incluido em `<Objects>` por clonagem de um contêiner XPZ bruto real da mesma linha de exportacao; nao inventar a estrutura externa de `<Objects>` a partir desta base documental
- Inferência forte: antes de empacotar, validar parse XML do objeto clonado e validar que o envelope XPZ continua contendo o mesmo padrao estrutural do template bruto
- Hipótese: checksum, datas e outros metadados externos so devem ser recalculados se houver processo real de exportacao que faca isso; na ausencia desse processo, preservar o padrao do template bruto

## Regras de fonte

- Fonte valida: XML bruto extraido do acervo ou de template XPZ bruto real comparavel
- Fonte invalida: markdown desta base
- Fonte invalida: exemplos sanitizados, inclusive os anexos de `27-familias-estruturais-de-webpanel.md`
- Fonte invalida: reconstrucoes feitas so por resumo textual, tabela, frequencia ou memoria do agente
- Inferência forte: markdown e exemplos sanitizados servem para decisao e escolha de template, nunca para materializacao final do XML ou serializacao final do XPZ


