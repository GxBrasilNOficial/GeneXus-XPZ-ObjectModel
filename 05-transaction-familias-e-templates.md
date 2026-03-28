# 05 - Transaction Familias e Templates

## Papel do documento
empirico e operacional

## Nivel de confianca predominante
medio

## Depende de
01-base-empirica-geral.md, 02-regras-operacionais-e-runtime.md, 03-risco-e-decisao-por-tipo.md

## Usado por
08-guia-para-agente-gpt.md

## Objetivo
Concentrar familias estruturais de Transaction, regras por familia e validacoes de consistencia interna para clonagem controlada.

## Fontes consolidadas
- 28-familias-estruturais-de-transaction.md

## Origem incorporada - 28-familias-estruturais-de-transaction.md

## Papel do documento
empirico e operacional

## Nivel de confianca predominante
medio

## Depende de
01-base-empirica-geral.md, 10-matriz-part-types-por-tipo.md, 11-campos-estaveis-vs-variaveis.md, 12-diffs-estruturais-por-tipo.md, 03-risco-e-decisao-por-tipo.md, 02-regras-operacionais-e-runtime.md

## Usado por
02-regras-operacionais-e-runtime.md, 26-guia-para-agente-gpt.md

## Objetivo
Identificar familias estruturais reais de `Transaction` a partir do acervo XML analisado.
Permitir escolha repetivel de template interno real, reduzindo risco de vazamento estrutural do template original.

## Sanitizacao deste documento

- Evidencia direta: os nomes reais dos objetos usados como representantes nao aparecem aqui.
- Evidencia direta: cada template representativo recebeu um alias publico, como `TRNExemploF1`, `TRNExemploF2` e assim por diante.
- Inferencia forte: para uso interno, o template correspondente pode ser reencontrado pelo criterio estrutural indicado em cada familia.
- Hipotese: essa estrategia preserva utilidade operacional sem expor nomes de negocio da KB.

## Metodo

- Evidencia direta: foram analisados 183 XMLs de `Transaction`.
- Evidencia direta: todos os 183 objetos usam o mesmo `Object/@type` (`1db606f2-af09-4cf9-a3b5-b481519d28f6`) e o mesmo inventario de 8 `Part type` recorrentes.
- Evidencia direta: os 8 `Part type` presentes em 100% do acervo observado sao `264be5fb-1b28-4b25-a598-6ca900dd059f`, `d24a58ad-57ba-41b7-9e6e-eaca3543c778`, `4c28dfb9-f83b-46f0-9cf3-f7e090b525d5`, `9b0a32a3-de6d-4be1-a4dd-1b85d3741534`, `c44bd5ff-f918-415b-98e6-aca44fed84fa`, `e4c4ade7-53f0-4a56-bdfd-843735b66f47`, `ad3ca970-19d0-44e1-a7b7-db05556e820c` e `babf62c5-0111-49e9-a1c3-cc004d90900a`.
- Evidencia direta: todos os 183 objetos observados possuem `parent` preenchido.
- Evidencia direta: 169 dos 183 objetos possuem pelo menos um bloco `DescriptionAttribute`.
- Evidencia direta: o agrupamento abaixo usa quantidade de `Level`, densidade de `AttributeProperties`, presenca de subniveis e tamanho do XML.
- Inferencia forte: para `Transaction`, a familia estrutural e mais discriminante do que o nome do objeto.

## Visao geral

- Evidencia direta: 162 das 183 `Transaction` observadas possuem exatamente 1 `Level`.
- Evidencia direta: 12 das 183 `Transaction` observadas possuem exatamente 2 `Level`.
- Evidencia direta: 9 das 183 `Transaction` observadas possuem 3 ou mais `Level`.
- Evidencia direta: a media geral de `Part` por objeto e 8; a media geral de `AttributeProperties` no recorte e aproximadamente 18.
- Inferencia forte: a separacao mais util para geracao pratica nao e por semantica de negocio, e sim por complexidade do `Level` principal e pela presenca de estrutura filha.
- Inferencia forte: o principal erro a evitar em `Transaction` e misturar familias diferentes durante a clonagem.

## Familia 1 - Um nivel enxuto

- Evidencia direta: 59 objetos com `1 Level` e ate 6 blocos `AttributeProperties`.
- Evidencia direta: tamanho medio aproximado de 16990 bytes; minimo 7222; maximo 38961.
- Inferencia forte: variabilidade interna baixa.
- Template base publico: `TRNExemploF1`.
- Criterio privado de selecao: menor XML observado dentro da faixa `1 Level` + `0..6 AttributeProperties`.
- Justificativa da escolha: representa a casca mais simples de `Transaction` de um nivel.

### Assinatura estrutural

- 1 `Level` principal
- sem subnivel
- poucos `AttributeProperties`
- `DescriptionAttribute` pode existir ou nao, mas quando existe aponta para atributo do mesmo nivel

### Edicao e preservacao

- Evidencia direta: a estrutura central fica concentrada no primeiro `Part` com `Level` e `Attribute`
- Inferencia forte: os pontos mais seguros de alteracao sao nome do objeto, descricao, nomes de atributos do nivel e `DescriptionAttribute`
- Inferencia forte: devem ser preservados a quantidade de `Part`, a ordem dos blocos, `parent*`, `moduleGuid` e a forma geral do `Level`
- Hipotese: esta e a familia mais segura para primeiras geracoes de `Transaction`

### Uso pratico e clonagem

- Inferencia forte: uso ideal para entidade simples e cadastro basico sem detalhe
- Inferencia forte: clonar preservando a forma do `Level` e substituindo apenas atributos que tenham paralelo bruto claro
- Hipotese: abortar se o alvo exigir subnivel, agrupamento de itens ou grande quantidade de atributos derivados

## Familia 2 - Um nivel com apoio estrutural moderado

- Evidencia direta: 41 objetos com `1 Level` e entre 7 e 11 blocos `AttributeProperties`.
- Evidencia direta: tamanho medio aproximado de 33051 bytes; minimo 19543; maximo 55508.
- Inferencia forte: variabilidade interna baixa para media.
- Template base publico: `TRNExemploF2`.
- Criterio privado de selecao: menor XML observado dentro da faixa `1 Level` + `7..11 AttributeProperties`.
- Justificativa da escolha: preserva o mesmo desenho simples de um nivel, mas com mais atributos controlados por propriedades.

### Assinatura estrutural

- 1 `Level` principal
- sem subnivel
- numero intermediario de `AttributeProperties`
- maior presenca de atributos de apoio, auditoria ou exibicao controlada

### Edicao e preservacao

- Inferencia forte: nomes de atributos, descricao e `DescriptionAttribute` continuam sendo editaveis, mas sempre junto das `AttributeProperties` relacionadas
- Inferencia forte: toda alteracao em atributo do `Level` deve ser refletida nos blocos `AttributeProperties` correspondentes
- Hipotese: erros nesta familia costumam surgir quando o clone remove ou renomeia atributo sem atualizar propriedades ligadas a ele

### Uso pratico e clonagem

- Inferencia forte: uso ideal para entidade simples com controles adicionais de formulario
- Inferencia forte: escolher template da propria faixa, em vez de rebaixar para a Familia 1
- Hipotese: abortar se o alvo exigir 2 niveis ou densidade de propriedades muito acima da faixa observada

## Familia 3 - Um nivel denso

- Evidencia direta: 42 objetos com `1 Level` e entre 12 e 30 blocos `AttributeProperties`.
- Evidencia direta: tamanho medio aproximado de 53395 bytes; minimo 24510; maximo 149206.
- Inferencia forte: variabilidade interna media.
- Template base publico: `TRNExemploF3`.
- Criterio privado de selecao: menor XML observado dentro da faixa `1 Level` + `12..30 AttributeProperties`.
- Justificativa da escolha: mostra `Transaction` ainda de um nivel, mas ja com numero alto de atributos e propriedades relacionadas.

### Assinatura estrutural

- 1 `Level` principal
- sem subnivel
- muitos `AttributeProperties`
- forte acoplamento entre atributos declarados e propriedades internas

### Edicao e preservacao

- Inferencia forte: a maior fonte de erro aqui e inconsistir `Attribute`, `AttributeProperties` e `DescriptionAttribute`
- Inferencia forte: antes de remover ou trocar atributo, verificar todas as ocorrencias no `Level`, nas propriedades e nas regras do objeto
- Hipotese: esta familia e apropriada para `Transaction` sem detalhe, mas com varias colunas auxiliares ou campos controlados

### Uso pratico e clonagem

- Inferencia forte: usar esta familia quando a simples enxuta ficar pequena demais e a estrutura continuar de um nivel
- Inferencia forte: clonar com diff estrutural curto, conferindo que nenhum nome residual do template-base permaneceu
- Hipotese: abortar se o alvo puder ser representado por familia menor ou se a troca de atributos exigir reordenar macicamente o `Level`

## Familia 4 - Um nivel muito denso

- Evidencia direta: 20 objetos com `1 Level` e 31 ou mais blocos `AttributeProperties`.
- Evidencia direta: tamanho medio aproximado de 160126 bytes; minimo 52433; maximo 521796.
- Inferencia forte: variabilidade interna alta.
- Template base publico: `TRNExemploF4`.
- Criterio privado de selecao: menor XML observado dentro da faixa `1 Level` + `31+ AttributeProperties`.
- Justificativa da escolha: representa o teto da complexidade observada ainda sem subnivel.

### Assinatura estrutural

- 1 `Level` principal
- sem subnivel
- altissima densidade de `AttributeProperties`
- blocos extensos de regras e eventos costumam acompanhar a estrutura

### Edicao e preservacao

- Inferencia forte: esta familia so deve ser usada quando a forma de um nivel muito denso for realmente necessaria
- Inferencia forte: preservar integralmente o esqueleto do `Level`, a ordem dos atributos e o inventario de propriedades relacionadas
- Hipotese: tentativas de simplificar demais um template desta familia costumam levar a vazamento de atributos e metadados do template original

### Uso pratico e clonagem

- Inferencia forte: uso ideal quando o alvo exigir muitos atributos auxiliares, calculados ou controlados, mas ainda sem detalhe filho
- Inferencia forte: clonar a partir do menor template possivel dentro desta familia
- Hipotese: abortar se o objetivo real puder ser resolvido com as Familias 2 ou 3

## Familia 5 - Pai-filho com dois niveis

- Evidencia direta: 12 objetos com exatamente `2 Level`.
- Evidencia direta: tamanho medio aproximado de 23236 bytes; minimo 8400; maximo 63405.
- Inferencia forte: variabilidade interna media para alta.
- Template base publico: `TRNExemploF5`.
- Criterio privado de selecao: menor XML observado entre os objetos com exatamente `2 Level`.
- Justificativa da escolha: e a menor forma observada de cabecalho + detalhe ou pai + item.

### Assinatura estrutural

- 1 `Level` pai
- 1 `Level` filho
- atributos distribuidos entre cabecalho e detalhe
- `DescriptionAttribute` pode aparecer no nivel pai, no filho ou em ambos

### Edicao e preservacao

- Evidencia direta: o nivel filho aparece aninhado dentro do nivel pai no primeiro `Part`
- Inferencia forte: devem ser preservados a hierarquia de niveis, a ordem do aninhamento e a relacao entre chaves do pai e do filho
- Inferencia forte: mover atributo de um nivel para outro sem paralelo bruto comparavel e motivo para abortar
- Hipotese: esta familia ja exige cautela alta na escolha do template

### Uso pratico e clonagem

