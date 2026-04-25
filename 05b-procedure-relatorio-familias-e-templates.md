# 05b - Procedure Relatorio Familias e Templates

## Papel do documento
empirico e operacional

## Nivel de confianca predominante
medio

## Depende de
01-base-empirica-geral.md, 02-regras-operacionais-e-runtime.md, 03-risco-e-decisao-por-tipo.md

## Usado por
08-guia-para-agente-gpt.md, 09-inventario-e-rastreabilidade-publica.md

## Objetivo
Concentrar familias estruturais de `Procedure` de relatorio observadas no acervo, regras por familia e validacoes de consistencia interna para clonagem controlada.

---

## Sanitizacao deste documento

- Evidencia direta: os nomes reais dos objetos usados como representantes nao aparecem aqui.
- Evidencia direta: cada template representativo recebeu um alias publico, como `PRCRelatorioExemploF1`, `PRCRelatorioExemploF2` e assim por diante.
- Inferencia forte: para uso interno, o template correspondente pode ser reencontrado pelo criterio estrutural indicado em cada familia.
- Hipotese: essa estrategia preserva utilidade operacional sem expor nomes de negocio da KB.

---

## Metodo

- Evidencia direta: foram analisados 77 XMLs de `Procedure` com nome comecanado com o prefixo de relatorio observado no acervo da KB.
- Evidencia direta: todos os 77 objetos usam o mesmo `Object/@type` (`84a12160-f59b-4ad7-a683-ea4481ac23e9`) e o mesmo inventario de 7 `Part` recorrentes.
- Evidencia direta: o `Part` de codigo-fonte usa `type="528d1c06-a9c2-420d-bd35-21dca83f12ff"`.
- Evidencia direta: o `Part` de layout usa `type="c414ed00-8cc4-4f44-8820-4baf93547173"`, sempre com estrutura de `<Bands><PrintBlock>`.
- Evidencia direta: nenhum dos 77 objetos apresentou subroutine interna (`Sub`) no `Source` observado.
- Evidencia direta: o agrupamento abaixo usa contagem de `PrintBlock` no `Part` de layout, presenca de `Header`/`Footer` no `Part` de fonte e contagem de `For each` no `Source`.
- Evidencia direta: os tamanhos de arquivo variam de 7.161 bytes ate 1.115.994 bytes no acervo observado.
- Inferencia forte: para `Procedure` de relatorio, a familia estrutural e mais discriminante do que o nome do objeto.

---

## Visao geral

- Evidencia direta: 3 dos 77 objetos nao apresentam `Header` nem `Footer` no `Source` e nenhum `For each` — familia embrionaria.
- Evidencia direta: 6 dos 77 objetos nao apresentam `For each` mas possuem `Header` e/ou `Footer` — familia de molde base.
- Evidencia direta: aproximadamente 29 dos 77 objetos possuem 1 ou 2 `For each` — familia de listagem linear simples.
- Evidencia direta: aproximadamente 22 dos 77 objetos possuem 3 a 6 `For each` com ate 24 `PrintBlock` — familia de agrupamento e totalizacao.
- Evidencia direta: aproximadamente 17 dos 77 objetos possuem 7 ou mais `For each` ou 25 ou mais `PrintBlock` — familia de alto volume e complexidade.
- Inferencia forte: a separacao mais util para geracao pratica nao e por semantica de negocio, mas por presenca de iteracao, complexidade de agrupamento e tamanho do layout.
- Inferencia forte: o principal erro a evitar em `Procedure` de relatorio e misturar familias diferentes durante a clonagem — em especial substituir um F4/F5 por um F1/F2 sem ajustar o `Source` e o inventario de `PrintBlock`.

---

## Familia 1 — Embriao sem layout ativo

