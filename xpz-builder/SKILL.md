---
name: xpz-builder
description: Generates and clones GeneXus XPZ objects conservatively — validates structure, applies risk rules, serializes envelope
---

# xpz-builder

Generates GeneXus XML objects for XPZ packaging using conservative cloning from empirical templates. Applies risk rules, validates structure, and serializes the correct XPZ envelope. Does not affirm import or build success — that requires external IDE validation.

---

## GUIDELINE

Generate or clone GeneXus XPZ objects only from comparable structural templates. Abort when a suitable template does not exist. Never invent structure.

## PATH RESOLUTION

- This `SKILL.md` lives inside a skill subfolder under the repository root.
- Resolve every `../arquivo.md` reference relative to the directory of this `SKILL.md`, not relative to the current working directory.
- In practice, `../` points to the shared methodological base in the parent directory of this skill folder.

---

## TRIGGERS

Use this skill for:
- User asks to generate an XPZ for a specific GeneXus object type
- User asks to clone, rename, or adapt an existing XML object
- User asks to package one or more objects into an XPZ envelope
- User asks to validate an XML object before packaging
- User asks which template or molde to use for a given object type
- User asks how to construct the `<ExportFile>` envelope

Do NOT use this skill for:
- Analyzing or classifying existing XML without modification intent (use `xpz-reader`)
- Questions about GeneXus runtime, build behavior, or IDE configuration
- Generating KnowledgeBase-level exports or full KB backups
- Affirming that generated XPZ will import or build without errors

---

## RESPONSIBILITIES

- Identify the target object type and locate the most comparable structural template
- Apply risk assessment from [03-risco-e-decisao-por-tipo](../03-risco-e-decisao-por-tipo.md) before proceeding
- Abort if no comparable structural template exists and risk is high or very high
- Clone conservatively: preserve `Object/@guid`, `parent*`, `moduleGuid`, all recurring Part types
- Apply XPZ envelope rules from [02-regras-operacionais-e-runtime](../02-regras-operacionais-e-runtime.md)
- Treat `runtime`, `Import File Load`, `Import`, and `Specification` as distinct validation layers; success in one does not authorize conclusions about the others
- Validate `Source` compatibility by methodology first: GeneXus semantic rules plus the XPZ trail and `nexa`; use KB corpus search only as fallback when the methodological base does not cover the case
- Classify each package candidate by content delta, separating requested functional change from metadata, reserialization, or known noise before packaging
- Require explicit confirmation when a candidate item is only metadata, reserialization, or noise and would otherwise be kept in the package
- Generate valid `lastUpdate` timestamp (real local time, not placeholder)
- Treat `ObjetosDaKbEmXml` as official snapshot and read-only for agents
- Use `ObjetosGeradosParaImportacaoNaKbNoGenexus` as the working area for locally generated or preserved XML
- Use `PacotesGeradosParaImportacaoNaKbNoGenexus` as the destination area for locally generated packages
- Detect workspace contamination before packaging and abort when more than one plausible batch is active
- Build or validate a manifest for the candidate batch before packaging, treating the manifest first as structured output in the conversation
- Name locally generated packages for IDE import using the preferred pattern `FrenteCurta_YYYYMMDD_nn`
- Classify each active XML root as `Object`, `Attribute`, or unsupported before serializing the package
- Validate UTF-8 without BOM hygiene on active XMLs before packaging
- Reread and apply local repository documentation (`AGENTS.md`, `README.md`, and equivalent project docs) before packaging whenever the target KB/repository defines specific functional review rules, contracts, or operational flow
- Ensure all GUIDs are syntactically valid (no text placeholders like `"YOUR-GUID-HERE"`)
- Validate XML structure before delivery
- Declare confidence level and limitations explicitly at the end of every output
- Keep `WorkWithWeb` noise that is already proven in this trail as non-functional in the manifest, especially `Load Code` in `Selection` and the affected `View` tabs; do not generalize this to unrelated `WorkWithWeb` cases

---

## COMMUNICATION

- Respond in the same language the user writes in
- Lead with the decision (proceed / abort) and the reason
- State which template was used and why it was selected
- Always end output with a limitations block: what was followed, what requires external validation
- In the closing, explicitly state that the saved XML was reread, the persisted `lastUpdate` was confirmed, and the applicable local repository rules were reread and satisfied before packaging
- Use NEVER and ABORT as hard stops, not suggestions
- NEVER use speculative or reassuring language about import/build success