- Inferencia forte: uso ideal para cabecalho + itens simples
- Inferencia forte: clonar somente quando o alvo realmente exigir detalhe filho
- Hipotese: se o alvo couber em 1 nivel, nao usar esta familia

## Familia 6 - Multinivel

- Evidencia direta: 9 objetos com `3` ou mais `Level`.
- Evidencia direta: tamanho medio aproximado de 55436 bytes; minimo 14768; maximo 137656.
- Evidencia direta: o maximo observado no recorte foi de 14 `Level`.
- Inferencia forte: variabilidade interna muito alta.
- Template base publico: `TRNExemploF6`.
- Criterio privado de selecao: menor XML observado entre os objetos com `3+ Level`.
- Justificativa da escolha: representa a menor forma observada de `Transaction` multinivel, evitando escolher como referencia um caso extremo.

### Assinatura estrutural

- 3 ou mais `Level`
- combinacao de pai e multiplos filhos
- maior densidade de atributos, regras e eventos ligados a contexto transacional

### Edicao e preservacao

- Inferencia forte: esta e a familia menos indicada para primeiras geracoes
- Inferencia forte: devem ser preservados integralmente numero de niveis, ordem, nesting e distribuicao de atributos entre niveis
- Inferencia forte: se a mudanca exigir criar, remover ou fundir niveis, abortar
- Hipotese: o custo de erro aqui e muito maior do que nas familias de um nivel

### Uso pratico e clonagem

- Inferencia forte: uso ideal apenas quando houver detalhe real em varios blocos ou subestruturas paralelas
- Inferencia forte: clonar a partir do menor template interno estruturalmente equivalente
- Hipotese: sem template muito proximo, esta familia nao deve ser usada para geracao inicial

## Regras operacionais por familia

- Evidencia direta: `Transaction` deve ser materializada a partir de XML bruto real do mesmo `Object/@type`
- Inferencia forte: a regra pratica mais segura e `identificar familia -> escolher template bruto da mesma familia -> preservar Part, ordem e metadata -> editar apenas o que tem paralelo claro`
- Inferencia forte: para `Transaction` nova, comecar sempre testando encaixe nas Familias 1, 2 ou 3 antes de considerar 5 ou 6
- Inferencia forte: o erro de materializacao mais comum neste tipo e vazamento do template-base em `Level`, `Attribute`, `AttributeProperties` e `DescriptionAttribute`
- Evidencia direta: a bateria de importacao mostrou que `Transaction` pode falhar mesmo com envelope correto quando os atributos do `Level` nao existem de fato na KB de destino
- Evidencia direta: a consulta posterior ao acervo real confirmou o uso recorrente de variaveis de contexto com `ATTCUSTOMTYPE` como `sdt:Context`, `sdt:TransactionContext` e `sdt:TransactionContext.Attribute`
- Inferencia forte: para `Transaction`, a validacao de contexto da KB e tao importante quanto a escolha correta da familia estrutural

## Validacoes obrigatorias de consistencia interna

### Para qualquer Transaction clonada

- o XML deve permanecer bem-formado
- o objeto deve continuar com raiz unica `<Object>`
- os 8 `Part type` recorrentes devem permanecer presentes
- o nome de cada `Level` deve estar coerente com a estrutura final
- todo `<Attribute ...>` dentro de `Level` deve manter nome interno preenchido e coerente com o restante do objeto
- todo `DescriptionAttribute` deve apontar para atributo existente no mesmo nivel
- todo atributo citado em `AttributeProperties` deve existir de fato no XML da estrutura
- se houver variaveis `Context`, `TrnContext` ou `TrnContextAtt`, seus `ATTCUSTOMTYPE` devem apontar para tipos realmente existentes no destino
- nao pode sobrar nome residual do template original

### Sinais classicos de erro

- `DescriptionAttribute` aponta para atributo inexistente
- atributo aparece no `Level`, mas nao tem correspondencia esperada nas propriedades internas
- `AttributeProperties` referencia atributo ausente
- variavel de contexto aponta para `sdt` inexistente ou nao resolvido na KB
- sobra nome residual do template-base em `Level`, `Attribute`, regras ou eventos

## Regras de serializacao XPZ para Transaction

- usar objeto bruto real como fonte
- usar envelope XPZ bruto real como contêiner
- manter ordem das `Part`
- nao converter `CDATA` em texto escapado se o template bruto usar `CDATA`
- incluir o objeto no bloco `<Objects>` apenas por clonagem do envelope bruto comparavel
- validar parse XML antes de empacotar
- validar coerencia interna entre `Level`, `Attribute`, `AttributeProperties` e `DescriptionAttribute`

## Tabela resumo

| Familia | Quando usar | Risco | Template publico |
| --- | --- | --- | --- |
| Um nivel enxuto | entidade simples e cadastro basico | medio-alto | `TRNExemploF1` |
| Um nivel com apoio estrutural moderado | entidade simples com propriedades extras | alto | `TRNExemploF2` |
| Um nivel denso | entidade simples com muitos atributos e controles | alto | `TRNExemploF3` |
| Um nivel muito denso | caso de um nivel com alta carga estrutural | muito alto | `TRNExemploF4` |
| Pai-filho com dois niveis | cabecalho + detalhe simples | muito alto | `TRNExemploF5` |
| Multinivel | detalhe real em varios blocos | muito alto | `TRNExemploF6` |

## Sintese final

- Evidencia direta: o acervo de `Transaction` e dominado por objetos de um nivel, mas nao e homogeneo o bastante para tratar tudo como um unico molde.
- Evidencia direta: a segmentacao por numero de `Level` e densidade de `AttributeProperties` separa o tipo em grupos operacionais bem mais estaveis.
- Inferencia forte: a maior parte das novas `Transaction` deve ser tentada primeiro nas Familias 1, 2 ou 3.
- Inferencia forte: Familias 5 e 6 devem ser tratadas como casos de alta cautela, com template interno muito proximo.
- Hipotese: este catalogo reduz risco de vazamento estrutural do template-base, desde que a materializacao continue presa a XML bruto comparavel e nunca a markdown.

## Moldes sanitizados completos de Transaction

- Evidencia direta: esta base agora contem 4 moldes XML sanitizados completos de `Transaction`, cobrindo as familias `F1`, `F2`, `F5` e `F6`.
- Inferencia forte: esse conjunto ja permite prototipos controlados de `Transaction` sem depender de consulta adicional ao acervo bruto para essas familias representadas.
- Hipotese: as familias `F3` e `F4` ainda ficam melhor atendidas por escolha de familia + molde bruto comparavel, porque nao receberam anexo completo nesta rodada.

### Molde sanitizado 1 - `TRNExemploF1`

- Familia coberta: `F1` (`Um nivel enxuto`).
- Fonte privada de selecao: menor XML observado da faixa `1 Level` + `0..6 AttributeProperties`.
- Sanitizacao aplicada: nome do objeto, nome de pasta, textos visiveis e referencias nominais foram anonimizados; `Object/@type`, `Part type`, hierarquia, `parent*`, `moduleGuid` e estrutura XML foram preservados.

```xml
<?xml version="1.0" encoding="utf-8"?>
<Object parentGuid="89a12723-9ec2-4b97-968b-8e064608788c" user="SANITIZED\\USER" versionDate="0001-01-01T00:00:00.0000000" lastUpdate="2026-02-13T11:36:07.0000000Z" checksum="d812a25d493e5088d9bff2b6ca8f2ece" fullyQualifiedName="TRNExemploF1" moduleGuid="afa47377-41d5-4ae8-9755-6f53150aa361" guid="052afbac-555f-4617-a9f5-fe128e0dbbbf" name="TRNExemploF1" type="1db606f2-af09-4cf9-a3b5-b481519d28f6" description="Transacao Exemplo Simples" parent="PastaExemploF1" parentType="00000000-0000-0000-0000-000000000008">
  <Part type="264be5fb-1b28-4b25-a598-6ca900dd059f">
    <Level Name="TRNExemploF1" Type="TRNExemploF1" Description="Transacao Exemplo Simples" Guid="052afbac-555f-4617-a9f5-fe128e0dbbbf">
      <Properties />
      <Attribute key="True" guid="9ede93e1-6f83-4777-a699-59b52f454057">TRNExemploF1Id</Attribute>
      <Attribute key="False" guid="33e5fe1d-8e0d-4761-8120-3363556d7227" isNullable="True">TRNExemploF1Descricao</Attribute>
      <Attribute key="False" guid="a39f2c52-e17e-4ed1-a284-81a44c7829b7" isNullable="True">TRNExemploF1FormularioCobranca</Attribute>
      <Attribute key="False" guid="9af6e684-9665-4b27-8e11-f2d89df2bfc3" isNullable="True">TRNExemploF1MeioDePagamentoNaNFe</Attribute>
    </Level>
    <Properties>
      <Property>
        <Name>IsDefault</Name>
        <Value>False</Value>
      </Property>
    </Properties>
  </Part>
  <Part type="d24a58ad-57ba-41b7-9e6e-eaca3543c778">
    <Properties>
      <Property>
        <Name>IsDefault</Name>
        <Value>True</Value>
      </Property>
      <Property>
        <Name>Defaults</Name>
        <Value>gx:TrnDefaultWebForm.dkt</Value>
      </Property>
    </Properties>
  </Part>
  <Part type="4c28dfb9-f83b-46f0-9cf3-f7e090b525d5">
    <Properties>
      <Property>
        <Name>IsDefault</Name>
        <Value>True</Value>
      </Property>
      <Property>
        <Name>Defaults</Name>
        <Value>gx:TrnDefaultWinForm.dkt</Value>
      </Property>
    </Properties>
  </Part>
  <Part type="9b0a32a3-de6d-4be1-a4dd-1b85d3741534">
    <Source><![CDATA[/* Generated by Work With Pattern [Start] - Do not change */
[web]
{
parm(in:&Mode, in:&TRNExemploF1Id);

TRNExemploF1Id = &TRNExemploF1Id if not &TRNExemploF1Id.IsEmpty();
noaccept(TRNExemploF1Id) if not &TRNExemploF1Id.IsEmpty();
noprompt(TRNExemploF1Id);
}
/* Generated by Work With Pattern [End] - Do not change */

Error("Somente usuário da EquipeExemplo pode editar transacoes de exemplo.") 
	if (Insert or Update or Delete) and not procUsuarioDaSessaoDaEquipeExemplo();


[web]
{
	
	default(TRNExemploF1Id, procTRNExemploF1IdUltimo()+1);
	
}

error("Descricao obrigatoria") 
	if (TRNExemploF1Descricao.IsEmpty()) and
	(Insert or Update);
]]></Source>
    <Properties>
      <Property>
        <Name>IsDefault</Name>
        <Value>False</Value>
      </Property>
    </Properties>
  </Part>
  <Part type="c44bd5ff-f918-415b-98e6-aca44fed84fa">
    <Source><![CDATA[Event Start
	/* Generated by Work With Pattern [Start] - Do not change */
	[web]
	{
	If not IsAuthorized(&PgmName)
		NotAuthorized(&PgmName)
	Endif
	
	&TrnContext.FromXml(&WebSession.Get(!"TrnContext"))
	
	If &Mode = TrnMode.Delete
		btn_Enter.Caption = "GX_BtnDelete"
		btn_Enter.TooltipText = "GX_BtnDelete"
	EndIf
	}
	/* Generated by Work With Pattern [End] - Do not change */
EndEvent

Event After Trn
	/* Generated by Work With Pattern [Start] - Do not change */
	[web]
	{
	If (&Mode = TrnMode.Delete and not &TrnContext.CallerOnDelete)
		WWTRNExemploF1()
	Endif
	
	Return
	}
	/* Generated by Work With Pattern [End] - Do not change */
EndEvent

]]></Source>
    <Properties>
      <Property>
        <Name>IsDefault</Name>
        <Value>False</Value>
      </Property>
    </Properties>
  </Part>
  <Part type="e4c4ade7-53f0-4a56-bdfd-843735b66f47">
    <Variable Name="TRNExemploF1Id">
      <Documentation />
      <Properties>
        <Property>
          <Name>Name</Name>
          <Value>TRNExemploF1Id</Value>
        </Property>
        <Property>
          <Name>idBasedOn</Name>
          <Value>Attribute:TRNExemploF1Id</Value>
        </Property>
      </Properties>
    </Variable>
    <Variable Name="Context">
      <Documentation />
      <Properties>
        <Property>
          <Name>Name</Name>
          <Value>Context</Value>
        </Property>
        <Property>
          <Name>ATTCUSTOMTYPE</Name>
          <Value>sdt:Context</Value>
        </Property>
        <Property>
          <Name>ATT_INITIAL_VALUE</Name>
          <Value>LoadContext.udp()</Value>
        </Property>
      </Properties>
    </Variable>
    <Variable Name="IsAuthorized">
      <Documentation />
      <Properties>
        <Property>
          <Name>Name</Name>
          <Value>IsAuthorized</Value>
        </Property>
        <Property>
          <Name>ATTCUSTOMTYPE</Name>
          <Value>bas:Boolean</Value>
        </Property>
      </Properties>
    </Variable>
    <Variable Name="TrnContext">
      <Documentation />
      <Properties>
        <Property>
          <Name>Name</Name>
          <Value>TrnContext</Value>
        </Property>
        <Property>
          <Name>ATTCUSTOMTYPE</Name>
          <Value>sdt:TransactionContext</Value>
        </Property>
      </Properties>
    </Variable>
    <Variable Name="WebSession">
      <Documentation />
      <Properties>
        <Property>
          <Name>Name</Name>
          <Value>WebSession</Value>
        </Property>
        <Property>
          <Name>ATTCUSTOMTYPE</Name>
          <Value>ext:WebSession</Value>
        </Property>
      </Properties>
    </Variable>
    <Properties>
      <Property>
        <Name>IsDefault</Name>
        <Value>False</Value>
      </Property>
    </Properties>
  </Part>
  <Part type="ad3ca970-19d0-44e1-a7b7-db05556e820c">
    <Help>
      <HelpItem>
        <Language>88313f43-5eb2-0000-0028-e8d9f5bf9588-Portuguese</Language>
        <Content />
      </HelpItem>
    </Help>
    <Properties>
      <Property>
        <Name>IsDefault</Name>
        <Value>False</Value>
      </Property>
    </Properties>
  </Part>
  <Part type="babf62c5-0111-49e9-a1c3-cc004d90900a">
    <Properties />
  </Part>
  <Properties>
    <Property>
      <Name>Name</Name>
      <Value>TRNExemploF1</Value>
    </Property>
    <Property>
      <Name>Description</Name>
      <Value>Transacao Exemplo Simples</Value>
    </Property>
    <Property>
      <Name>idISBUSINESSCOMPONENT</Name>
      <Value>True</Value>
    </Property>
    <Property>
      <Name>MasterPage</Name>
      <Value>MasterPageExemplo</Value>
    </Property>
    <Property>
      <Name>SEARCH_VIEWER</Name>
      <Value>c9584656-94b6-4ccd-890f-332d11fc2c25-ViewTRNExemploF1</Value>
    </Property>
    <Property>
      <Name>Apply:78cecefe-be7d-4980-86ce-8d6e91fba04b</Name>
      <Value>True</Value>
    </Property>
    <Property>
      <Name>IsDefault</Name>
      <Value>False</Value>
    </Property>
  </Properties>
</Object>


```