- Evidencia direta: 3 objetos sem `For each`, sem `Header` e sem `Footer` no `Source`.
- Evidencia direta: tamanho medio aproximado de 26.759 bytes; minimo 7.161; maximo 65.924.
- Evidencia direta: contagem de `PrintBlock` varia de 1 a 5 nos representantes observados.
- Inferencia forte: esses objetos sao cascas pre-inicializadas ou stubs sem corpo de impressao ativo ainda definido.
- Template base publico: `PRCRelatorioExemploF1`.
- Criterio privado de selecao: menor XML observado dentro da faixa sem `For each` + sem `Header` + sem `Footer`.
- Justificativa da escolha: representa a casca mais enxuta de `Procedure` de relatorio sem iteracao nem cabecalho de pagina.

### Assinatura estrutural

- 0 `For each` no `Source`
- sem `Header` e sem `Footer` no `Source`
- 1 a 5 `PrintBlock` no layout
- `Part` de fonte e de layout presentes (7 `Part` total, uniforme)
- XML compacto, abaixo de 70.000 bytes

---

## Familia 2 — Molde base com cabecalho de pagina

- Evidencia direta: 6 objetos sem `For each` mas com pelo menos um dos blocos `Header` ou `Footer` no `Source`.
- Evidencia direta: tamanho medio aproximado de 50.000 bytes; minimo 15.148; maximo 90.389.
- Evidencia direta: contagem de `PrintBlock` varia de 4 a 8.
- Evidencia direta: dois representantes observados indicam explicitamente orientacao no nome ou no conteudo do layout (retrato e paisagem); os demais sao neutros.
- Inferencia forte: essa familia e o ponto de partida para novos relatorios que precisam de cabecalho e rodape de pagina mas ainda nao iteraram sobre dados.
- Template base publico: `PRCRelatorioExemploF2`.
- Criterio privado de selecao: menor XML observado dentro da faixa sem `For each` + com pelo menos um dos blocos `Header`/`Footer`.
- Justificativa da escolha: representa o molde mais simples com estrutura de pagina funcional, sem iteracao ainda.

### Assinatura estrutural

- 0 `For each` no `Source`
- `Header` e/ou `Footer` presentes no `Source`
- 4 a 8 `PrintBlock` no layout
- `Part` de fonte e de layout presentes (7 `Part` total)
- Tamanho entre 15.000 e 90.000 bytes
- Nao confundir com F1: a presenca de `Header`/`Footer` distingue as duas familias

---

## Familia 3 — Listagem linear simples

- Evidencia direta: aproximadamente 29 objetos com 1 ou 2 `For each` no `Source`.
- Evidencia direta: tamanho medio aproximado de 200.000 bytes; minimo 30.819; maximo 580.000.
- Evidencia direta: contagem de `PrintBlock` varia tipicamente de 2 a 16.
- Evidencia direta: a maioria possui `Header` e `Footer` de pagina; uma minoria nessa faixa carece de um ou dos dois blocos.
- Inferencia forte: o `For each` principal itera sobre a tabela de dados sem grupos secundarios ou subtotais estruturais relevantes.
- Template base publico: `PRCRelatorioExemploF3`.
- Criterio privado de selecao: menor XML observado dentro da faixa 1 a 2 `For each`.
- Justificativa da escolha: representa a listagem mais enxuta com iteracao simples, servindo de base para relatorios de lista sem agrupamento.

### Assinatura estrutural

- 1 ou 2 `For each` no `Source`
- Tipicamente `Header` e `Footer` presentes no `Source`
- 2 a 16 `PrintBlock` no layout
- `Part` de fonte e de layout presentes (7 `Part` total)
- Sem blocos de subtotal estrutural aparente (inferencia a confirmar por inspeção do representante)
- Tamanho variavel; representante esta abaixo de 35.000 bytes

---

## Familia 4 — Relatorio com agrupamento e totalizacao

