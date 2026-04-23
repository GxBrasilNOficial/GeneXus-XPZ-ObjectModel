# Historico

## Funcao da pasta

Esta pasta guarda a trilha de validacao, descoberta e reclassificacao da base.
Ela existe para preservar contexto de como o entendimento atual foi construido, sem misturar esse historico ao conjunto operacional principal da raiz.

## Organizacao atual

A organizacao desta pasta segue frentes tematicas.

- `base-geral/`: historico transversal da base compartilhada, fora de uma frente especifica
- `kb-intelligence/`: validacoes, incrementos, encerramentos e rastreabilidade editorial da frente KB Intelligence
- `sugestoes-externas/`: planos, propostas e insumos externos preservados apenas para rastreabilidade

## O que deve ficar aqui

- rodadas de teste
- validacoes bem-sucedidas e malsucedidas
- reclassificacoes de tipos, regras ou hipoteses
- pacotes reais que foram especialmente informativos
- registros de mudanca de entendimento ao longo do tempo

## O que nao deve ficar aqui

- regra operacional vigente
- resumo executivo atual da base
- instrucoes principais para agente
- conteudo que precise ser lido para usar a base hoje

## Regra editorial

Quando uma conclusao ficar estavel, ela deve subir para os `.md` da raiz em forma consolidada.
O historico deve permanecer como registro de rastreabilidade tecnica, respondendo "como chegamos aqui", enquanto a raiz responde "o que vale agora".

Ao mover arquivos entre subpastas de `historico/`, preservar nomes sempre que possivel e ajustar as referencias explicitas que apontarem para caminhos antigos.
