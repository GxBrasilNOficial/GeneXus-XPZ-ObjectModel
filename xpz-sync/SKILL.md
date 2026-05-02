---
name: xpz-sync
description: Executa sincronização ou conferência de XPZ de uma KB GeneXus chamando os scripts locais do repositório ativo
---

# xpz-sync

Invoca os scripts locais do repositório GeneXus ativo para sincronizar XMLs individuais a partir de um XPZ exportado pela IDE, ou para conferir um export completo da KB.

---

## GUIDELINE

Identificar a raiz do repositório pelo contexto, localizar os scripts de sincronização na pasta `scripts\`, montar o comando correto e executá-lo via Bash. Reportar o resultado de forma clara. Não alterar arquivos manualmente — delegar tudo ao script. Tratar `ObjetosDaKbEmXml` como snapshot oficial somente leitura para agentes e não antecipar manualmente nenhuma promoção para esse acervo. Distinguir sempre a pasta nativa da KB da pasta paralela da KB. Se houver edição detectada ou pretendida em `ObjetosDaKbEmXml` para delta ainda não reexportado oficialmente pela KB, tratar isso como erro explícito de processo.

- `ObjetosDaKbEmXml` é o snapshot oficial da KB e nunca deve ser alterado manualmente pelo agente.
- `ObjetosDaKbEmXml` só pode ser atualizado pelo fluxo oficial de `sync`, a partir de `XPZ` exportado pela IDE do GeneXus.
- XML gerado localmente para importação, mesmo após preview ou importação bem-sucedida, nunca deve ser promovido manualmente para `ObjetosDaKbEmXml`.
- Enquanto o delta ainda não tiver retornado em `XPZ` oficial da KB, o trabalho deve permanecer em `ObjetosGeradosParaImportacaoNaKbNoGenexus`.

Quando o mesmo `XPZ` for reprocessado após atualização do arquivo exportado, tratar o novo resultado como um novo snapshot daquele insumo, não como repetição irrelevante do processamento anterior. A classificação `updated` versus `unchanged` pertence ao resultado daquele processamento específico.

Os nomes das pastas sao apenas padroes sugeridos quando o usuario nao informar outros. O que manda e a funcao da pasta no fluxo.

Quando a base compartilhada ganhar um parametro operacional relevante, isso
significa apenas que a capacidade existe no motor compartilhado. A exposicao em
wrappers locais continua sendo decisao local e pode estar defasada. Nesses
casos, o agente deve reconhecer a defasagem como oportunidade de adaptacao
local, propor a mudanca ao usuario e aguardar aprovacao explicita; nao deve
alterar wrappers locais por conta propria.

A superficie do wrapper local tambem pode ficar temporariamente a frente, atras
ou levemente desalinhada em relacao ao motor compartilhado efetivo daquela pasta
paralela da KB. Quando a falha atingir apenas um parametro opcional de
conferencia/comparacao e o sync principal continuar viavel, tratar o caso como
divergencia wrapper/engine: rerodar sem o opcional, registrar o incidente no
relato e nao classificar isso automaticamente como bloqueio da operacao
principal.

Os `.example.ps1` da base metodologica podem servir como referencia para
consertar ou reconstruir wrappers locais finais, mas nao substituem o wrapper
local real e nao devem ser usados como fallback automatico de execucao no fluxo
normal da pasta paralela da KB.

Se a pasta paralela da KB ainda nao estiver montada, validada ou mapeada, parar e usar `xpz-kb-parallel-setup` antes do `sync`.

## PATH RESOLUTION

- Este `SKILL.md` fica dentro de uma subpasta de skill sob a raiz do repositório.
- Toda referência `../arquivo.md` deve ser resolvida a partir da pasta deste `SKILL.md`, e não do diretório de trabalho corrente.
- Na prática, `../` aponta para a base metodológica compartilhada na pasta-pai desta skill.

---

## TRIGGERS

Use esta skill para:
- Usuário quer processar um `.xpz` exportado da IDE
- Usuário quer atualizar o acervo de XMLs a partir de um XPZ
- Usuário quer conferir se um export full da KB está completo
- Usuário quer rodar o script de sincronização ou de snapshot

Do NOT use this skill para:
- Gerar ou construir pacotes XPZ para importacao manual na IDE (use `xpz-builder`)
- Analisar estrutura interna de um XML isolado (use `xpz-reader`)
- Instalar ou gerenciar monitoramento automatico de pastas XPZ (use `xpz-daemon`)
- Localizar objetos no acervo da KB por nome ou tipo (usar `xpz-index-triage` quando houver indice KbIntelligence disponivel)
- Preparar, explicar ou validar a estrutura inicial da pasta paralela da KB (use `xpz-kb-parallel-setup`)

---

## SCRIPTS ESPERADOS

O repositório deve conter em `<repo_root>\scripts\` dois wrappers:

| Propósito | Quando usar |
|---|---|
| **Atualização diária** — extrai e materializa XMLs no acervo a partir de um XPZ parcial | XPZ do dia a dia exportado pela IDE |
| **Conferência full** — verifica completude do acervo contra um export completo da KB, sem regravar nada | Novo export full da KB |

Os nomes exatos dos wrappers são definidos por cada repositório. Consulte o `README.md` local para identificá-los.

## PASTAS PADRÃO PARA CARGA INICIAL

Quando o usuário não informar nomes alternativos, adotar estas subpastas na raiz da KB:

- `ObjetosDaKbEmXml`: acervo oficial somente leitura para agentes
- `XpzExportadosPelaIDE`: entrada dos `.xpz` exportados pela IDE
- `scripts`: wrappers `.ps1` que tratam `XPZ`
- `Temp`: destino de artefatos efemeros de execucao, como diretorios temporarios de wrappers, logs auxiliares e saidas intermediarias
- `KbIntelligence`: pasta do indice SQLite derivado e regeneravel, quando esse fluxo estiver adotado na KB
- `ObjetosGeradosParaImportacaoNaKbNoGenexus`: saída de XMLs temporários para importação manual, organizada por frente em subpastas `NomeCurto_GUID_YYYYMMDD`; essa subpasta é a unidade ativa da frente
- `PacotesGeradosParaImportacaoNaKbNoGenexus`: saída de pacotes `.xml` e, quando necessário, `.xpz`
- após processamento bem-sucedido, o `.xpz` consumido pode ser renomeado para `processado_<nome-original>.xpz`
- por padrão, novos fluxos devem ignorar arquivos com prefixo `processado_`
- se o usuario apontar explicitamente como entrada da rodada um arquivo com prefixo `processado_`, tratar isso como alerta operacional de naming inconsistente, pedir confirmacao antes de seguir e deixar o `InputPath` informado prevalecer se o usuario confirmar
- se alguma subpasta ainda não existir, criar nesta ordem:
  1. `scripts`
  2. `Temp`
  3. `XpzExportadosPelaIDE`
  4. `ObjetosDaKbEmXml`
  5. `KbIntelligence`
  6. `ObjetosGeradosParaImportacaoNaKbNoGenexus`
  7. `PacotesGeradosParaImportacaoNaKbNoGenexus`
- se `XpzExportadosPelaIDE` ainda não existir, perguntar onde o usuário quer salvar os `.xpz`
- se `ObjetosDaKbEmXml` ainda não existir, parar e tratar a KB como ainda não materializada

---

## MAPEAMENTO INTENCAO -> FUNCAO DA PASTA

- Se a intencao for materializar `XPZ` exportado pela IDE para consulta futura do agente:
  - usar a pasta com funcao de acervo materializado da KB
  - essa pasta recebe XMLs individuais por objeto apos a quebra do `full.xml`
- Se a intencao for atualizar acervo materializado com `XPZ` parcial:
  - usar a mesma pasta com funcao de acervo materializado da KB
  - nunca usar a pasta de geracao para importacao como destino dessa materializacao
- Se a intencao for gerar XML novo ou copia alterada para importar na IDE:
  - usar a pasta com funcao de geracao para importacao
  - essa pasta recebe apenas XMLs novos ou copias alteradas geradas pelo agente
  - cada frente deve usar sua propria subpasta `NomeCurto_GUID_YYYYMMDD`
- Se a intencao for guardar `XPZ` exportado pela IDE:
  - usar a pasta com funcao de entrada de `XPZ`
  - essa pasta nao e acervo materializado nem area de geracao de XML

---

## REGRAS DE NAMING

- Ao materializar acervo vindo de `XPZ`, organizar os arquivos em subpastas por tipo amigavel de objeto GeneXus
- Ao materializar acervo vindo de `XPZ`, usar nomes amigaveis dos objetos como nome principal dos XMLs
- Nao usar GUID como nome principal de pasta ou arquivo da materializacao
- GUID, `parentGuid`, `parentType` e `moduleGuid` servem como metadados de apoio, nao como eixo principal de organizacao

---

## LOCALIZAÇÃO DO REPOSITÓRIO

1. Usar o diretório de trabalho atual como ponto de partida
2. Se necessário, subir até encontrar a raiz Git (`git rev-parse --show-toplevel`)
3. Listar `scripts\` e identificar os dois wrappers pelo `README.md` local
4. Se não encontrados, perguntar ao usuário onde fica a raiz do repositório antes de prosseguir

---

## PARÂMETROS COMUNS

Os wrappers seguem esta convenção de parâmetros:

### Wrapper de atualização diária
- `-InputPath` *(obrigatório)* — caminho para `.xpz`, XML ou pasta contendo o XML
- `-VerifyOnly` *(switch)* — só confere, não regrava
- `-FullSnapshot` *(switch)* — compara snapshot completo do acervo
- `XPZ` full define apenas o insumo; nao define, por si so, o modo de verificacao
- para materializacao normal, inclusive carga inicial por `XPZ` full vindo da IDE ou por export headless via `MSBuild`, nao presumir `-FullSnapshot` como padrao implicito nem como atalho ergonomico
- usar `-FullSnapshot` somente em um destes casos: pedido explicito do usuario por conferencia full, uso do wrapper especifico de conferencia full, ou exigencia nominal da documentacao local do repositorio
- `-ReportPath` *(opcional)* — salva relatório JSON
- `-KeepReport` *(switch)* — mantém relatório mesmo sem erro
- quando houver primeira materializacao seguida de reprocessamento confirmatorio ou conferencia full, nao sobrescrever silenciosamente o relatorio principal da primeira materializacao com o relatorio da segunda passagem
- nesses casos, usar caminhos separados para cada relatorio ou deixar explicito no handoff qual arquivo corresponde a `materializacao` e qual corresponde a `confirmacao`/`conferencia`
- `-ExpectedItems` *(opcional)* — lista de itens esperados da frente atual no formato `Tipo:Nome`, usada apenas para classificação comparativa entre foco esperado e retorno oficial da KB
- a disponibilidade desse parametro no motor compartilhado nao autoriza presumir
  que wrappers locais da pasta paralela da KB ja o exponham; se o wrapper local
  ainda nao o aceitar, tratar isso como oportunidade de atualizacao local,
  mencionar ao usuario e aguardar aprovacao explicita antes de qualquer ajuste
- se o wrapper local aceitar `-ExpectedItems`, mas a execucao falhar no motor
  compartilhado efetivo por incompatibilidade restrita a esse opcional
  comparativo, tratar como divergencia wrapper/engine e nao como bloqueio
  automatico do sync principal
- quando a falha ficar restrita a esse opcional, rerodar sem `-ExpectedItems`,
  concluir a materializacao se o restante do fluxo estiver sao e registrar no
  handoff que a comparacao esperada x retorno oficial ficou indisponivel naquela
  rodada por incompatibilidade do engine
- se a falha atribuida a `-ExpectedItems` revelar quebra da materializacao,
  contrato principal do wrapper, refresh obrigatorio do indice ou outro impacto
  central no fluxo oficial, continuar tratando o caso como bloqueio real
- `-KbMetadataPath` *(opcional)* — salva metadados da KB em formato Markdown
- se esse parâmetro estiver ativo no wrapper local, `kb-source-metadata.md` faz parte normal do fluxo e pode ser reescrito a cada processamento
- quando `kb-source-metadata.md` for reescrito, ele deve registrar `last_xpz_materialization_run_at` como horario do processamento XPZ/XML solicitado, mesmo quando nenhum XML tiver mudanca material
- se o `XPZ` vier com `Source` vazio, incompleto ou ausente, o wrapper deve preservar valores estáveis conhecidos e emitir warning de refresh parcial; isso não invalida o sync de objetos
- depois de materializacao XPZ/XML bem-sucedida em `ObjetosDaKbEmXml`, o wrapper local deve acionar compulsoriamente a regeneracao/validacao do indice derivado por wrapper local de `KbIntelligence`
- evidencia clara desse encadeamento significa declaracao local explicita no `README.md`/`AGENTS.md` ou chamada observavel no proprio wrapper local; nao presumir essa capacidade apenas porque a base compartilhada a exige
- se o wrapper local de regeneracao do indice estiver ausente ou defasado, ou se o wrapper de materializacao nao encadear esse refresh, tratar como bloqueio operacional do sync normal e oferecer ao usuario atualizacao via `xpz-kb-parallel-setup` antes de seguir
- nao apresentar `sync` seguido de regeneracao manual separada do indice como fluxo normal em pasta que adota `KbIntelligence`
- `-NoGitSummary` *(switch)* — suprime resumo Git no final

### Wrapper de conferência full
- `-InputPath` *(obrigatório)* — caminho para `.xpz`, XML ou pasta
- `-ReportPath` *(opcional)* — salva relatório JSON
- `-KeepReport` *(switch)* — mantém relatório mesmo sem erro

---

## WORKFLOW

1. Identificar se é atualização diária ou conferência de full snapshot
2. Se a pasta paralela da KB ainda nao estiver montada, validada ou mapeada para este repositorio → **ABORT** e usar `xpz-kb-parallel-setup`
3. Resolver a raiz do repositório pelo contexto
4. Ler o `README.md` local para identificar os nomes dos wrappers
5. Distinguir explicitamente as áreas operacionais locais:
   - `ObjetosDaKbEmXml` = snapshot oficial da KB, materializado em XMLs individuais por objeto e atualizado apenas pelo fluxo oficial do script
   - `XpzExportadosPelaIDE` = entrada dos `.xpz` exportados pela IDE
   - `ObjetosGeradosParaImportacaoNaKbNoGenexus` = área de trabalho para XML local de importação manual, organizada por frente em subpastas `NomeCurto_GUID_YYYYMMDD`
   - `PacotesGeradosParaImportacaoNaKbNoGenexus` = área de pacotes gerados localmente, mantida plana sem subpastas por frente
   - `scripts` = wrappers `.ps1` que tratam os `XPZ`
   - se o objeto ainda não voltou da KB por export oficial, o trabalho deve permanecer em `ObjetosGeradosParaImportacaoNaKbNoGenexus`
6. Se o usuario informou nomes alternativos para as pastas, reportar na conversa o mapeamento entre nome real e funcao
   - documentar isso em arquivo somente quando a documentação local exigir ou quando o usuário pedir
7. Se detectar alterações locais indevidas em `ObjetosDaKbEmXml`, reportar isso como incidente de processo:
   - Preservar o material de trabalho em `ObjetosGeradosParaImportacaoNaKbNoGenexus`
   - Restaurar `ObjetosDaKbEmXml` para a versão oficial do Git
   - Apresentar na conversa um manifesto estruturado dos itens preservados antes de retomar o fluxo normal
   - Salvar esse manifesto em arquivo apenas quando a rastreabilidade local do incidente exigir isso
   - Abortar imediatamente o fluxo normal até a restauração do snapshot oficial e a abertura do incidente de processo
   - Não tratar esse caso como detalhe operacional; ele bloqueia o fluxo até saneamento explícito do snapshot oficial
   - Se o usuário estiver em frente de delta ainda não reexportado pela KB, orientar explicitamente que o trabalho continue em `ObjetosGeradosParaImportacaoNaKbNoGenexus`, não no acervo oficial
8. Confirmar o `InputPath` com o usuário se não foi fornecido
9. Quando o fluxo envolver materializacao de `XPZ` completo:
   - quebrar o `full.xml` em XMLs individuais por objeto
   - gravar a saida na pasta com funcao de acervo materializado
   - organizar por tipo amigavel de objeto GeneXus
   - usar nomes amigaveis de objeto como nome principal dos XMLs
10. Quando o fluxo envolver `XPZ` parcial:
    - atualizar a mesma pasta com funcao de acervo materializado
    - nao desviar a materializacao para a pasta de geracao para importacao
    - se o mesmo arquivo `XPZ` for reexportado/atualizado e reprocessado, tratar o novo processamento pelo conteúdo e pelo `lastUpdate` resultante, não pela memória do processamento anterior
    - se houver `-ExpectedItems`, usar esse contexto apenas para comparar foco esperado versus retorno oficial; a materialização continua seguindo tudo que a KB devolveu oficialmente
11. Se a pasta adota `KbIntelligence`, validar que o wrapper local de materializacao encadeia refresh compulsorio do indice apos sync bem-sucedido que nao seja `VerifyOnly`
    - considerar evidencia clara apenas quando isso estiver documentado explicitamente no repositorio local ou observavel no codigo do proprio wrapper local
    - se o wrapper nao tiver essa capacidade, bloquear o sync normal antes de executar e oferecer atualizacao via `xpz-kb-parallel-setup`
    - nao executar sync normal esperando corrigir o indice manualmente depois
    - nao usar o wrapper antigo para atualizar `kb-source-metadata.md` e depois regenerar o indice manualmente como substituto da correcao de compatibilidade
    - nao usar `.example.ps1` da base compartilhada como substituto temporario do wrapper local real ausente
12. Montar o comando com os parâmetros corretos
    - para materializacao normal do `XPZ` em `ObjetosDaKbEmXml`, nao acrescentar `-FullSnapshot` por conta propria
    - nao reinterpretar `XPZ` full como autorizacao implicita para `-FullSnapshot`; export full e conferencia full sao coisas diferentes
    - usar `-FullSnapshot` apenas quando o usuario pedir conferencia full, quando o wrapper especifico de conferencia for o escolhido ou quando a documentacao local tornar isso requisito explicito
    - tratar nome iniciado por `processado_` como heuristica forte de artefato ja consumido, nao como verdade absoluta sobre o conteudo do arquivo
    - se o `InputPath` explicitamente informado pelo usuario apontar para arquivo com prefixo `processado_`, emitir alerta curto, pedir confirmacao e prosseguir somente se o usuario confirmar esse arquivo como insumo correto da rodada atual
    - se houver opcional comparativo como `-ExpectedItems`, lembrar que a
      exposicao no wrapper local nao prova compatibilidade integral do motor
      compartilhado efetivo; se a primeira execucao falhar apenas nesse ponto,
      preparar rerun sem o opcional antes de concluir bloqueio do sync
13. Executar via Bash com `pwsh -File ...`
    - se a execucao falhar com indicio claro de divergencia wrapper/engine
      restrita a opcional de comparacao, rerodar uma vez sem o parametro
      opcional antes de classificar o caso como bloqueio
    - se o rerun sem opcional concluir a materializacao e os gates obrigatorios,
      registrar sucesso do sync principal com incidente em capability opcional
    - se o rerun sem opcional repetir falha central ou expuser problema fora do
      escopo comparativo, tratar como bloqueio real do sync
14. Se a materializacao XPZ/XML em `ObjetosDaKbEmXml` foi concluida com sucesso e nao era `VerifyOnly`, confirmar na saida do wrapper ou em evidencia local clara que o refresh compulsorio do indice derivado tambem foi executado
    - em pasta que adota `KbIntelligence`, ausencia de evidencia do refresh deve ser tratada como falha ou defasagem operacional do wrapper local
    - nao compensar essa ausencia com rebuild manual separado do indice como se fosse fluxo normal
    - se o wrapper nao produzir evidencia suficiente do refresh, encerrar com bloqueio de compatibilidade e oferecer atualizacao via `xpz-kb-parallel-setup`
15. Se o processamento foi concluído com sucesso, permitir renomear o `.xpz` consumido para `processado_<nome-original>.xpz`
16. Reportar: objetos criados, atualizados, ignorados, resíduos removidos, refresh do indice e resumo Git
    - se o resumo do wrapper expuser `MaterializationInterpretation`, usar esse campo como leitura principal do resultado em vez de inferir pela combinacao solta de `Created`, `Updated` e `Unchanged`
    - explicar que `updated` significa que o wrapper materializou conteúdo mais novo/relevante para o acervo naquele processamento
    - explicar que `unchanged` significa que o item já tinha no acervo oficial conteúdo compatível ou mais novo, tipicamente com `lastUpdate` igual ou superior ao XML vindo do `XPZ`
    - explicar que `updated`/`unchanged` pertencem ao processamento do `XPZ` contra o arquivo materializado atual, nao ao estado Git do repositorio
    - nunca afirmar `primeira carga` ou equivalente quando `Created = 0` e `Unchanged > 0`; essa combinacao, sozinha, nao comprova primeira materializacao e normalmente indica snapshot ja existente confirmado contra o insumo atual
    - explicar que um item pode aparecer como `unchanged` no sync porque o arquivo local ja esta igual ao conteudo vindo do `XPZ`, mesmo que esse mesmo arquivo ainda tenha diff pendente no Git contra o ultimo commit
    - quando houver resumo Git, apresentar essa camada separadamente como comparacao do worktree contra o commit atual, sem reclassificar o resultado do sync
    - se o mesmo `XPZ` tiver sido reprocessado após atualização do arquivo, deixar explícito que a comparação relevante é com o conteúdo do insumo reprocessado e com o estado atual do acervo, não com o relatório antigo
    - se `kb-source-metadata.md` tiver sido reescrito pelo wrapper, tratar isso como artefato normal do fluxo, não como evidência automática de mudança funcional na frente
    - se a pasta ainda carregar memoria local provisoria do setup dizendo que `ObjetosDaKbEmXml` nao foi materializada, `aguardando primeiro XPZ` ou equivalente, atualizar ou neutralizar esse estado quando a primeira materializacao oficial tiver sido concluida com sucesso
    - so afirmar conteudo especifico de `kb-source-metadata.md`, como versao do GeneXus, build, GUID da KB, usuario ou caminho `Source`, quando esse metadado tiver aparecido explicitamente na saida real do wrapper ou quando o proprio `kb-source-metadata.md` tiver sido aberto e lido nominalmente na rodada atual
    - quando nenhuma dessas duas fontes aceitaveis tiver mostrado o metadado, limitar o resumo ao que o wrapper efetivamente retornou
    - se o pacote tiver `Source` parcial, separar claramente `sync de objetos aceito` de `refresh de metadado parcial` e preservar os valores estáveis já conhecidos
    - se houver relatorio da primeira materializacao e outro de reprocessamento confirmatorio ou conferencia full, nao misturar os papeis no handoff; identificar explicitamente qual arquivo representa a criacao/atualizacao do acervo e qual arquivo representa apenas verificacao posterior
    - se o `XPZ` oficial da KB trouxer objetos adicionais fora do foco imediato da frente, reportar isso como inesperado para a frente atual, mas tratar como possível mudança paralela legítima vinda da IDE/KB até evidência em contrário
    - se `-ExpectedItems` tiver sido informado, classificar explicitamente `itens esperados que voltaram`, `itens esperados que nao voltaram` e `retorno oficial adicional da KB`
    - se `-ExpectedItems` tiver sido informado, emitir tambem um resumo humano curto no console/handoff, sem alarmismo e sem tratar adicionais oficiais ou esperados ausentes como falha automatica
    - se a rodada tiver precisado rerun sem `-ExpectedItems` por divergencia
      wrapper/engine, separar explicitamente `sync principal concluido` de
      `comparacao opcional indisponivel nesta rodada`
17. Quando um objeto voltar da KB via `xpz` e for materializado no acervo oficial, tratar esse XML do acervo como a fonte mais confiável para alterações futuras; não reutilizar cópia intermediária/delta sem comparar com o acervo atualizado
18. Ao preparar commit ou handoff após o `sync`, separar explicitamente:
    - artefato da frente atual = resultado que o processamento atual confirmou como pertencente à frente em curso
    - mudanca paralela legitima vinda da KB/IDE = item devolvido oficialmente pela KB no `XPZ`, ainda que fora do foco imediato da frente
    - mudanca lateral indevida = alteracao feita pelo agente fora do escopo da fase ou fora do fluxo oficial esperado
    - nao agrupar no mesmo commit da frente atual mudancas paralelas sem decisao explicita, mas nao tratar automaticamente o retorno oficial adicional da KB como erro
19. O handoff tecnico minimo deve declarar:
    - comando/wrapper executado e `InputPath` usado
    - se a rodada foi materializacao normal, reprocessamento confirmatorio ou conferencia full
    - relatorio principal usado para a conclusao e, quando houver, relatorio separado de verificacao posterior
    - `MaterializationInterpretation` quando o wrapper expuser esse campo; caso contrario, limitar a leitura aos contadores e warnings reais
    - evidencia usada para afirmar refresh do indice ou bloqueio que impediu essa conclusao
    - se `kb-source-metadata.md` foi lido nominalmente na rodada atual ou apenas reescrito pelo wrapper
    - se houve falha de opcional comparativo por divergencia wrapper/engine,
      declarar o parametro afetado, o rerun sem ele e que isso nao bloqueou o
      sync principal
20. O resumo Git do item anterior e apenas informativo; nao autoriza `git add`, `commit` ou `push`
21. Se o usuario nao pedir fechamento Git de forma explicita, o fluxo deve terminar no handoff tecnico e, no maximo, sugerir proximos passos sem executar publicacao

---

## EXEMPLO CURTO DE ESTRUTURA MATERIALIZADA ESPERADA

```text
PastaParalelaDaKb/
  XpzExportadosPelaIDE/
    KBCompleta_20260413.xpz
    processado_AjustesFinanceiro_20260413.xpz
  ObjetosDaKbEmXml/
    Transaction/
      Cliente.xml
      Pedido.xml
    Procedure/
      GeraBoleto.xml
    WebPanel/
      WPClienteConsulta.xml
  ObjetosGeradosParaImportacaoNaKbNoGenexus/
    AjusteVolumes_12345678-1234-1234-1234-123456789abc_20260414/
      ClienteNovo.xml
      PedidoAjustado.xml
  PacotesGeradosParaImportacaoNaKbNoGenexus/
    AjusteVolumes_12345678-1234-1234-1234-123456789abc_20260414_01.import_file.xml
  scripts/
    Sync-GeneXusXpzToXml.ps1
  kb-source-metadata.md