---

## STRUCTURE

Reference files and when to load them:

| Reference | Load when |
|-----------|-----------|
| [00-readme-genexus-xpz-xml.md](../00-readme-genexus-xpz-xml.md) | Always — absolute rules and envelope structure |
| [02-regras-operacionais-e-runtime.md](../02-regras-operacionais-e-runtime.md) | Always — envelope serialization, timestamp, GUID, ObjectsIdentityMapping rules |
| [03-risco-e-decisao-por-tipo.md](../03-risco-e-decisao-por-tipo.md) | Always — risk level and abort conditions |
| [04-webpanel-familias-e-templates.md](../04-webpanel-familias-e-templates.md) | Target is a WebPanel object |
| [05-transaction-familias-e-templates.md](../05-transaction-familias-e-templates.md) | Target is a Transaction object |
| [07-open-points-e-checklist.md](../07-open-points-e-checklist.md) | Edge cases, provisional decisions, or checklist for new templates |
| [08-guia-para-agente-gpt.md](../08-guia-para-agente-gpt.md) | Decision formula, precedence rules, materialization rules, refuse conditions |

---

## WORKFLOW

1. Identify the target object type and the user's intent (create new / clone existing / rename)
2. Reread local repository documentation and resolve the operational topology for this KB/repository:
   - `ObjetosDaKbEmXml` = official snapshot, read-only for agents
   - `ObjetosGeradosParaImportacaoNaKbNoGenexus` = working area for local XMLs to import manually
   - `PacotesGeradosParaImportacaoNaKbNoGenexus` = output area for locally generated packages
3. When the task is packaging, list active XMLs in the root of `ObjetosGeradosParaImportacaoNaKbNoGenexus` and treat them as the candidate batch
4. Evaluate batch isolation before packaging:
   - If more than one plausible batch is present in the workspace → **ABORT**
   - Do NOT infer the correct batch only from recency when there is contamination risk
   - If an older package lost validity after a change of direction, either rename it with prefix `OBSOLETO_` or present a structured manifest in the conversation stating that package X was replaced by package Y; save that manifest as a local file only when local traceability is concretely needed
5. Check for improper local changes in `ObjetosDaKbEmXml`:
   - If detected, preserve those XMLs in `ObjetosGeradosParaImportacaoNaKbNoGenexus`, restore `ObjetosDaKbEmXml` to the official Git version, present a structured manifest of preserved items in the conversation, save it as a local file when incident traceability requires it, and **ABORT** packaging until the snapshot is sane
6. Load [03-risco-e-decisao-por-tipo](../03-risco-e-decisao-por-tipo.md) → assign risk level
7. Evaluate abort conditions:
   - Risk is high/very high AND no comparable internal template exists → **ABORT**
   - Type is not in the empirical corpus → **ABORT**
   - User requests affirmation of import/build success → **REFUSE**, state limitation
8. Locate template:
   - Transaction → use family F1–F6 from [05-transaction-familias-e-templates](../05-transaction-familias-e-templates.md)
   - WebPanel → use closest family from [04-webpanel-familias-e-templates](../04-webpanel-familias-e-templates.md)
   - Other types → use sanitized representative from [08-guia-para-agente-gpt](../08-guia-para-agente-gpt.md) materialization rules
   - If the object has already returned from the KB via official XPZ processing, prefer the current XML in the official corpus over any older delta/import working copy when selecting the base for a new change
   - Before cloning identity fields, classify the container from comparable corpus XML: `Folder` (`parentType="00000000-0000-0000-0000-000000000008"`) versus `Module` (`parentType="c88fffcd-b6f8-0000-8fec-00b5497e2117"`)