- Evidencia direta: aproximadamente 22 objetos com 3 a 6 `For each` e ate 24 `PrintBlock`.
- Evidencia direta: tamanho medio aproximado de 310.000 bytes; minimo 84.489; maximo 872.615.
- Inferencia forte: a presenca de multiplos `For each` indica agrupamento com niveis distintos ou iteracoes paralelas de dados relacionados.
- Evidencia direta: `Header` e `Footer` estao presentes na quase totalidade dos objetos desta familia.
- Evidencia direta: alguns representantes indicam orientacao paisagem no nome ou conteudo; a maioria e neutra ou retrato.
- Template base publico: `PRCRelatorioExemploF4`.
- Criterio privado de selecao: menor XML observado dentro da faixa 3 a 6 `For each` com ate 24 `PrintBlock`.
- Justificativa da escolha: representa o caso mais enxuto de agrupamento com multiplas iteracoes, preservando H+F e orientacao paisagem explicita.

### Assinatura estrutural

- 3 a 6 `For each` no `Source`
- `Header` e `Footer` presentes no `Source`
- 5 a 24 `PrintBlock` no layout
- `Part` de fonte e de layout presentes (7 `Part` total)
- Tamanho tipicamente acima de 84.000 bytes

---

## Familia 5 — Relatorio complexo de alto volume

- Evidencia direta: aproximadamente 17 objetos com 7 ou mais `For each` ou 25 ou mais `PrintBlock`.
- Evidencia direta: tamanho medio estimado acima de 400.000 bytes; maximo observado 1.115.994 bytes.
- Evidencia direta: `PrintBlock` varia de 5 ate 51; alguns representantes de alto `For each` possuem layout surpreendentemente compacto (5 a 13 `PrintBlock`), indicando reutilizacao intensa de blocos de impressao.
- Inferencia forte: a densidade de `For each` nessa faixa sugere niveis multiplos de agrupamento, iteracoes cruzadas ou acumuladores nao triviais que exigem analise do `Source` antes de qualquer clonagem.
- Template base publico: `PRCRelatorioExemploF5`.
- Criterio privado de selecao: menor XML observado com pelo menos 10 `For each` e pelo menos 20 `PrintBlock`, priorizando o representante mais compacto ainda coberto pelos dois criterios simultaneamente.
- Justificativa da escolha: representa a faixa de alta complexidade sem ser o maior do acervo, permitindo analise do `Source` sem custo proibitivo de leitura.

### Assinatura estrutural

- 7 ou mais `For each` no `Source`, OU 25 ou mais `PrintBlock` no layout
- `Header` e `Footer` presentes na quase totalidade
- `PrintBlock` de 5 a 51 (alta variabilidade interna)
- `Part` de fonte e de layout presentes (7 `Part` total)
- Tamanho acima de 100.000 bytes; tipicamente acima de 250.000 bytes

---

## Como escolher a familia

| Criterio primario | Familia recomendada |
|---|---|
| Nenhum `For each`, sem `Header`/`Footer` | F1 |
| Nenhum `For each`, com `Header`/`Footer` | F2 |
| 1 ou 2 `For each` | F3 |
| 3 a 6 `For each`, ate 24 `PrintBlock` | F4 |
| 7+ `For each` ou 25+ `PrintBlock` | F5 |

- Se o objeto alvo nao existir ainda no acervo, preferir clonar o representante da familia mais proxima ao criterio estrutural.
- Se o objeto alvo ja existir no acervo, usar primeiro o molde sanitizado canonico da familia mais proxima quando o caso couber no perfil simples documentado desta base.
- Escalar para XML real comparavel apenas quando o pedido fugir da familia simples coberta pelos moldes, quando houver falha estrutural repetida de importacao, ou quando surgir sinal claro de dialeto/localismo da KB.
- Nunca assumir que um objeto de nome simples pertence a F1 ou F2 sem verificar `For each` e `Header`/`Footer` no `Source`.

---

## Moldes canonicos para relatorio simples