### Molde sanitizado 2 - `TRNExemploF2`

- Familia coberta: `F2` (`Um nivel com apoio estrutural moderado`).
- Fonte privada de selecao: menor XML observado da faixa `1 Level` + `7..11 AttributeProperties`.
- Sanitizacao aplicada: nome do objeto, textos de regra e referencias nominais foram anonimizados; a densidade de `AttributeProperties`, a ordem das `Part`, `CDATA` e os atributos internos foram preservados.

```xml
<?xml version="1.0" encoding="utf-8"?>
<Object parentGuid="ce54ed93-ebec-4ed1-b829-873e61f7f6d5" user="SANITIZED\\USER" versionDate="0001-01-01T00:00:00.0000000" lastUpdate="2026-02-03T22:38:17.0000000Z" checksum="d06eda3df45da93addccad8d0e0ca531" fullyQualifiedName="TRNExemploF2" moduleGuid="afa47377-41d5-4ae8-9755-6f53150aa361" guid="faf9b44d-1180-4a9a-89b2-d850d82b3ad1" name="TRNExemploF2" type="1db606f2-af09-4cf9-a3b5-b481519d28f6" description="TRNExemploF2" parent="TRNExemploF2" parentType="00000000-0000-0000-0000-000000000008">
  <Part type="264be5fb-1b28-4b25-a598-6ca900dd059f">
    <Level Name="TRNExemploF2" Type="TRNExemploF2" Description="TRNExemploF2" Guid="faf9b44d-1180-4a9a-89b2-d850d82b3ad1">
      <Properties />
      <DescriptionAttribute>TRNExemploF2Id</DescriptionAttribute>
      <AttributeProperties Attribute="TRNExemploF2NomeOriginal">
        <Properties>
          <Property>
            <Name>IncludeInForms</Name>
            <Value>True</Value>
          </Property>
        </Properties>
      </AttributeProperties>
      <AttributeProperties Attribute="TRNExemploF2Extensao">
        <Properties>
          <Property>
            <Name>IncludeInForms</Name>
            <Value>True</Value>
          </Property>
        </Properties>
      </AttributeProperties>
      <AttributeProperties Attribute="TRNExemploF2NomeOriginalComExtensao">
        <Properties>
          <Property>
            <Name>IncludeInForms</Name>
            <Value>False</Value>
          </Property>
        </Properties>
      </AttributeProperties>
      <AttributeProperties Attribute="TRNExemploF2Tipo">
        <Properties>
          <Property>
            <Name>IncludeInForms</Name>
            <Value>True</Value>
          </Property>
        </Properties>
      </AttributeProperties>
      <AttributeProperties Attribute="TRNExemploF2InclusaoDataHora">
        <Properties>
          <Property>
            <Name>IncludeInForms</Name>
            <Value>False</Value>
          </Property>
        </Properties>
      </AttributeProperties>
      <AttributeProperties Attribute="TRNExemploF2InclusaoUsuarioId">
        <Properties>
          <Property>
            <Name>IncludeInForms</Name>
            <Value>False</Value>
          </Property>
        </Properties>
      </AttributeProperties>
      <AttributeProperties Attribute="TRNExemploF2UltimaAtualizacaoDataHora">
        <Properties>
          <Property>
            <Name>IncludeInForms</Name>
            <Value>False</Value>
          </Property>
        </Properties>
      </AttributeProperties>
      <AttributeProperties Attribute="TRNExemploF2UltimaAtualizacaoUsuarioId">
        <Properties>
          <Property>
            <Name>IncludeInForms</Name>
            <Value>False</Value>
          </Property>
        </Properties>
      </AttributeProperties>
      <AttributeProperties Attribute="TRNExemploF2UltimaAtualizacaoUsuarioNome">
        <Properties>
          <Property>
            <Name>IncludeInForms</Name>
            <Value>False</Value>
          </Property>
        </Properties>
      </AttributeProperties>
      <Attribute key="True" guid="2f16f4c6-1aa8-4793-9dd2-7ff2d3d8eddd">TRNExemploF2EmpresaId</Attribute>
      <Attribute key="True" guid="a6c12314-f6b2-47d4-a2a7-4bc5bf6bf921">TRNExemploF2Id</Attribute>
      <Attribute key="False" guid="fa420182-017c-43df-b3c3-ab70c2fd42d1" isNullable="True">TRNExemploF2Conteudo</Attribute>
      <Attribute key="False" guid="4fb14d48-1f8e-408a-82ef-f58a3e796497" isNullable="True">TRNExemploF2ConteudoTexto</Attribute>
      <Attribute key="False" guid="36479911-3b69-4688-a119-7bfd162bf7d4" isNullable="True">TRNExemploF2NomeOriginal</Attribute>
      <Attribute key="False" guid="76001e54-afa1-4d5c-8754-c960fc2d6ee6" isNullable="True">TRNExemploF2Extensao</Attribute>
      <Attribute key="False" guid="61ba4a32-c73c-4ae0-9463-7952694a8378">TRNExemploF2NomeOriginalComExtensao</Attribute>
      <Attribute key="False" guid="263a4e88-1a7e-4214-bc9e-19540b2b9ab8" isNullable="True">TRNExemploF2Tipo</Attribute>
      <Attribute key="False" guid="1468c5ba-7ea6-487c-a78f-854d05e83b32" isNullable="True">TRNExemploF2NomeFormatado</Attribute>
      <Attribute key="False" guid="6cb156f6-5ae6-493e-93a4-19ab13ffc668" isNullable="True">TRNExemploF2ReferenciaDeRegistroDeOutraTabela</Attribute>
      <Attribute key="False" guid="58330f24-6223-498f-b81e-4419b49805c5" isNullable="True">TRNExemploF2InclusaoDataHora</Attribute>
      <Attribute key="False" guid="b0f83946-81b3-4f8e-8711-65266928be0b" isNullable="True">TRNExemploF2InclusaoUsuarioId</Attribute>
      <Attribute key="False" guid="fb723a61-d540-47c0-96b8-f346a9bdf210" isNullable="True">TRNExemploF2UltimaAtualizacaoDataHora</Attribute>
      <Attribute key="False" guid="5d60ee34-7cf5-43ff-9706-5bbebe1aa0c4" isNullable="True">TRNExemploF2UltimaAtualizacaoUsuarioId</Attribute>
      <Attribute key="False" guid="1204b80f-77a8-45ff-a3dc-dcfa6cf71a5f">TRNExemploF2UltimaAtualizacaoUsuarioNome</Attribute>
      <Attribute key="False" guid="2e0075a8-198c-4e25-8dec-8ca1c7031680">TRNExemploF2ResumoAtualizacao</Attribute>
    </Level>
    <Properties>
      <Property>
        <Name>IsDefault</Name>
        <Value>False</Value>
      </Property>
    </Properties>
  </Part>
  <Part type="d24a58ad-57ba-41b7-9e6e-eaca3543c778">
    <Properties>
      <Property>
        <Name>IsDefault</Name>
        <Value>True</Value>
      </Property>
      <Property>
        <Name>Defaults</Name>
        <Value>gx:TrnDefaultWebForm.dkt</Value>
      </Property>
    </Properties>
  </Part>
  <Part type="4c28dfb9-f83b-46f0-9cf3-f7e090b525d5">
    <Properties>
      <Property>
        <Name>IsDefault</Name>
        <Value>True</Value>
      </Property>
      <Property>
        <Name>Defaults</Name>
        <Value>gx:TrnDefaultWinForm.dkt</Value>
      </Property>
    </Properties>
  </Part>
  <Part type="9b0a32a3-de6d-4be1-a4dd-1b85d3741534">
    <Source><![CDATA[/* Generated by Work With Pattern [Start] - Do not change */
[web]
{
parm(in:&Mode, in:&TRNExemploF2EmpresaId, in:&TRNExemploF2Id);

TRNExemploF2EmpresaId = &TRNExemploF2EmpresaId if not &TRNExemploF2EmpresaId.IsEmpty();
noaccept(TRNExemploF2EmpresaId) if not &TRNExemploF2EmpresaId.IsEmpty();
TRNExemploF2Id = &TRNExemploF2Id if not &TRNExemploF2Id.IsEmpty();
noaccept(TRNExemploF2Id) if not &TRNExemploF2Id.IsEmpty();

TRNExemploF2UltimaAtualizacaoUsuarioId = &Insert_TRNExemploF2UltimaAtualizacaoUsuarioId if &Mode = TrnMode.Insert and not &Insert_TRNExemploF2UltimaAtualizacaoUsuarioId.IsEmpty();
noaccept(TRNExemploF2UltimaAtualizacaoUsuarioId) if &Mode = TrnMode.Insert and not &Insert_TRNExemploF2UltimaAtualizacaoUsuarioId.IsEmpty();}
/* Generated by Work With Pattern [End] - Do not change */

&EmpresaAgora = procEmpresaDaSessaoAgora();
&SessaoUsuarioId = procLeUsuarioSessao();

&CobrancaEmpresaId = procEmpresaCobranca();

&UsuarioDaSessaoDaEquipeExemplo = procUsuarioDaSessaoDaEquipeExemplo();

error("Não pode alterar. Registro de Empresa diferente da prevista na sessão.") 
	if not (display or insert) and TRNExemploF2EmpresaId <> procLeEmpresaSessao() and
	procEmpresaComUmCobrancasId(TRNExemploF2EmpresaId, &CobrancaEmpresaId) = false and
	TRNExemploF2EmpresaId <> procEmpresaPessoa() and
	procEmpresaIndustriaPrestadoraDeServicosId(TRNExemploF2EmpresaId) <> procLeEmpresaSessao();

[web]
{

	TRNExemploF2Id.Enabled = false;

	//Esconder para nao ser manualmente copiado e para não atrapalhar a deleção
	TRNExemploF2ConteudoTexto.Visible = false 
		if (not TRNExemploF2Conteudo.IsEmpty() and not TRNExemploF2Conteudo.IsNull()) or
		(not insert and not TRNExemploF2ConteudoTexto.IsEmpty() and not TRNExemploF2ConteudoTexto.IsNull() and
		(TRNExemploF2Tipo.ToLower() = ".xml" or TRNExemploF2Extensao.ToLower() = "xml"));
		
	//desligar para nao estragar, se for usado o blob (TRNExemploF2Conteudo)	
	TRNExemploF2NomeOriginal.Enabled = false 
		if not TRNExemploF2Conteudo.IsEmpty() and not TRNExemploF2Conteudo.IsNull();
	TRNExemploF2Extensao.Enabled = false
		if not TRNExemploF2Conteudo.IsEmpty() and not TRNExemploF2Conteudo.IsNull();
	TRNExemploF2Tipo.Enabled = &UsuarioDaSessaoDaEquipeExemplo
		if not TRNExemploF2Conteudo.IsEmpty() and not TRNExemploF2Conteudo.IsNull();
	
	TRNExemploF2NomeFormatado.Enabled = false
		if not TRNExemploF2Conteudo.IsEmpty() and not TRNExemploF2Conteudo.IsNull();

	&modificado = modified() on BeforeUpdate;
	
}

[bc]
{
	
	//em bc nao funciona modified()
	//falta observar cada campo.
	&modificado = true
	 if update 
		on BeforeUpdate;
		
}

//Define as empresas escondidas
Default(TRNExemploF2EmpresaId, procLeEmpresaSessao());


Default(TRNExemploF2InclusaoDataHora, &EmpresaAgora);
Default(TRNExemploF2InclusaoUsuarioId, &SessaoUsuarioId);
Default(TRNExemploF2UltimaAtualizacaoDataHora, &EmpresaAgora);
Default(TRNExemploF2UltimaAtualizacaoUsuarioId, &SessaoUsuarioId);

TRNExemploF2UltimaAtualizacaoDataHora = &EmpresaAgora if update and &modificado on BeforeUpdate;
TRNExemploF2UltimaAtualizacaoUsuarioId = &SessaoUsuarioId if update and &modificado on BeforeUpdate;

Error("Erro: Data e hora de contexto nao foi determinada. ") 
	if (insert or update) and &EmpresaAgora.IsEmpty();
	
Error("Erro: Data e hora de inclusao nao foi determinada. Contexto atual: " + &EmpresaAgora.ToString()) 
	if insert and not &EmpresaAgora.IsEmpty() and
		(TRNExemploF2InclusaoDataHora.IsEmpty() or TRNExemploF2InclusaoDataHora.IsNull());

Error("Erro: Usuario da sessao nao foi determinado. ") 
	if (insert or update) and &SessaoUsuarioId.IsEmpty();
	
Error("Erro: Usuario da inclusao nao foi determinado. Usuario da sessao: " + &SessaoUsuarioId.ToString()) 
	if insert and not &SessaoUsuarioId.IsEmpty() and 
		(TRNExemploF2InclusaoUsuarioId.IsEmpty() or TRNExemploF2InclusaoUsuarioId.IsNull());

Error("Erro: Nenhuma alteracao detectada para salvar.") 
	if update and not &modificado on BeforeUpdate;


TRNExemploF2Tipo = "." + TRNExemploF2Extensao.ToLower() 
	if (insert or update) and (TRNExemploF2Tipo.IsEmpty() or TRNExemploF2Tipo.IsNull());
	
error("Nome original do registro e obrigatorio.") 
	if (TRNExemploF2NomeOriginal.IsEmpty() or TRNExemploF2NomeOriginal.IsNull()) and (insert or update);

error("Extensao do registro e obrigatoria. Nome original: " + TRNExemploF2NomeOriginal) 
	if (TRNExemploF2Extensao.IsEmpty() or TRNExemploF2Extensao.IsNull()) and (insert or update);

error("Tipo do registro e obrigatorio.") 
	if (TRNExemploF2Tipo.IsEmpty() or TRNExemploF2Tipo.IsNull()) and (insert or update);

error("Nao pode usar os dois campos de conteudo ao mesmo tempo.") 
	if (insert or update) and not TRNExemploF2Conteudo.IsEmpty() and TRNExemploF2Conteudo.IsNull() and
	not TRNExemploF2ConteudoTexto.IsEmpty() and not TRNExemploF2ConteudoTexto.IsNull();
	
//Enquanto não houver garantia de que a gravação não mude nada, invalidando a assinatura, é proibido usar xml no campo de texto
error("Nao pode colocar XML no campo de conteudo textual.") 
	if (insert or update) and not TRNExemploF2ConteudoTexto.IsEmpty() and not TRNExemploF2ConteudoTexto.IsNull() and
	(TRNExemploF2Tipo.ToLower() = ".xml" or TRNExemploF2Extensao.ToLower() = "xml");

msg("Delecao do registro Id " + TRNExemploF2Id.ToString() + ", da Empresa Exemplo Id " + TRNExemploF2EmpresaId.ToString() + ".") 
	on BeforeDelete;
	
TRNExemploF2Id = procTRNExemploF2IdUltimo(TRNExemploF2EmpresaId)+1 
	on BeforeInsert;
]]></Source>
    <Properties>
      <Property>
        <Name>IsDefault</Name>
        <Value>False</Value>
      </Property>
    </Properties>
  </Part>
  <Part type="c44bd5ff-f918-415b-98e6-aca44fed84fa">
    <Source><![CDATA[//Event Start
Event Start
	
	[web]
	{
		
		//if &Mode = TrnMode.Insert
		if &Mode = TrnMode.Insert
			
			TRNExemploF2ResumoAtualizacao.Visible = false
			
		endif

	}
	/* Generated by Work With Pattern [Start] - Do not change */
	[web]
	{
	If not IsAuthorized(&PgmName)
		NotAuthorized(&PgmName)
	Endif
	
	&TrnContext.FromXml(&WebSession.Get(!"TrnContext"))
	&Insert_TRNExemploF2UltimaAtualizacaoUsuarioId.SetEmpty()
	
	If (&TrnContext.TransactionName = &Pgmname and &Mode = TrnMode.Insert)
		For &TrnContextAtt in &TrnContext.Attributes
			Do Case
				// When inserting with instantiated TRNExemploF2UltimaAtualizacaoUsuarioId
				Case &TrnContextAtt.AttributeName = !"TRNExemploF2UltimaAtualizacaoUsuarioId"
					&Insert_TRNExemploF2UltimaAtualizacaoUsuarioId.FromString(&TrnContextAtt.AttributeValue)
			Endcase
		Endfor
	Endif
	
	If &Mode = TrnMode.Delete
		btn_Enter.Caption = "GX_BtnDelete"
		btn_Enter.TooltipText = "GX_BtnDelete"
	EndIf
	}
	/* Generated by Work With Pattern [End] - Do not change */
EndEvent

Event After Trn
	/* Generated by Work With Pattern [Start] - Do not change */
	[web]
	{
	If (&Mode = TrnMode.Delete and not &TrnContext.CallerOnDelete)
		WWTRNExemploF2()
	Endif
	
	Return
	}
	/* Generated by Work With Pattern [End] - Do not change */
EndEvent

]]></Source>
    <Properties>
      <Property>
        <Name>IsDefault</Name>
        <Value>False</Value>
      </Property>
    </Properties>
  </Part>
  <Part type="e4c4ade7-53f0-4a56-bdfd-843735b66f47">
    <Variable Name="TRNExemploF2EmpresaId">
      <Documentation />
      <Properties>
        <Property>
          <Name>Name</Name>
          <Value>TRNExemploF2EmpresaId</Value>
        </Property>
        <Property>
          <Name>idBasedOn</Name>
          <Value>Attribute:TRNExemploF2EmpresaId</Value>
        </Property>
      </Properties>
    </Variable>
    <Variable Name="TRNExemploF2Id">
      <Documentation />
      <Properties>
        <Property>
          <Name>Name</Name>
          <Value>TRNExemploF2Id</Value>
        </Property>
        <Property>
          <Name>idBasedOn</Name>
          <Value>Attribute:TRNExemploF2Id</Value>
        </Property>
      </Properties>
    </Variable>
    <Variable Name="CobrancaEmpresaId">
      <Documentation />
      <Properties>
        <Property>
          <Name>Name</Name>
          <Value>CobrancaEmpresaId</Value>
        </Property>
        <Property>
          <Name>Description</Name>
          <Value>Cobranca Empresa Id</Value>
        </Property>
        <Property>
          <Name>idBasedOn</Name>
          <Value>Attribute:CobrancaEmpresaId</Value>
        </Property>
      </Properties>
    </Variable>
    <Variable Name="Context">
      <Documentation />
      <Properties>
        <Property>
          <Name>Name</Name>
          <Value>Context</Value>
        </Property>
        <Property>
          <Name>ATTCUSTOMTYPE</Name>
          <Value>sdt:Context</Value>
        </Property>
        <Property>
          <Name>ATT_INITIAL_VALUE</Name>
          <Value>LoadContext.udp()</Value>
        </Property>
      </Properties>
    </Variable>
    <Variable Name="EmpresaAgora">
      <Documentation />
      <Properties>
        <Property>
          <Name>Name</Name>
          <Value>EmpresaAgora</Value>
        </Property>
        <Property>
          <Name>Description</Name>
          <Value>Empresa Agora</Value>
        </Property>
        <Property>
          <Name>idBasedOn</Name>
          <Value>Domain:DataHoraCompleta</Value>
        </Property>
      </Properties>
    </Variable>
    <Variable Name="Insert_TRNExemploF2UltimaAtualizacaoUsuarioId">
      <Documentation />
      <Properties>
        <Property>
          <Name>Name</Name>
          <Value>Insert_TRNExemploF2UltimaAtualizacaoUsuarioId</Value>
        </Property>
        <Property>
          <Name>idBasedOn</Name>
          <Value>Attribute:TRNExemploF2UltimaAtualizacaoUsuarioId</Value>
        </Property>
      </Properties>
    </Variable>
    <Variable Name="IsAuthorized">
      <Documentation />
      <Properties>
        <Property>
          <Name>Name</Name>
          <Value>IsAuthorized</Value>
        </Property>
        <Property>
          <Name>ATTCUSTOMTYPE</Name>
          <Value>bas:Boolean</Value>
        </Property>
      </Properties>
    </Variable>
    <Variable Name="modificado">
      <Documentation />
      <Properties>
        <Property>
          <Name>Name</Name>
          <Value>modificado</Value>
        </Property>
        <Property>
          <Name>idBasedOn</Name>
          <Value>Domain:Logico</Value>
        </Property>
      </Properties>
    </Variable>
    <Variable Name="SessaoUsuarioId">
      <Documentation />
      <Properties>
        <Property>
          <Name>Name</Name>
          <Value>SessaoUsuarioId</Value>
        </Property>
        <Property>
          <Name>Description</Name>
          <Value>Usuario Id</Value>
        </Property>
        <Property>
          <Name>idBasedOn</Name>
          <Value>Attribute:UsuarioId</Value>
        </Property>
      </Properties>
    </Variable>
    <Variable Name="TrnContext">
      <Documentation />
      <Properties>
        <Property>
          <Name>Name</Name>
          <Value>TrnContext</Value>
        </Property>
        <Property>
          <Name>ATTCUSTOMTYPE</Name>
          <Value>sdt:TransactionContext</Value>
        </Property>
      </Properties>
    </Variable>
    <Variable Name="TrnContextAtt">
      <Documentation />
      <Properties>
        <Property>
          <Name>Name</Name>
          <Value>TrnContextAtt</Value>
        </Property>
        <Property>
          <Name>ATTCUSTOMTYPE</Name>
          <Value>sdt:TransactionContext.Attribute</Value>
        </Property>
      </Properties>
    </Variable>
    <Variable Name="UsuarioDaSessaoDaEquipeExemplo">
      <Documentation />
      <Properties>
        <Property>
          <Name>Name</Name>
          <Value>UsuarioDaSessaoDaEquipeExemplo</Value>
        </Property>
        <Property>
          <Name>idBasedOn</Name>
          <Value>Domain:Logico</Value>
        </Property>
      </Properties>
    </Variable>
    <Variable Name="WebSession">
      <Documentation />
      <Properties>
        <Property>
          <Name>Name</Name>
          <Value>WebSession</Value>
        </Property>
        <Property>
          <Name>ATTCUSTOMTYPE</Name>
          <Value>ext:WebSession</Value>
        </Property>
      </Properties>
    </Variable>
    <Properties>
      <Property>
        <Name>IsDefault</Name>
        <Value>False</Value>
      </Property>
    </Properties>
  </Part>
  <Part type="ad3ca970-19d0-44e1-a7b7-db05556e820c">
    <Help>
      <HelpItem>
        <Language>88313f43-5eb2-0000-0028-e8d9f5bf9588-Portuguese</Language>
        <Content />
      </HelpItem>
    </Help>
    <Properties>
      <Property>
        <Name>IsDefault</Name>
        <Value>False</Value>
      </Property>
    </Properties>
  </Part>
  <Part type="babf62c5-0111-49e9-a1c3-cc004d90900a">
    <InnerHtml><![CDATA[]]></InnerHtml>
    <Properties>
      <Property>
        <Name>IsDefault</Name>
        <Value>False</Value>
      </Property>
    </Properties>
  </Part>
  <Properties>
    <Property>
      <Name>Name</Name>
      <Value>TRNExemploF2</Value>
    </Property>
    <Property>
      <Name>idISBUSINESSCOMPONENT</Name>
      <Value>True</Value>
    </Property>
    <Property>
      <Name>MasterPage</Name>
      <Value>MasterPageExemplo</Value>
    </Property>
    <Property>
      <Name>SEARCH_VIEWER</Name>
      <Value>c9584656-94b6-4ccd-890f-332d11fc2c25-ViewTRNExemploF2</Value>
    </Property>
    <Property>
      <Name>Apply:78cecefe-be7d-4980-86ce-8d6e91fba04b</Name>
      <Value>True</Value>
    </Property>
    <Property>
      <Name>IsDefault</Name>
      <Value>False</Value>
    </Property>
  </Properties>
</Object>


```