```

O arquivo `kb-source-metadata.md`, quando exposto pelo wrapper local via
`-KbMetadataPath`, e artefato normal de processamento e pode ser reescrito em
cada sync. Ele deve preservar valores estaveis conhecidos quando o `XPZ` atual
vier com metadados de `Source` vazios ou parciais.

Esse arquivo tambem e o local esperado de `last_xpz_materialization_run_at`.
Esse horario representa a ultima solicitacao/processamento de materializacao
XPZ/XML, nao apenas a ultima mudanca material detectada nos XMLs.

---

## CONSTRAINTS

- NUNCA editar XMLs manualmente — todo o trabalho é delegado ao script
- NUNCA assumir caminhos absolutos privados — sempre derivar da raiz do repositório
- NUNCA assumir os nomes dos wrappers sem consultar o `README.md` local
- NUNCA executar `sync` normal enquanto a pasta paralela da KB ainda estiver indefinida, nao montada ou nao validada
- NUNCA mover arquivos entre pastas de trabalho e acervo — responsabilidade do fluxo oficial
- NUNCA criar ou mover automaticamente `.xpz` para dentro de `XpzExportadosPelaIDE` como se essa pasta fosse saída do agente; ela e a entrada gravada pelo usuario/IDE
- NUNCA renomear o `.xpz` para `processado_<nome-original>.xpz` antes de sucesso claro no processamento
- NUNCA selecionar por padrão um arquivo já marcado com prefixo `processado_`
- NUNCA tratar XML local gerado para importação manual como se já fosse snapshot oficial da KB
- NUNCA materializar `XPZ` completo ou parcial na pasta de geracao para importacao
- NUNCA usar GUID como estrutura principal de saida da materializacao
- NUNCA organizar o acervo materializado com `guid`, `parentGuid`, `parentType` ou `moduleGuid` como eixo principal de navegacao
- NUNCA criar, alterar, mover, renomear ou sobrescrever arquivos em `ObjetosDaKbEmXml` fora do fluxo oficial do script `.ps1`
- NUNCA encerrar sync XPZ/XML bem-sucedido sem refresh compulsorio do indice derivado quando a KB adotar `KbIntelligence`
- NUNCA executar sync normal em pasta que adota `KbIntelligence` se o wrapper local de materializacao ainda nao encadeia refresh compulsorio do indice; oferecer atualizacao via `xpz-kb-parallel-setup`
- NUNCA descrever `sync` seguido de rebuild manual separado do indice como fluxo normal em pasta que adota `KbIntelligence`
- NUNCA usar sync por wrapper antigo para reparar metadado de materializacao quando o proprio wrapper esta defasado; primeiro atualizar/validar wrappers pela trilha de setup
- NUNCA selecionar automaticamente por padrao um arquivo com prefixo `processado_` quando houver outros candidatos plausiveis para a rodada atual
- NUNCA tratar prefixo `processado_` como bloqueio absoluto quando o usuario tiver apontado explicitamente o `InputPath`; primeiro emitir alerta operacional e exigir confirmacao explicita
- NUNCA antecipar atualização manual de `ObjetosDaKbEmXml`
- NUNCA prosseguir com sync normal quando `ObjetosDaKbEmXml` estiver dirty fora do fluxo oficial; primeiro preserve, restaure e trate como incidente de processo
- NUNCA tratar edição detectada ou pretendida em `ObjetosDaKbEmXml` para delta ainda não reexportado oficialmente pela KB como detalhe operacional; isso é erro explícito de processo
- NUNCA assumir a raiz de `ObjetosGeradosParaImportacaoNaKbNoGenexus` como lote ativo de importacao; o lote ativo deve viver na subpasta da frente `NomeCurto_GUID_YYYYMMDD`
- NUNCA criar subpastas por frente dentro de `PacotesGeradosParaImportacaoNaKbNoGenexus`; essa area de pacotes deve permanecer plana
- NUNCA reutilizar automaticamente artefato de importação/delta como base de nova alteração se o mesmo objeto já tiver voltado da KB e sido materializado no acervo oficial
- NUNCA criar script novo se o repositorio ja tiver fluxo oficial previsto nas skills ou em `scripts/`
- Antes de gerar novo delta de objeto já retornado da KB, comparar a cópia intermediária com o XML atual do acervo e rebasear no acervo se houver defasagem
- Se o script não for encontrado na raiz resolvida, reportar o erro e perguntar ao usuário antes de tentar qualquer alternativa
- NUNCA tratar reprocessamento do mesmo `XPZ` atualizado como se o resultado anterior ainda fosse autoritativo
- NUNCA tratar regravação de `kb-source-metadata.md` pelo wrapper como mudança funcional automática da frente atual
- NUNCA deixar `kb-source-metadata.md` perder valores estáveis conhecidos porque o `XPZ` veio com `Source` vazio ou incompleto
- NUNCA classificar automaticamente como erro de processo, contaminacao indevida ou violacao da trilha o simples fato de um `XPZ` oficial vindo da KB trazer objetos adicionais alem do foco da frente
- NUNCA misturar no mesmo commit da frente atual mudancas paralelas sem decisao explicita so porque aparecem no mesmo workspace
