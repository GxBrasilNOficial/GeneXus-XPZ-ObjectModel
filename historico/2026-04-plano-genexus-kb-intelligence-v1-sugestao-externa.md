# Plano v1 — GeneXus KB Intelligence Layer

## Objetivo

Criar uma camada inteligente sobre a Pasta Paralela da KB GeneXus 18 usando o acervo XPZ/XML versionado para aumentar produtividade, manutenção, impacto de mudanças e suporte ao negócio white label.

---

## Contexto Atual

- KB real separada da Pasta Paralela
- Pasta Paralela versionada em Git local + GitHub privado
- Acervo XPZ/XML organizado por tipo de objeto
- Agentes/Codex já atuando no repositório
- Kit de Skills XPZ existente e expansível

---

## Visão Estratégica

Transformar o acervo técnico em um **motor de conhecimento operacional**.

### Resultado esperado

- Busca inteligente da KB
- Impact analysis automático
- Documentação viva
- Agentes especializados GeneXus
- Menor risco em manutenção
- Escala operacional para software house enxuta

---

## Arquitetura Recomendada (Fases)

## Fase 1 — Foundation (baixo custo / rápido retorno)

### Entregáveis

1. Inventário automático de objetos
2. Catálogo por tipo:
   - Transaction
   - Procedure
   - API
   - SDT
   - Domain
   - Panel/WebPanel
3. Busca textual rápida
4. Histórico de versões
5. Dashboard simples em Markdown

### Skills sugeridas

- skill_xpz_inventory
- skill_xpz_catalog
- skill_xpz_diff
- skill_xpz_search

---

## Fase 2 — Intelligence Layer

### Entregáveis

1. Grafo de dependências entre objetos
2. Detecção de objetos centrais
3. Objetos órfãos
4. Regras duplicadas
5. Risco de alteração por módulo

### Skills sugeridas

- skill_xpz_dependency_graph
- skill_xpz_impact_analysis
- skill_xpz_refactor_radar
- skill_xpz_hotspots

---

## Fase 3 — AI Retrieval

### Entregáveis

1. Resumos por objeto
2. Base semântica consultável
3. Perguntas em linguagem natural
4. Agente técnico da KB

### Skills sugeridas

- skill_xpz_semantic_chunks
- skill_xpz_rag
- skill_xpz_kb_chat
- skill_xpz_object_explainer

---

## Fase 4 — Obsidian (opcional)

### Entregáveis

1. Vault automático
2. Nota por objeto
3. Fluxos de negócio
4. ADRs
5. Graph view navegável

### Skills sugeridas

- skill_xpz_obsidian_export
- skill_xpz_flow_mapper
- skill_xpz_adr_builder

---

## Stack Econômica Recomendada

### Inicial

- Python
- SQLite
- Markdown
- Git
- Windows local

### Evolução

- PostgreSQL
- Vetorial local
- UI web leve

---

## Prompt Mestre para Codex

Avalie o repositório atual de Skills XPZ e proponha:

1. Quais Skills existentes cobrem partes deste plano
2. Quais novas Skills criar
3. Ordem ideal de implementação
4. Dependências entre Skills
5. Quick wins em até 7 dias
6. Roadmap de 30 / 60 / 90 dias

---

## Prioridade Recomendada

### Semana 1

- Inventory
- Catalog
- Search

### Semana 2

- Diff
- Dependency graph

### Semana 3

- Impact analysis
- Hotspots

### Semana 4

- KB Chat MVP

---

## KPI de Sucesso

- Tempo para localizar objeto ↓
- Tempo para impacto de mudança ↓
- Tempo para onboarding parceiros ↓
- Tempo para suporte ↓
- Segurança em alterações ↑

---

## Filosofia

Ferramenta cara não é prioridade.

**Conhecimento estruturado + automação + IA aplicada ao domínio GeneXus** é a prioridade.

---

## Próxima Iteração (v2)

Após análise do Codex:

- ajustar arquitetura
- detalhar Skills
- definir formatos de arquivos
- pipelines automáticos
- interface operacional