### Molde sanitizado 3 - `TRNExemploF5`

- Familia coberta: `F5` (`Pai-filho com dois niveis`).
- Fonte privada de selecao: menor XML observado entre os objetos com exatamente `2 Level`.
- Sanitizacao aplicada: nome do objeto, pasta, textos visiveis e referencias nominais foram anonimizados; a relacao pai-filho, o aninhamento de `Level`, `Part type` e blocos de evento foram preservados.

```xml
<?xml version="1.0" encoding="utf-8"?>
<Object parentGuid="58642553-5027-46f1-87ff-1bc58bd199bb" user="SANITIZED\\USER" versionDate="0001-01-01T00:00:00.0000000" lastUpdate="2026-02-13T11:36:51.0000000Z" checksum="bfa712cf324ee53b4c42659a99af770d" fullyQualifiedName="TRNExemploF5" moduleGuid="afa47377-41d5-4ae8-9755-6f53150aa361" guid="7e90ece0-aa8a-4729-b8df-fa881162ac23" name="TRNExemploF5" type="1db606f2-af09-4cf9-a3b5-b481519d28f6" description="Transacao Exemplo Pai Filho" parent="PastaExemploF5" parentType="00000000-0000-0000-0000-000000000008">
  <Part type="264be5fb-1b28-4b25-a598-6ca900dd059f">
    <Level Name="TRNExemploF5" Type="TRNExemploF5" Description="Transacao Exemplo Pai Filho" Guid="7e90ece0-aa8a-4729-b8df-fa881162ac23">
      <Properties />
      <DescriptionAttribute>TRNExemploF5UsuarioId</DescriptionAttribute>
      <Attribute key="True" guid="4ffc68ce-31c0-4686-927f-39b89968ed1b">TRNExemploF5Id</Attribute>
      <Attribute key="False" guid="986b9d7d-c12f-4169-a53a-90890a21fd21">TRNExemploF5UsuarioId</Attribute>
      <Attribute key="False" guid="16e5f1ed-2dbc-4ce5-a9b4-98357563f9ac">TRNExemploF5UsuarioNome</Attribute>
      <Level Name="Item" Type="Item" Description="Item" Guid="3d935da8-ed64-4b27-9a1c-d69bd389065c">
        <Properties />
        <Attribute key="True" guid="415730e5-7a99-4c9f-a189-cad861edf8af">TRNExemploF5ItemId</Attribute>
        <Attribute key="False" guid="3be62149-638d-466c-9b9c-c8348e43a57b" isNullable="True">TRNExemploF5ItemCodigo</Attribute>
      </Level>
    </Level>
    <Properties>
      <Property>
        <Name>IsDefault</Name>
        <Value>False</Value>
      </Property>
    </Properties>
  </Part>
  <Part type="d24a58ad-57ba-41b7-9e6e-eaca3543c778">
    <Properties>
      <Property>
        <Name>IsDefault</Name>
        <Value>True</Value>
      </Property>
      <Property>
        <Name>Defaults</Name>
        <Value>gx:TrnDefaultWebForm.dkt</Value>
      </Property>
    </Properties>
  </Part>
  <Part type="4c28dfb9-f83b-46f0-9cf3-f7e090b525d5">
    <Properties>
      <Property>
        <Name>IsDefault</Name>
        <Value>True</Value>
      </Property>
      <Property>
        <Name>Defaults</Name>
        <Value>gx:TrnDefaultWinForm.dkt</Value>
      </Property>
    </Properties>
  </Part>
  <Part type="9b0a32a3-de6d-4be1-a4dd-1b85d3741534">
    <Source><![CDATA[/* Generated by Work With Pattern [Start] - Do not change */
[web]
{
parm(in:&Mode, in:&TRNExemploF5Id);

TRNExemploF5Id = &TRNExemploF5Id if not &TRNExemploF5Id.IsEmpty();
noaccept(TRNExemploF5Id);
noprompt(TRNExemploF5Id);

TRNExemploF5UsuarioId = &Insert_TRNExemploF5UsuarioId if &Mode = TrnMode.Insert and not &Insert_TRNExemploF5UsuarioId.IsEmpty();
noaccept(TRNExemploF5UsuarioId) if &Mode = TrnMode.Insert and not &Insert_TRNExemploF5UsuarioId.IsEmpty();}
/* Generated by Work With Pattern [End] - Do not change */
]]></Source>
    <Properties>
      <Property>
        <Name>IsDefault</Name>
        <Value>False</Value>
      </Property>
    </Properties>
  </Part>
  <Part type="c44bd5ff-f918-415b-98e6-aca44fed84fa">
    <Source><![CDATA[Event Start
	/* Generated by Work With Pattern [Start] - Do not change */
	[web]
	{
	If not IsAuthorized(&PgmName)
		NotAuthorized(&PgmName)
	Endif
	
	&TrnContext.FromXml(&WebSession.Get(!"TrnContext"))
	&Insert_TRNExemploF5UsuarioId.SetEmpty()
	
	If (&TrnContext.TransactionName = &Pgmname and &Mode = TrnMode.Insert)
		For &TrnContextAtt in &TrnContext.Attributes
			Do Case
				// When inserting with instantiated TRNExemploF5UsuarioId
				Case &TrnContextAtt.AttributeName = !"TRNExemploF5UsuarioId"
					&Insert_TRNExemploF5UsuarioId.FromString(&TrnContextAtt.AttributeValue)
			Endcase
		Endfor
	Endif
	
	If &Mode = TrnMode.Delete
		btn_Enter.Caption = "GX_BtnDelete"
		btn_Enter.TooltipText = "GX_BtnDelete"
	EndIf
	}
	/* Generated by Work With Pattern [End] - Do not change */
EndEvent

Event After Trn
	/* Generated by Work With Pattern [Start] - Do not change */
	[web]
	{
	If (&Mode = TrnMode.Delete and not &TrnContext.CallerOnDelete)
		WWTRNExemploF5()
	Endif
	
	Return
	}
	/* Generated by Work With Pattern [End] - Do not change */
EndEvent

]]></Source>
    <Properties>
      <Property>
        <Name>IsDefault</Name>
        <Value>False</Value>
      </Property>
    </Properties>
  </Part>
  <Part type="e4c4ade7-53f0-4a56-bdfd-843735b66f47">
    <Variable Name="TRNExemploF5Id">
      <Documentation />
      <Properties>
        <Property>
          <Name>Name</Name>
          <Value>TRNExemploF5Id</Value>
        </Property>
        <Property>
          <Name>idBasedOn</Name>
          <Value>Attribute:TRNExemploF5Id</Value>
        </Property>
      </Properties>
    </Variable>
    <Variable Name="Context">
      <Documentation />
      <Properties>
        <Property>
          <Name>Name</Name>
          <Value>Context</Value>
        </Property>
        <Property>
          <Name>ATTCUSTOMTYPE</Name>
          <Value>sdt:Context</Value>
        </Property>
        <Property>
          <Name>ATT_INITIAL_VALUE</Name>
          <Value>LoadContext.udp()</Value>
        </Property>
      </Properties>
    </Variable>
    <Variable Name="IsAuthorized">
      <Documentation />
      <Properties>
        <Property>
          <Name>Name</Name>
          <Value>IsAuthorized</Value>
        </Property>
        <Property>
          <Name>ATTCUSTOMTYPE</Name>
          <Value>bas:Boolean</Value>
        </Property>
      </Properties>
    </Variable>
    <Variable Name="TrnContext">
      <Documentation />
      <Properties>
        <Property>
          <Name>Name</Name>
          <Value>TrnContext</Value>
        </Property>
        <Property>
          <Name>ATTCUSTOMTYPE</Name>
          <Value>sdt:TransactionContext</Value>
        </Property>
      </Properties>
    </Variable>
    <Variable Name="WebSession">
      <Documentation />
      <Properties>
        <Property>
          <Name>Name</Name>
          <Value>WebSession</Value>
        </Property>
        <Property>
          <Name>ATTCUSTOMTYPE</Name>
          <Value>ext:WebSession</Value>
        </Property>
      </Properties>
    </Variable>
    <Variable Name="Insert_TRNExemploF5UsuarioId">
      <Documentation />
      <Properties>
        <Property>
          <Name>Name</Name>
          <Value>Insert_TRNExemploF5UsuarioId</Value>
        </Property>
        <Property>
          <Name>idBasedOn</Name>
          <Value>Attribute:TRNExemploF5UsuarioId</Value>
        </Property>
      </Properties>
    </Variable>
    <Variable Name="TrnContextAtt">
      <Documentation />
      <Properties>
        <Property>
          <Name>Name</Name>
          <Value>TrnContextAtt</Value>
        </Property>
        <Property>
          <Name>ATTCUSTOMTYPE</Name>
          <Value>sdt:TransactionContext.Attribute</Value>
        </Property>
      </Properties>
    </Variable>
    <Properties>
      <Property>
        <Name>IsDefault</Name>
        <Value>False</Value>
      </Property>
    </Properties>
  </Part>
  <Part type="ad3ca970-19d0-44e1-a7b7-db05556e820c">
    <Help>
      <HelpItem>
        <Language>88313f43-5eb2-0000-0028-e8d9f5bf9588-Portuguese</Language>
        <Content />
      </HelpItem>
    </Help>
    <Properties>
      <Property>
        <Name>IsDefault</Name>
        <Value>False</Value>
      </Property>
    </Properties>
  </Part>
  <Part type="babf62c5-0111-49e9-a1c3-cc004d90900a">
    <Properties />
  </Part>
  <Properties>
    <Property>
      <Name>Name</Name>
      <Value>TRNExemploF5</Value>
    </Property>
    <Property>
      <Name>Description</Name>
      <Value>Transacao Exemplo Pai Filho</Value>
    </Property>
    <Property>
      <Name>MasterPage</Name>
      <Value>MasterPageExemplo</Value>
    </Property>
    <Property>
      <Name>Apply:78cecefe-be7d-4980-86ce-8d6e91fba04b</Name>
      <Value>True</Value>
    </Property>
    <Property>
      <Name>IsDefault</Name>
      <Value>False</Value>
    </Property>
  </Properties>
</Object>

```

