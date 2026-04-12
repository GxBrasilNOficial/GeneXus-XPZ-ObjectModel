---
name: xpz-sync
description: Executa sincronização ou conferência de XPZ de uma KB GeneXus chamando os scripts locais do repositório ativo
---

# xpz-sync

Invoca os scripts locais do repositório GeneXus ativo para sincronizar XMLs individuais a partir de um XPZ exportado pela IDE, ou para conferir um export completo da KB.

---

## GUIDELINE

Identificar a raiz do repositório pelo contexto, localizar os scripts de sincronização na pasta `scripts\`, montar o comando correto e executá-lo via Bash. Reportar o resultado de forma clara. Não alterar arquivos manualmente — delegar tudo ao script. Tratar `ObjetosDaKbEmXml` como snapshot oficial somente leitura para agentes e não antecipar manualmente nenhuma promoção para esse acervo.

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

---

## SCRIPTS ESPERADOS

O repositório deve conter em `<repo_root>\scripts\` dois wrappers:

| Propósito | Quando usar |
|---|---|
| **Atualização diária** — extrai e materializa XMLs no acervo a partir de um XPZ parcial | XPZ do dia a dia exportado pela IDE |
| **Conferência full** — verifica completude do acervo contra um export completo da KB, sem regravar nada | Novo export full da KB |

Os nomes exatos dos wrappers são definidos por cada repositório. Consulte o `README.md` local para identificá-los.

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
- `-ReportPath` *(opcional)* — salva relatório JSON
- `-KeepReport` *(switch)* — mantém relatório mesmo sem erro
- `-KbMetadataPath` *(opcional)* — salva metadados da KB em formato Markdown
- `-NoGitSummary` *(switch)* — suprime resumo Git no final

### Wrapper de conferência full
- `-InputPath` *(obrigatório)* — caminho para `.xpz`, XML ou pasta
- `-ReportPath` *(opcional)* — salva relatório JSON
- `-KeepReport` *(switch)* — mantém relatório mesmo sem erro

---

## WORKFLOW

1. Identificar se é atualização diária ou conferência de full snapshot
2. Resolver a raiz do repositório pelo contexto
3. Ler o `README.md` local para identificar os nomes dos wrappers
4. Distinguir explicitamente as áreas operacionais locais:
   - `ObjetosDaKbEmXml` = snapshot oficial atualizado apenas pelo fluxo do script
   - `ObjetosGeradosParaImportacaoNaKbNoGenexus` = área de trabalho para XML local de importação manual
   - `PacotesGeradosParaImportacaoNaKbNoGenexus` = área de pacotes gerados localmente
5. Se detectar alterações locais indevidas em `ObjetosDaKbEmXml`, reportar isso como incidente de processo:
   - Preservar o material de trabalho em `ObjetosGeradosParaImportacaoNaKbNoGenexus`
   - Restaurar `ObjetosDaKbEmXml` para a versão oficial do Git
   - Apresentar na conversa um manifesto estruturado dos itens preservados antes de retomar o fluxo normal
   - Salvar esse manifesto em arquivo apenas quando a rastreabilidade local do incidente exigir isso
6. Confirmar o `InputPath` com o usuário se não foi fornecido
7. Montar o comando com os parâmetros corretos
8. Executar via Bash com `pwsh -File ...`
9. Reportar: objetos criados, atualizados, ignorados, resíduos removidos e resumo Git
10. Quando um objeto voltar da KB via `xpz` e for materializado no acervo oficial, tratar esse XML do acervo como a fonte mais confiável para alterações futuras; não reutilizar cópia intermediária/delta sem comparar com o acervo atualizado

---

## CONSTRAINTS

- NUNCA editar XMLs manualmente — todo o trabalho é delegado ao script
- NUNCA assumir caminhos absolutos privados — sempre derivar da raiz do repositório
- NUNCA assumir os nomes dos wrappers sem consultar o `README.md` local
- NUNCA mover arquivos entre pastas de trabalho e acervo — responsabilidade do fluxo oficial
- NUNCA tratar XML local gerado para importação manual como se já fosse snapshot oficial da KB
- NUNCA criar, alterar, mover, renomear ou sobrescrever arquivos em `ObjetosDaKbEmXml` fora do fluxo oficial do script `.ps1`
- NUNCA antecipar atualização manual de `ObjetosDaKbEmXml`
- NUNCA reutilizar automaticamente artefato de importação/delta como base de nova alteração se o mesmo objeto já tiver voltado da KB e sido materializado no acervo oficial
- Antes de gerar novo delta de objeto já retornado da KB, comparar a cópia intermediária com o XML atual do acervo e rebasear no acervo se houver defasagem
- Se o script não for encontrado na raiz resolvida, reportar o erro e perguntar ao usuário antes de tentar qualquer alternativa