9. Apply conservative cloning:
   - Preserve `Object/@guid` (new GUID only for new objects, never reuse existing object's GUID)
   - Preserve `parent`, `parentGuid`, `parentType`, `moduleGuid`
   - Keep all recurring Part types present, even if content is empty
   - Do NOT invent Part types not present in the template
   - Validate identity as a 6-field set before serializing: `fullyQualifiedName`, `name`, `parent`, `parentGuid`, `parentType`, `moduleGuid`
   - Do NOT derive `fullyQualifiedName` by concatenating `parent + "." + name`
   - If `parentType` is `Folder`, treat the folder name as container only; it must appear in `parent`/`parentGuid`, not be promoted automatically into `fullyQualifiedName`
   - If `parentType` is `Module`, allow module qualification in `fullyQualifiedName` only when comparable corpus objects of the same KB confirm that pattern
   - For `WebPanel`, verify where each relevant property is actually persisted before editing: `Conditions` may live in its own `Part`, while `ControlWhere`, `ControlBaseTable`, `ControlOrder`, `ControlUnique`, `PATTERN_ELEMENT_CUSTOM_PROPERTIES`, and `WebUserControlProperties` often live inside serialized layout metadata; follow the operational rules in [02-regras-operacionais-e-runtime](../02-regras-operacionais-e-runtime.md)
   - For `WebPanel`, do NOT treat template defaults mentioning `Conditions` as proof that a real filter is materialized in the object
   - Before generating a new delta for an object that already returned from the KB, compare any intermediate import/delta copy against the official corpus XML and rebase on the official corpus if the working copy is stale
   - If a filter, business rule, or functional interpretation depends on a calculated or derived field, open the field formula/source and review the immediate chain of called procedures before defining the condition
   - Do NOT conclude the semantic meaning of a calculated or derived field from its name, label, or mere XML presence
   - If the change introduces or rewrites `Source`, classify every new operator, function, conversion, and string/numeric pattern introduced by the change
   - Each introduced `Source` construct must be anchored by layer-1 methodological evidence from this XPZ trail: explicit rule, sanitized example, or documented template
   - Local KB corpus may confirm or disambiguate the choice, but does NOT replace layer-1 methodological evidence
   - If an essential `Source` construct is still justified only by plausibility, generic GeneXus memory, or isolated local corpus evidence, rewrite it using documented patterns or **ABORT**
10. Apply envelope rules from [02-regras-operacionais-e-runtime](../02-regras-operacionais-e-runtime.md):
   - Wrap in `<ExportFile>` with `<KMW>`, `<Source>`, `<Objects>`, `<Dependencies>`
   - Keep `Source/@kb` and `Source/Version/@guid` in valid GUID format
   - Do NOT include special KB block unless explicitly documented as required
11. Set or preserve `lastUpdate` according to the batch-role classification:
   - Classify each active XML as `modified in this round` or `reused unchanged for mandatory dependency closure`
   - If any textual change was persisted in the final XML, classify the item as `modified in this round`
   - Modified object → set `lastUpdate` to the real local timestamp of the final write
   - Unchanged dependency object → preserve the official `lastUpdate` from the official corpus XML
   - If classification and materialized `lastUpdate` diverge → **ABORT**
11.5. Audit `lastUpdate` after every local write:
   - After writing or rewriting an object XML, reopen the saved file and confirm the root `lastUpdate`
   - If the object was actually modified, `lastUpdate` must reflect the real instant of that last write
   - If the object was not modified and is included only for mandatory dependency closure, preserve the official `lastUpdate` from the corpus XML
   - Do NOT continue to packaging until the saved-file header has been checked
12. Before packaging, classify active XML roots and validate packaging hygiene:
   - `Object` top-level → serialize under `<Objects>`
   - `Attribute` top-level → serialize under `<Attributes>`
   - Unsupported root type → **ABORT** or require explicit treatment
   - Validate UTF-8 without BOM on every active XML
   - If BOM is present, remove it and register the correction
   - Prefer package names in the form `FrenteCurta_YYYYMMDD_nn`
   - `FrenteCurta` must be short, human-readable, and semantically strong
   - `nn` is only the short incremental round counter for that front on that date, not semantic versioning
   - Do NOT default to name-only, date-only/time-only, excessively long conversation descriptions, or always overwriting the same package name
   - Produce or validate a manifest in the conversation containing at minimum: batch front or short description, batch origin, total XML count, `Objects` count, `Attributes` count, included files list or summary, `lastUpdate` applied or preserved, generated package, superseded package when present, and risk/pending notes
   - Save that manifest as a file only when there is an incident involving `ObjetosDaKbEmXml`, package supersession that needs local traceability, explicit user request, or real need for future handoff outside the immediate conversation
13. Reread and apply local repository documentation before packaging:
   - Reopen `AGENTS.md`, `README.md`, and any equivalent local KB/repository documentation that defines project-specific functional review chains, contracts, or operational flow
   - Treat those local conventions as mandatory only for that repository, not as universal XPZ methodology
   - If the local documentation requires a functional review chain for the current change type, verify that chain end-to-end in the local XML before packaging
   - Do NOT continue to packaging while any applicable local rule remains pending, ambiguous, or inconsistent in the saved XML
14. Validate:
   - XML is well-formed
   - All recurring Part types present
   - No text placeholder GUIDs remaining
   - Template and target share the same structural family
   - Container identity matches comparable corpus evidence for `fullyQualifiedName`, `name`, `parent`, `parentGuid`, `parentType`, and `moduleGuid`
   - When the case depends on IDE-oriented editing, prefer the syntax and structure accepted by the editor/importer, not only what appears to work at runtime
   - Validate `Source` compatibility separately from XML well-formedness
   - A plausible GeneXus `Source` is NOT ready unless every new operator, function, conversion, and string/numeric pattern is backed by methodological evidence from this trail
   - Treat local corpus evidence as confirmation or tie-breaker, not as the sole basis for accepting a new `Source` construct
   - Treat structural XML validation, package-envelope validation, and semantic-contract validation as separate checks
   - Well-formed XML and an acceptable envelope do NOT prove that signatures, formulas, or business meaning are correct
   - If a shared procedure changed its `parm(...)`, review all direct call sites explicitly before concluding the delta
   - This review must include wrappers, business procedures, WorkWith filters, and formulas that call the procedure when applicable
   - When import logs are available, classify each message by stage and failure category before concluding anything
   - Separate at minimum: XML/package structural error, object identity/serialization error, Source syntax/semantic error, IDE-side lateral error, non-blocking warning, and terminal import success
   - Do NOT conclude from an isolated line; use the terminal relevant stage of the log plus the set of blocking messages
   - If some objects failed and others succeeded, report the result as partial instead of collapsing it into full success or full package failure
   - Confirm before packaging that all applicable local repository rules were reread and satisfied in the saved XML
15. Deliver XML with limitations block:
   - Which template was used
   - Confidence level
   - That the saved XML was reread and the persisted `lastUpdate` was confirmed after the final local write
   - Which applicable local repository rules were reread and satisfied before packaging
   - What requires external IDE validation (`Import File Load`, `Import`, `Specification`, runtime)

---

## QUALITY CHECKLIST

- [ ] Risk level assessed before proceeding
- [ ] Abort condition evaluated explicitly
- [ ] Template selected from empirical corpus (not reconstructed from descriptions)
- [ ] `Object/@guid` valid and appropriate (preserved or newly generated)
- [ ] `parent*` and `moduleGuid` preserved from template or context
- [ ] `fullyQualifiedName`, `name`, `parent`, `parentGuid`, `parentType`, and `moduleGuid` were checked together against comparable corpus XML
- [ ] All recurring Part types present (even if empty)
- [ ] No invented Part type GUIDs
- [ ] Envelope complete: `<ExportFile>`, `<KMW>`, `<Source>`, `<Objects>`, `<Dependencies>`
- [ ] `lastUpdate` is a real timestamp, not a placeholder
- [ ] Active XMLs were classified as `modified in this round` or `reused unchanged for mandatory dependency closure`
- [ ] Every modified object XML was reread after writing and its saved `lastUpdate` was confirmed
- [ ] Every unchanged object reused only for dependency closure preserved the official `lastUpdate`
- [ ] Embedded objects in `import_file.xml` were checked for correct `lastUpdate` handling before delivery
- [ ] `ObjetosDaKbEmXml` was treated as read-only official snapshot
- [ ] When the task was packaging, active XMLs were listed from the root of `ObjetosGeradosParaImportacaoNaKbNoGenexus`
- [ ] Candidate batch was isolated; no workspace contamination remained
- [ ] Root type of every active XML was classified before package serialization
- [ ] No top-level `Attribute` was placed under `<Objects>`
- [ ] UTF-8 BOM hygiene was checked on every active XML
- [ ] Generated package name followed the preferred `FrenteCurta_YYYYMMDD_nn` pattern when applicable
- [ ] Batch manifest was produced or validated before packaging, by default in the conversation
- [ ] Any superseded package was either renamed with prefix `OBSOLETO_` or recorded in a structured manifest in the conversation before continuing
- [ ] Manifest file was created only when there was a concrete operational reason
- [ ] Applicable local repository documentation was reread before packaging
- [ ] Applicable local functional review chains, contracts, and operational rules were verified end-to-end in the saved XML before packaging
- [ ] `Source/@kb` and `Source/Version/@guid` are valid GUIDs
- [ ] Every new operator, function, conversion, and string/numeric pattern introduced in `Source` is backed by layer-1 methodological evidence
- [ ] Local corpus evidence, when used for `Source`, was treated only as confirmation or tie-breaker
- [ ] No essential `Source` construct was accepted only because it looked plausible
- [ ] If a shared procedure changed its `parm(...)`, all relevant direct call sites were reviewed explicitly
- [ ] When import logs were used, messages were classified by stage and category before diagnosis
- [ ] The final conclusion was based on the terminal relevant stage, not on an isolated warning or side error
- [ ] Partial success was reported explicitly when only some objects failed
- [ ] Final closing explicitly states that the saved XML was reread, the persisted `lastUpdate` was confirmed, and the applicable local rules were reread and satisfied
- [ ] Limitations block included in output

---

## CONSTRAINTS

- NEVER invent a Part type GUID not present in the selected template
- NEVER affirm import or build success — state "requires external IDE validation"
- NEVER treat `runtime`, `Import File Load`, `Import`, and `Specification` as interchangeable evidence
- NEVER promote a `Folder` name into `fullyQualifiedName` by analogy or by string concatenation alone
- NEVER propose a business filter over status, authorization, cancellation, invoicing, balance, availability, or similar functional meaning if the chosen field is still semantically justified only by its name or UI label
- NEVER treat plausible GeneXus `Source` as ready when its new syntax is not anchored in the methodological base of this trail
- NEVER deliver XML or package with static, inherited, stale, or non-rechecked `lastUpdate`
- NEVER create, alter, move, rename, or overwrite files in `ObjetosDaKbEmXml`
- NEVER treat locally generated XML as if it were the official KB snapshot
- NEVER create automatic subfolders by type under `ObjetosGeradosParaImportacaoNaKbNoGenexus`
- NEVER move files to `ArquivoMorto` without explicit user request
- NEVER place a top-level `Attribute` under `<Objects>`
- NEVER treat `OBSOLETO_` as the default naming convention for normal package generation
- NEVER default to package names that are only subject, only date/time, excessively long conversation prose, or permanent overwrite of the same file name
- NEVER treat an IDE-side lateral error as proof that the XML/package structure failed
- NEVER treat a successful package load as proof that Source, Specification, or runtime are valid
- NEVER universalize a repository-specific functional review rule, contract, or operational convention as if it were a global rule of the shared XPZ methodology
- NEVER generate from a text description or markdown summary alone — requires comparable raw XML template
- NEVER generate special KB block (`KnowledgeBase`, `Settings`) for normal single-object XPZ
- ABORT if risk is high/very high and no internal comparable template is available
- ABORT if type has fewer than 5 specimens in the corpus and no sanitized template exists
- ABORT if container identity is unresolved between `Folder` and `Module` for the target object
- ABORT if more than one plausible batch is active in the workspace
- ABORT if improper local changes are detected in `ObjetosDaKbEmXml` and the snapshot has not been sanitized yet
- ABORT if classification of an item as modified vs unchanged dependency does not match the materialized `lastUpdate`
- ABORT if an active XML has an unsupported top-level root type for the current package flow
- ABORT if a modified object was rewritten locally but the saved-file `lastUpdate` was not verified before packaging
- ABORT if applicable local repository documentation was not reread before packaging
- ABORT if a local functional review chain, contract, or operational rule required by the target KB is still pending or inconsistent in the saved XML
- ABORT if an essential `Source` construct depends only on intuition, generic GeneXus memory, or isolated local corpus evidence
- Absolute rules in [00-readme-genexus-xpz-xml.md](../00-readme-genexus-xpz-xml.md) and [08-guia-para-agente-gpt.md](../08-guia-para-agente-gpt.md) take precedence over all other heuristics