- Regra operacional: para `Procedure` de relatorio simples, o caminho primario desta trilha passa a ser molde sanitizado canonico forte, nao leitura obrigatoria imediata do acervo real.
- Regra operacional: esse caminho barato e rapido vale apenas para familias simples ja cobertas por XML completo e sanitizado suficiente para materializacao controlada.
- Regra operacional: todo handoff deve rotular explicitamente a base usada em uma destas quatro categorias: `molde sanitizado`, `XML real da KB atual`, `XML real de outra KB` ou `hipotese`.
- Evidencia direta: a familia `F2` ja representa o menor perfil com pagina funcional sem iteracao.
- Evidencia direta: a familia `F3` ja representa a menor listagem linear com iteracao simples.
- Inferencia forte: esses dois perfis cobrem o caso comum pedido pelo outro agente para relatorio simples.

### Cobertura minima que o molde canonico deve expor

- variante simples em retrato
- variante simples em paisagem
- shape minimo completo do `Part` `c414ed00-8cc4-4f44-8820-4baf93547173`
- `Bands`, `PrintBlock` e relacao com `print printBlock...`
- `RPT_INTERNAL_NAME` coerente entre `Source` e layout
- exemplo minimo de `Output_file`
- exemplo minimo de `parm(...)` em `Rules`
- exemplo minimo de `ReportLabel`
- exemplo minimo de `ReportAttribute`
- variante com atributos diretos
- variante com variaveis

### Shape minimo por camada

- `Source`: declarar fluxo de impressao, blocos `Header`/`Footer` quando existirem, comandos `print printBlock...`, `for each` quando a familia exigir, e chamada `Output_file` quando o caso pedir saida em arquivo.
- `Rules`: declarar `parm(...)` e apenas regras sintaticamente proprias dessa camada.
- layout `Part c414ed00-8cc4-4f44-8820-4baf93547173`: materializar `Bands`, `PrintBlock`, `ReportLabel`, `ReportAttribute` e metadado estrutural do relatorio.
- Regra operacional: o layout nao deve ser inventado como GXML livre, lista arbitraria de controles ou shape textual plausivel; ele precisa seguir shape comprovado de `Bands` e `PrintBlock`.
- Regra operacional: `RPT_INTERNAL_NAME`, nomes de `PrintBlock` e referencias usadas em `print printBlock...` devem permanecer coerentes entre as tres camadas.

### Gramatica explicita por `Part`

- `Source`: aceita comandos procedurais de relatorio e impressao; nao deve receber declaracao de `parm(...)` nem shape de layout serializado.
- `Rules`: aceita `parm(...)` e regras da camada; nao deve receber `Output_file`, `print`, `Header`, `Footer`, `For each` nem desenho de banda.
- layout: aceita `Bands`, `PrintBlock`, `ReportLabel`, `ReportAttribute` e metadado visual; nao deve receber pseudo-source procedural.
- Regra operacional: `;` em `Rules` continua marcador sensivel de fechamento quando a gramatica da regra exigir; erro dessa camada deve ser lido como problema de `Rules`, nao de `Source`.
- Regra operacional: `;` rejeitado em `Source` de relatorio deve ser tratado como problema de dialeto/sintaxe do `Source`, nao como defeito do layout.
- Regra operacional: fica proibido misturar `GXML` inventado, controles nao comprovados e shapes nao observados no corpus como tentativa de "completar" relatorio.

### Esqueleto minimo documentado

```text
Source:
  Header
    print PB_HEADER
  EndHeader

  For each
    print PB_DETAIL
  EndFor

  Footer
    print PB_FOOTER
  EndFooter

Rules:
  parm(in:&DataInicial, in:&DataFinal);

Layout:
  Bands
    PrintBlock PB_HEADER -> ReportLabel
    PrintBlock PB_DETAIL -> ReportAttribute / ReportLabel
    PrintBlock PB_FOOTER -> ReportLabel
```

- Regra operacional: o bloco acima e apenas mapa de camadas; a materializacao final continua exigindo XML completo comprovado pelo molde sanitizado correspondente.