### Molde sanitizado 4 - `TRNExemploF6`

- Familia coberta: `F6` (`Multinivel`).
- Fonte privada de selecao: menor XML observado entre os objetos com `3+ Level` escolhido por melhor legibilidade publica.
- Sanitizacao aplicada: nome do objeto, nomes de subniveis, textos de negocio e referencias nominais foram anonimizados; o numero de niveis, a ordem de aninhamento, `Part type`, `CDATA` e densidade estrutural foram preservados.

```xml
<?xml version="1.0" encoding="utf-8"?>
<Object parentGuid="6d11a7a7-ec1e-4146-a117-13ebbfee039d" user="SANITIZED\\USER" versionDate="0001-01-01T00:00:00.0000000" lastUpdate="2026-02-13T12:44:01.0000000Z" checksum="424d6aabdc4b36acc0cb4bf6ae7a4201" fullyQualifiedName="TRNExemploF6" moduleGuid="afa47377-41d5-4ae8-9755-6f53150aa361" guid="97c85899-a22a-48de-9109-6e0f02e24e45" name="TRNExemploF6" type="1db606f2-af09-4cf9-a3b5-b481519d28f6" description="Transacao Exemplo Multinivel" parent="TRNExemploF6" parentType="00000000-0000-0000-0000-000000000008">
  <Part type="264be5fb-1b28-4b25-a598-6ca900dd059f">
    <Level Name="TRNExemploF6" Type="TRNExemploF6" Description="Transacao Exemplo Multinivel" Guid="97c85899-a22a-48de-9109-6e0f02e24e45">
      <Properties />
      <AttributeProperties Attribute="TRNExemploF6Resumo">
        <Properties>
          <Property>
            <Name>IncludeInForms</Name>
            <Value>False</Value>
          </Property>
        </Properties>
      </AttributeProperties>
      <AttributeProperties Attribute="TRNExemploF6ResumoDeTiposDeRomaneios">
        <Properties>
          <Property>
            <Name>IncludeInForms</Name>
            <Value>False</Value>
          </Property>
        </Properties>
      </AttributeProperties>
      <AttributeProperties Attribute="TRNExemploF6ResumoDeTiposDePedidos">
        <Properties>
          <Property>
            <Name>IncludeInForms</Name>
            <Value>False</Value>
          </Property>
        </Properties>
      </AttributeProperties>
      <AttributeProperties Attribute="TRNExemploF6ResumoDeModalidadesDoFrete">
        <Properties>
          <Property>
            <Name>IncludeInForms</Name>
            <Value>False</Value>
          </Property>
        </Properties>
      </AttributeProperties>
      <AttributeProperties Attribute="TRNExemploF6InclusaoDataHora">
        <Properties>
          <Property>
            <Name>IncludeInForms</Name>
            <Value>False</Value>
          </Property>
        </Properties>
      </AttributeProperties>
      <AttributeProperties Attribute="TRNExemploF6InclusaoUsuarioId">
        <Properties>
          <Property>
            <Name>IncludeInForms</Name>
            <Value>False</Value>
          </Property>
        </Properties>
      </AttributeProperties>
      <AttributeProperties Attribute="TRNExemploF6UltimaAtualizacaoDataHora">
        <Properties>
          <Property>
            <Name>IncludeInForms</Name>
            <Value>False</Value>
          </Property>
        </Properties>
      </AttributeProperties>
      <AttributeProperties Attribute="TRNExemploF6UltimaAtualizacaoUsuarioId">
        <Properties>
          <Property>
            <Name>IncludeInForms</Name>
            <Value>False</Value>
          </Property>
        </Properties>
      </AttributeProperties>
      <Attribute key="True" guid="13f1e8b6-5e12-4ce8-bb0d-07af1c18b1d4">TRNExemploF6Codigo</Attribute>
      <Attribute key="False" guid="4bb34dd1-98b0-4506-aa0b-688bf1feda44" isNullable="True">TRNExemploF6Descricao</Attribute>
      <Attribute key="False" guid="fa5fc72d-6dab-47bc-bfd2-b19c436414cd" isNullable="True">TRNExemploF6Aplicacao</Attribute>
      <Attribute key="False" guid="8b99f008-12ee-4d5c-a771-de51f375cf4d" isNullable="True">TRNExemploF6TipoMovimento</Attribute>
      <Attribute key="False" guid="c8d211d3-155a-4ada-b50b-13f4087326e6" isNullable="True">TRNExemploF6DestinoOrigem</Attribute>
      <Attribute key="False" guid="ca4f5723-dc5b-44ec-9aea-41d36c4c5da3" isNullable="True">TRNExemploF6FabricacaoReValor02</Attribute>
      <Attribute key="False" guid="991c58ee-4ad8-4b9c-8505-62580a27dafa" isRedundant="True">TRNExemploF6Resumo</Attribute>
      <Level Name="SubNivelA" Type="SubNivelA" Description="Subnivel A" Guid="64a917e1-93c6-41b2-98c0-bfbbd8f3534a">
        <Properties />
        <DescriptionAttribute>(None)</DescriptionAttribute>
        <AttributeProperties Attribute="TRNExemploF6SubNivelATipoMovimento">
          <Properties>
            <Property>
              <Name>IncludeInForms</Name>
              <Value>False</Value>
            </Property>
          </Properties>
        </AttributeProperties>
        <Attribute key="True" guid="cd66d50c-e7db-49e6-b3b8-687c5a866bc4">TRNExemploF6SubNivelA</Attribute>
        <Attribute key="False" guid="f3328569-f769-4168-b132-c07378397aa9">TRNExemploF6SubNivelATipoMovimento</Attribute>
        <Attribute key="False" guid="3162b24d-b74b-4329-82af-c875415ba99c" isNullable="True">TRNExemploF6SubNivelATipoPedido</Attribute>
        <Attribute key="False" guid="e7bf312d-abad-4459-886f-a3466a06351d" isNullable="True">TRNExemploF6SubNivelATipoPedido2</Attribute>
        <Attribute key="False" guid="766673d6-f021-476f-8dfd-6aa5ae568402" isNullable="True">TRNExemploF6SubNivelATipoPedido3</Attribute>
      </Level>
      <Attribute key="False" guid="93d11b4f-fc89-4baa-916c-a5e9dee8df0b">TRNExemploF6ResumoDeTiposDeRomaneios</Attribute>
      <Attribute key="False" guid="15f5b4da-4853-4458-9879-9d83df9591a2">TRNExemploF6ResumoDeTiposDePedidos</Attribute>
      <Attribute key="False" guid="849d555e-de5f-4e7c-a72d-e460421fbc62" isNullable="True">TRNExemploF6CompoeTotalProFinanceiro</Attribute>
      <Attribute key="False" guid="c3509e0d-73ea-4f94-90bb-9a7bc9dd22a7" isNullable="True">TRNExemploF6DFeAdicionalCFOP</Attribute>
      <Attribute key="False" guid="cfd6b6df-d1e0-4abc-831f-caa560469fa7" isNullable="True">TRNExemploF6ParaSubstituicaoTributariaDeIcms</Attribute>
      <Attribute key="False" guid="7b319304-8db8-4773-b520-f6b3596e0eef" isNullable="True">TRNExemploF6ParaSemTransitoNoEstabelecimento</Attribute>
      <Level Name="SubNivelB" Type="SubNivelB" Description="Subnivel B" Guid="659c7bf9-81a7-43a9-ad6a-95777d322fb5">
        <Properties />
        <DescriptionAttribute>(None)</DescriptionAttribute>
        <Attribute key="True" guid="f7f07145-7537-4ade-b26c-609f4ca4a6e4">TRNExemploF6SubNivelB</Attribute>
        <Attribute key="False" guid="107ee86e-7bbc-48e4-9548-c9e25b8d6868" isNullable="True">TRNExemploF6SubNivelBObservacao</Attribute>
      </Level>
      <Attribute key="False" guid="eec831fb-63b4-4ce3-a72c-649389b6bf15">TRNExemploF6ResumoDeModalidadesDoFrete</Attribute>
      <Attribute key="False" guid="0129eda9-58d2-4379-b328-b2e6861bfb05" isNullable="True">TRNExemploF6InclusaoDataHora</Attribute>
      <Attribute key="False" guid="25c9e71f-fa83-4dad-b734-34d2cd94daf5" isNullable="True">TRNExemploF6InclusaoUsuarioId</Attribute>
      <Attribute key="False" guid="b02f55f1-03f3-428e-8f9e-521972d418ab" isNullable="True">TRNExemploF6UltimaAtualizacaoDataHora</Attribute>
      <Attribute key="False" guid="be935771-6841-4066-8da0-ad1134649b5f" isNullable="True">TRNExemploF6UltimaAtualizacaoUsuarioId</Attribute>
      <Attribute key="False" guid="3a01706f-0ed2-4388-98ab-6aed2dd77627">TRNExemploF6ResumoAtualizacao</Attribute>
    </Level>
    <Properties>
      <Property>
        <Name>IsDefault</Name>
        <Value>False</Value>
      </Property>
    </Properties>
  </Part>
  <Part type="d24a58ad-57ba-41b7-9e6e-eaca3543c778">
    <Properties>
      <Property>
        <Name>IsDefault</Name>
        <Value>True</Value>
      </Property>
      <Property>
        <Name>Defaults</Name>
        <Value>gx:TrnDefaultWebForm.dkt</Value>
      </Property>
    </Properties>
  </Part>
  <Part type="4c28dfb9-f83b-46f0-9cf3-f7e090b525d5">
    <Properties>
      <Property>
        <Name>IsDefault</Name>
        <Value>True</Value>
      </Property>
      <Property>
        <Name>Defaults</Name>
        <Value>gx:TrnDefaultWinForm.dkt</Value>
      </Property>
    </Properties>
  </Part>
  <Part type="9b0a32a3-de6d-4be1-a4dd-1b85d3741534">
    <Source><![CDATA[/* Generated by Work With Pattern [Start] - Do not change */
[web]
{
parm(in:&Mode, in:&TRNExemploF6Codigo);

TRNExemploF6Codigo = &TRNExemploF6Codigo if not &TRNExemploF6Codigo.IsEmpty();
noaccept(TRNExemploF6Codigo) if not &TRNExemploF6Codigo.IsEmpty();
noprompt(TRNExemploF6Codigo);
}
/* Generated by Work With Pattern [End] - Do not change */

&EmpresaAgora = procEmpresaDaSessaoAgora();

&SessaoUsuarioId = procLeUsuarioSessao();

[web]
{

	GridTRNExemploF6_SubNivelA.Rows = 1;
	GridTRNExemploF6_SubNivelB.Rows = 0;

	&modificado = modified() on BeforeUpdate;
	
}

[bc]
{

//	TRNExemploF6SubNivelA = SubNivelA.ValorA
//		if (TRNExemploF6SubNivelA.IsEmpty() or TRNExemploF6SubNivelA.IsNull()) and
//			not TRNExemploF6SubNivelATipoPedido.IsEmpty() and not TRNExemploF6SubNivelATipoPedido.IsNull();
	
	//em bc nao funciona modified()
	//falta observar cada campo.
	&modificado = true
	 if update 
		on BeforeUpdate;
		
}


Default(TRNExemploF6InclusaoDataHora, &EmpresaAgora);
Default(TRNExemploF6InclusaoUsuarioId, &SessaoUsuarioId);
Default(TRNExemploF6UltimaAtualizacaoDataHora, &EmpresaAgora);
Default(TRNExemploF6UltimaAtualizacaoUsuarioId, &SessaoUsuarioId);

TRNExemploF6UltimaAtualizacaoDataHora = &EmpresaAgora if update and &modificado on BeforeUpdate;
TRNExemploF6UltimaAtualizacaoUsuarioId = &SessaoUsuarioId if update and &modificado on BeforeUpdate;

Error("Erro: Data e hora de contexto nao foi determinada. ") 
	if (insert or update) and &EmpresaAgora.IsEmpty();
	
Error("Erro: Data e hora de inclusao nao foi determinada. Contexto atual: " + &EmpresaAgora.ToString()) 
	if insert and not &EmpresaAgora.IsEmpty() and
		(TRNExemploF6InclusaoDataHora.IsEmpty() or TRNExemploF6InclusaoDataHora.IsNull());

Error("Erro: Usuario da sessao nao foi determinado. ") 
	if (insert or update) and &SessaoUsuarioId.IsEmpty();
	
Error("Erro: Usuario da inclusao nao foi determinado. Usuario da sessao: " + &SessaoUsuarioId.ToString()) 
	if insert and not &SessaoUsuarioId.IsEmpty() and 
		(TRNExemploF6InclusaoUsuarioId.IsEmpty() or TRNExemploF6InclusaoUsuarioId.IsNull());

Error("Erro: Nenhuma alteracao detectada para salvar.") 
	if update and not &modificado on BeforeUpdate;


error("Erro: Codigo obrigatorio.") 
	if (insert or update) and 
	(TRNExemploF6Codigo.IsEmpty() or TRNExemploF6Codigo.IsNull());

msg("Alerta: Para ValorA de Saida ou Devolução de Saida, normalmente se define o Tipo de Pedido para DF.") 
	if (TRNExemploF6SubNivelA = SubNivelA.ValorA or
	TRNExemploF6SubNivelA = SubNivelA.ValorB) and
	TRNExemploF6SubNivelATipoPedido.IsEmpty();

error("Erro: Subnivel A é obrigatório.")
	if TRNExemploF6SubNivelA.IsEmpty() or TRNExemploF6SubNivelA.IsNull();

error("Erro: Subnivel A com um Tipo de Movimento ( " + TRNExemploF6SubNivelATipoMovimento.ToString() + 
	" ) diferente do Tipo de Movimento ( " + TRNExemploF6TipoMovimento.ToString() + " ) indicado na Transacao Exemplo Multinivel.") 
	if not TRNExemploF6TipoMovimento.IsEmpty() and not TRNExemploF6TipoMovimento.IsNull() and
	not TRNExemploF6SubNivelA.IsEmpty() and not TRNExemploF6SubNivelA.IsNull() and
	TRNExemploF6SubNivelATipoMovimento <> TRNExemploF6TipoMovimento;

msg('Alerta Extremo: "Romaneio de ValorA de Saida" não deverá realmente ser criado para "Valor02 de Entrega Futura".')
	if TRNExemploF6SubNivelA = SubNivelA.ValorA and
	TRNExemploF6SubNivelATipoPedido = EnumTipoPedidoExemplo.Valor01;
	
error("Erro: Tipo de Pedido ( " + TRNExemploF6SubNivelATipoPedido.ToString() + 
	" ) é inválido para Romaneio de ValorA de Saida.")
	if TRNExemploF6SubNivelA = SubNivelA.ValorA and
	not TRNExemploF6SubNivelATipoPedido.IsEmpty() and not TRNExemploF6SubNivelATipoPedido.IsNull() and
	TRNExemploF6SubNivelATipoPedido <> EnumTipoPedidoExemplo.Valor02 and
	TRNExemploF6SubNivelATipoPedido <> EnumTipoPedidoExemplo.Valor01 and
	TRNExemploF6SubNivelATipoPedido <> EnumTipoPedidoExemplo.Valor03 and
	TRNExemploF6SubNivelATipoPedido <> EnumTipoPedidoExemplo.Valor04 and
	TRNExemploF6SubNivelATipoPedido <> EnumTipoPedidoExemplo.Valor05 and
	TRNExemploF6SubNivelATipoPedido <> EnumTipoPedidoExemplo.Valor06 and
	TRNExemploF6SubNivelATipoPedido <> EnumTipoPedidoExemplo.Valor07 and
	TRNExemploF6SubNivelATipoPedido <> EnumTipoPedidoExemplo.Valor08 and
	TRNExemploF6SubNivelATipoPedido <> EnumTipoPedidoExemplo.Valor09 and
	TRNExemploF6SubNivelATipoPedido <> EnumTipoPedidoExemplo.Valor10 and
	TRNExemploF6SubNivelATipoPedido <> EnumTipoPedidoExemplo.Valor11 and
	TRNExemploF6SubNivelATipoPedido <> EnumTipoPedidoExemplo.Valor12 and
	TRNExemploF6SubNivelATipoPedido <> EnumTipoPedidoExemplo.Valor13 and
	TRNExemploF6SubNivelATipoPedido <> EnumTipoPedidoExemplo.Valor14 and
	TRNExemploF6SubNivelATipoPedido <> EnumTipoPedidoExemplo.Valor15;

error("Erro: Tipo de Pedido 2 ( " + TRNExemploF6SubNivelATipoPedido2.ToString() + 
	" ) é inválido para Romaneio de ValorA de Saida.")
	if TRNExemploF6SubNivelA = SubNivelA.ValorA and
	not TRNExemploF6SubNivelATipoPedido2.IsEmpty() and not TRNExemploF6SubNivelATipoPedido2.IsNull() and
	TRNExemploF6SubNivelATipoPedido2 <> EnumTipoPedidoExemplo.Valor02 and
	TRNExemploF6SubNivelATipoPedido2 <> EnumTipoPedidoExemplo.Valor03 and
	TRNExemploF6SubNivelATipoPedido2 <> EnumTipoPedidoExemplo.Valor04 and
	TRNExemploF6SubNivelATipoPedido2 <> EnumTipoPedidoExemplo.Valor05 and
	TRNExemploF6SubNivelATipoPedido2 <> EnumTipoPedidoExemplo.Valor06 and
	TRNExemploF6SubNivelATipoPedido2 <> EnumTipoPedidoExemplo.Valor07 and
	TRNExemploF6SubNivelATipoPedido2 <> EnumTipoPedidoExemplo.Valor08 and
	TRNExemploF6SubNivelATipoPedido2 <> EnumTipoPedidoExemplo.Valor09 and
	TRNExemploF6SubNivelATipoPedido2 <> EnumTipoPedidoExemplo.Valor10 and
	TRNExemploF6SubNivelATipoPedido2 <> EnumTipoPedidoExemplo.Valor11 and
	TRNExemploF6SubNivelATipoPedido2 <> EnumTipoPedidoExemplo.Valor12 and
	TRNExemploF6SubNivelATipoPedido2 <> EnumTipoPedidoExemplo.Valor13 and
	TRNExemploF6SubNivelATipoPedido2 <> EnumTipoPedidoExemplo.Valor14 and
	TRNExemploF6SubNivelATipoPedido2 <> EnumTipoPedidoExemplo.Valor15;
error("Erro: Tipo de Pedido 3 ( " + TRNExemploF6SubNivelATipoPedido3.ToString() + 
	" ) é inválido para Romaneio de ValorA de Saida.")
	if TRNExemploF6SubNivelA = SubNivelA.ValorA and
	not TRNExemploF6SubNivelATipoPedido3.IsEmpty() and not TRNExemploF6SubNivelATipoPedido3.IsNull() and
	TRNExemploF6SubNivelATipoPedido3 <> EnumTipoPedidoExemplo.Valor02 and
	TRNExemploF6SubNivelATipoPedido3 <> EnumTipoPedidoExemplo.Valor03 and
	TRNExemploF6SubNivelATipoPedido3 <> EnumTipoPedidoExemplo.Valor04 and
	TRNExemploF6SubNivelATipoPedido3 <> EnumTipoPedidoExemplo.Valor05 and
	TRNExemploF6SubNivelATipoPedido3 <> EnumTipoPedidoExemplo.Valor06 and
	TRNExemploF6SubNivelATipoPedido3 <> EnumTipoPedidoExemplo.Valor07 and
	TRNExemploF6SubNivelATipoPedido3 <> EnumTipoPedidoExemplo.Valor08 and
	TRNExemploF6SubNivelATipoPedido3 <> EnumTipoPedidoExemplo.Valor09 and
	TRNExemploF6SubNivelATipoPedido3 <> EnumTipoPedidoExemplo.Valor10 and
	TRNExemploF6SubNivelATipoPedido3 <> EnumTipoPedidoExemplo.Valor11 and
	TRNExemploF6SubNivelATipoPedido3 <> EnumTipoPedidoExemplo.Valor12 and
	TRNExemploF6SubNivelATipoPedido3 <> EnumTipoPedidoExemplo.Valor13 and
	TRNExemploF6SubNivelATipoPedido3 <> EnumTipoPedidoExemplo.Valor14 and
	TRNExemploF6SubNivelATipoPedido3 <> EnumTipoPedidoExemplo.Valor15;

error("Erro: Tipo de Pedido ( " + TRNExemploF6SubNivelATipoPedido.ToString() + 
	" ) é inválido para Romaneio de Devolução de Saida.")
	if TRNExemploF6SubNivelA = SubNivelA.ValorB and
	not TRNExemploF6SubNivelATipoPedido.IsEmpty() and not TRNExemploF6SubNivelATipoPedido.IsNull() and
	TRNExemploF6SubNivelATipoPedido <> EnumTipoPedidoExemplo.Valor02 and
	TRNExemploF6SubNivelATipoPedido <> EnumTipoPedidoExemplo.Valor10 and
	TRNExemploF6SubNivelATipoPedido <> EnumTipoPedidoExemplo.Valor13 and
	TRNExemploF6SubNivelATipoPedido <> EnumTipoPedidoExemplo.Valor14 and
	TRNExemploF6SubNivelATipoPedido <> EnumTipoPedidoExemplo.Valor06 and
	TRNExemploF6SubNivelATipoPedido <> EnumTipoPedidoExemplo.Valor04 and
	TRNExemploF6SubNivelATipoPedido <> EnumTipoPedidoExemplo.Valor03 and
	TRNExemploF6SubNivelATipoPedido <> EnumTipoPedidoExemplo.Valor05;
error("Erro: Tipo de Pedido 2 ( " + TRNExemploF6SubNivelATipoPedido2.ToString() + 
	" ) é inválido para Romaneio de Devolução de Saida.")
	if TRNExemploF6SubNivelA = SubNivelA.ValorB and
	not TRNExemploF6SubNivelATipoPedido2.IsEmpty() and not TRNExemploF6SubNivelATipoPedido2.IsNull() and
	TRNExemploF6SubNivelATipoPedido2 <> EnumTipoPedidoExemplo.Valor02 and
	TRNExemploF6SubNivelATipoPedido2 <> EnumTipoPedidoExemplo.Valor10 and
	TRNExemploF6SubNivelATipoPedido2 <> EnumTipoPedidoExemplo.Valor13 and
	TRNExemploF6SubNivelATipoPedido2 <> EnumTipoPedidoExemplo.Valor14 and
	TRNExemploF6SubNivelATipoPedido2 <> EnumTipoPedidoExemplo.Valor06 and
	TRNExemploF6SubNivelATipoPedido2 <> EnumTipoPedidoExemplo.Valor04 and
	TRNExemploF6SubNivelATipoPedido2 <> EnumTipoPedidoExemplo.Valor03 and
	TRNExemploF6SubNivelATipoPedido2 <> EnumTipoPedidoExemplo.Valor05;
error("Erro: Tipo de Pedido 3 ( " + TRNExemploF6SubNivelATipoPedido3.ToString() + 
	" ) é inválido para Romaneio de Devolução de Saida.")
	if TRNExemploF6SubNivelA = SubNivelA.ValorB and
	not TRNExemploF6SubNivelATipoPedido3.IsEmpty() and not TRNExemploF6SubNivelATipoPedido3.IsNull() and
	TRNExemploF6SubNivelATipoPedido3 <> EnumTipoPedidoExemplo.Valor02 and
	TRNExemploF6SubNivelATipoPedido3 <> EnumTipoPedidoExemplo.Valor10 and
	TRNExemploF6SubNivelATipoPedido3 <> EnumTipoPedidoExemplo.Valor13 and
	TRNExemploF6SubNivelATipoPedido3 <> EnumTipoPedidoExemplo.Valor14 and
	TRNExemploF6SubNivelATipoPedido3 <> EnumTipoPedidoExemplo.Valor06 and
	TRNExemploF6SubNivelATipoPedido3 <> EnumTipoPedidoExemplo.Valor04 and
	TRNExemploF6SubNivelATipoPedido3 <> EnumTipoPedidoExemplo.Valor03 and
	TRNExemploF6SubNivelATipoPedido3 <> EnumTipoPedidoExemplo.Valor05;

error("Erro: Pedido de Compra de Gado vale apenas para Romaneio de Abate ou de Devolução de Compra.") 
	if TRNExemploF6SubNivelATipoPedido = EnumTipoPedidoExemplo.Valor16 and
		TRNExemploF6SubNivelA <> SubNivelA.Valor17 and
		TRNExemploF6SubNivelA <> SubNivelA.Valor18 and
		TRNExemploF6SubNivelA <> SubNivelA.Valor19 and
		TRNExemploF6SubNivelA <> SubNivelA.DevolucaoValor19;

//default(TRNExemploF6SubNivelB, EnumSubNivelBExemplo.SemFiltro);
]]></Source>
    <Properties>
      <Property>
        <Name>IsDefault</Name>
        <Value>False</Value>
      </Property>
    </Properties>
  </Part>
  <Part type="c44bd5ff-f918-415b-98e6-aca44fed84fa">
    <Source><![CDATA[//Event Start
Event Start
	
	[web]
	{
		
		//if &Mode = TrnMode.Insert
		if &Mode = TrnMode.Insert
			
			TRNExemploF6ResumoAtualizacao.Visible = false
			
		endif
		
	}
	/* Generated by Work With Pattern [Start] - Do not change */
	[web]
	{
	If not IsAuthorized(&PgmName)
		NotAuthorized(&PgmName)
	Endif
	
	&TrnContext.FromXml(&WebSession.Get(!"TrnContext"))
	
	If &Mode = TrnMode.Delete
		btn_Enter.Caption = "GX_BtnDelete"
		btn_Enter.TooltipText = "GX_BtnDelete"
	EndIf
	}
	/* Generated by Work With Pattern [End] - Do not change */
EndEvent

Event After Trn
	/* Generated by Work With Pattern [Start] - Do not change */
	[web]
	{
	If (&Mode = TrnMode.Delete and not &TrnContext.CallerOnDelete)
		WWTRNExemploF6()
	Endif
	
	Return
	}
	/* Generated by Work With Pattern [End] - Do not change */
EndEvent

]]></Source>
    <Properties>
      <Property>
        <Name>IsDefault</Name>
        <Value>False</Value>
      </Property>
    </Properties>
  </Part>
  <Part type="e4c4ade7-53f0-4a56-bdfd-843735b66f47">
    <Variable Name="Context">
      <Documentation />
      <Properties>
        <Property>
          <Name>Name</Name>
          <Value>Context</Value>
        </Property>
        <Property>
          <Name>ATTCUSTOMTYPE</Name>
          <Value>sdt:Context</Value>
        </Property>
        <Property>
          <Name>ATT_INITIAL_VALUE</Name>
          <Value>LoadContext.udp()</Value>
        </Property>
      </Properties>
    </Variable>
    <Variable Name="IsAuthorized">
      <Documentation />
      <Properties>
        <Property>
          <Name>Name</Name>
          <Value>IsAuthorized</Value>
        </Property>
        <Property>
          <Name>ATTCUSTOMTYPE</Name>
          <Value>bas:Boolean</Value>
        </Property>
      </Properties>
    </Variable>
    <Variable Name="TRNExemploF6Codigo">
      <Documentation />
      <Properties>
        <Property>
          <Name>Name</Name>
          <Value>TRNExemploF6Codigo</Value>
        </Property>
        <Property>
          <Name>idBasedOn</Name>
          <Value>Attribute:TRNExemploF6Codigo</Value>
        </Property>
      </Properties>
    </Variable>
    <Variable Name="TrnContext">
      <Documentation />
      <Properties>
        <Property>
          <Name>Name</Name>
          <Value>TrnContext</Value>
        </Property>
        <Property>
          <Name>ATTCUSTOMTYPE</Name>
          <Value>sdt:TransactionContext</Value>
        </Property>
      </Properties>
    </Variable>
    <Variable Name="WebSession">
      <Documentation />
      <Properties>
        <Property>
          <Name>Name</Name>
          <Value>WebSession</Value>
        </Property>
        <Property>
          <Name>ATTCUSTOMTYPE</Name>
          <Value>ext:WebSession</Value>
        </Property>
      </Properties>
    </Variable>
    <Variable Name="EmpresaAgora">
      <Documentation />
      <Properties>
        <Property>
          <Name>Name</Name>
          <Value>EmpresaAgora</Value>
        </Property>
        <Property>
          <Name>Description</Name>
          <Value>Empresa Agora</Value>
        </Property>
        <Property>
          <Name>idBasedOn</Name>
          <Value>Domain:DataHoraCompleta</Value>
        </Property>
      </Properties>
    </Variable>
    <Variable Name="modificado">
      <Documentation />
      <Properties>
        <Property>
          <Name>Name</Name>
          <Value>modificado</Value>
        </Property>
        <Property>
          <Name>idBasedOn</Name>
          <Value>Domain:Logico</Value>
        </Property>
      </Properties>
    </Variable>
    <Variable Name="SessaoUsuarioId">
      <Documentation />
      <Properties>
        <Property>
          <Name>Name</Name>
          <Value>SessaoUsuarioId</Value>
        </Property>
        <Property>
          <Name>Description</Name>
          <Value>Usuario Id</Value>
        </Property>
        <Property>
          <Name>idBasedOn</Name>
          <Value>Attribute:UsuarioId</Value>
        </Property>
      </Properties>
    </Variable>
    <Properties>
      <Property>
        <Name>IsDefault</Name>
        <Value>False</Value>
      </Property>
    </Properties>
  </Part>
  <Part type="ad3ca970-19d0-44e1-a7b7-db05556e820c">
    <Help>
      <HelpItem>
        <Language>88313f43-5eb2-0000-0028-e8d9f5bf9588-Portuguese</Language>
        <Content />
      </HelpItem>
    </Help>
    <Properties>
      <Property>
        <Name>IsDefault</Name>
        <Value>False</Value>
      </Property>
    </Properties>
  </Part>
  <Part type="babf62c5-0111-49e9-a1c3-cc004d90900a">
    <InnerHtml><![CDATA[]]></InnerHtml>
    <Properties>
      <Property>
        <Name>IsDefault</Name>
        <Value>False</Value>
      </Property>
    </Properties>
  </Part>
  <Properties>
    <Property>
      <Name>Name</Name>
      <Value>TRNExemploF6</Value>
    </Property>
    <Property>
      <Name>Description</Name>
      <Value>Transacao Exemplo Multinivel</Value>
    </Property>
    <Property>
      <Name>idISBUSINESSCOMPONENT</Name>
      <Value>True</Value>
    </Property>
    <Property>
      <Name>MasterPage</Name>
      <Value>MasterPageExemplo</Value>
    </Property>
    <Property>
      <Name>SEARCH_VIEWER</Name>
      <Value>c9584656-94b6-4ccd-890f-332d11fc2c25-ViewTRNExemploF6</Value>
    </Property>
    <Property>
      <Name>Apply:78cecefe-be7d-4980-86ce-8d6e91fba04b</Name>
      <Value>True</Value>
    </Property>
    <Property>
      <Name>IsDefault</Name>
      <Value>False</Value>
    </Property>
  </Properties>
</Object>


```