### Variantes minimas que a base deve sustentar

- `F2-retrato`: sem `For each`, com `Header` e/ou `Footer`, orientacao retrato, `Output_file` opcional.
- `F2-paisagem`: sem `For each`, com `Header` e/ou `Footer`, orientacao paisagem, mesmo shape estrutural minimo.
- `F3-atributos-diretos`: `For each` simples, `ReportAttribute` apontando para atributos diretos do cursor principal.
- `F3-variaveis`: `For each` simples ou pre-processamento curto, `ReportAttribute` apontando para variaveis previamente carregadas.

### Fallback estruturado

- Passo 1: tentar o molde sanitizado canonico mais proximo da familia simples.
- Passo 2: se o pedido sair do perfil simples coberto, marcar a diferenca estrutural e escalar para XML real comparavel.
- Passo 3: se a importacao falhar com erro estrutural de shape, layout ou sintaxe de camada, revisar a camada suspeita uma vez e tentar pacote corretivo minimo.
- Passo 4: depois de uma ou duas falhas estruturais, parar de inventar e buscar XML real comparavel, registrando a escalada explicitamente.
- Passo 5: se aparecer sinal de dialeto/localismo da KB, abandonar o molde canonico como fonte suficiente e escalar para XML real comparavel da KB alvo.

### Sinais tipicos de dialeto/localismo

- assinatura de `parm(...)` ou regra de relatorio fora do padrao simples documentado
- convencao interna de nomes, bandas ou `PrintBlock` nao coberta pelos moldes canonicos
- uso de recurso de layout, propriedade ou shape ausente nos representantes sanitizados desta base
- erro de importacao que sugira incompatibilidade local e nao apenas shape minimo incompleto

### Playbook curto de depuracao

- `src0212 invalid control`: suspeitar primeiro do layout e do shape do `Part c414...`; revisar `Bands`, `PrintBlock`, tipo de controle e coerencia entre bloco impresso e bloco materializado.
- `src0201 output_file invalid type`: revisar se `Output_file` ficou na camada correta e com assinatura coerente com o dialeto aceito no `Source`.
- `src0119 ';' not longer supported`: revisar `Source`; remover sintaxe herdada ou transplante indevido de `Rules`.
- `src0056 Missed ';' at the end of the rule`: revisar `Rules`; tratar como fechamento faltante de regra, nao como defeito do `Source`.
- erro que mencione `printBlock`, `ReportLabel`, `ReportAttribute` ou controle invalido: revisar o layout antes de mexer em envelope.
- erro que mencione `parm`, regra ou fechamento de regra: revisar `Rules` antes de mexer no layout.
- erro que mencione `For each`, `Header`, `Footer`, `Output_file` ou funcao procedural: revisar `Source` antes de mexer no layout.

### Regra editorial de uso

- Regra editorial: nunca usar resumo textual deste documento como unica fonte para materializacao de XML.
- Regra editorial: para familias simples cobertas nesta base, o agente pode materializar a partir de molde sanitizado canonico completo sem exigir leitura inicial do XML real da KB.
- Regra editorial: quando o caso sair da cobertura simples documentada, o proximo passo obrigatorio e XML real comparavel, nao improvisacao adicional.

---

## Erros a evitar em clonagem

- Inferencia forte: clonar um F2 como base para um F4 sem ajustar o `Source` e o inventario de `PrintBlock` resultara em estrutura incompleta que nao imprimira corretamente.
- Inferencia forte: copiar um F5 para gerar um F3 carrega blocos e iteracoes desnecessarios que podem causar erros de compilacao por referencias ausentes.
- Hipotese: a maioria dos relatorios de producao desta KB pertence a F3 ou F4, o que torna esses moldes os mais frequentemente necessarios em novas frentes.
- Regra operacional: nao insistir em terceira tentativa estrutural por analogia; depois de uma ou duas falhas estruturais, escalar para XML real comparavel.
