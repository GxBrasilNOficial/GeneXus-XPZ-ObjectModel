# GeneXus XPZ Generation Rules

## Purpose

This document records operational rules for generating GeneXus `XPZ` packages safely.

It is intentionally separate from `genexus-xpz-research.md`:
- `research` explains what has been discovered about the format
- this file defines how `XPZ` files should be generated in practice

These rules are expected to evolve as more import, compile, and runtime tests are performed.

## Current Status

The rules below are based on:
- reverse engineering of a real GeneXus 18 `XPZ`
- a first successful import test of a synthetic `XPZ` containing:
  - one `SDT`
  - one `Procedure`
  - one `WebPanel`

## Core Rule

Generate `XPZ` packages with the smallest possible scope.

Practical meaning:
- include only the objects explicitly requested for import
- avoid unrelated metadata
- avoid configuration changes outside the requested objects

## Safety Rules

### Rule 1

Do not include `Knowledge Base` property changes unless the user explicitly requests them.

This includes:
- KB properties
- KB-wide configuration
- global settings not required for object import

### Rule 2

Do not include `Version` property changes unless the user explicitly requests them.

This includes:
- version properties
- design/version-wide configuration
- defaults that may alter the destination KB behavior

### Rule 3

Do not include `Environment` definitions or environment property changes unless the user explicitly requests them.

This includes:
- generator settings
- datastore settings
- build settings
- deployment/runtime settings

### Rule 4

Prefer object-only `XPZ` generation by default.

Default target content:
- `SDT`
- `Procedure`
- `WebPanel`
- other explicitly requested objects

Default non-target content:
- `KnowledgeBase` configuration changes
- `Version` configuration changes
- `Environment` configuration changes

### Rule 5

Minimize collateral impact on the destination KB.

Goal:
- importing a generated `XPZ` should not risk altering the KB beyond the requested objects

### Rule 6

When an `XPZ` is unpacked to a directory for inspection, the unpacked directory name must match the `XPZ` file name without the `.xpz` extension.

Examples:
- `MeuPacote.xpz` -> `MeuPacote`
- `FabricaBrasil18_Full_20260324a.xpz` -> `FabricaBrasil18_Full_20260324a`

Do not use generic unpacked directory names such as `xpz_unpack` for retained project artifacts.

Reason:
- keeps multiple unpacked packages distinguishable
- preserves traceability between the compressed package and its unpacked XML
- avoids ambiguity when newer exports of the same KB are added later

## Generation Guidelines

### Guideline 1

Use real observed object structures as templates whenever possible.

Reason:
- GeneXus objects inside `XPZ` are composed of multiple internal `Part type` sections
- synthetic generation is safer when based on validated examples

### Guideline 2

Prefer the minimum valid `Part type` set required for each object type.

Reason:
- fewer parts reduce the chance of importing hidden side effects
- smaller packages are easier to debug

### Guideline 3

Keep object descriptions, names, and metadata focused and explicit.

Avoid:
- unnecessary generated metadata
- unrelated inheritance from larger exported packages
- irrelevant pattern configuration unless required

## Validation Rules

### Rule 7

Before delivering a generated `XPZ`, validate at least:
- the XML is well-formed
- the package is correctly compressed
- the package contains the expected XML payload

### Rule 8

Treat import success as only the first validation level.

Validation levels:
1. package import succeeds
2. objects open correctly in GeneXus
3. objects compile
4. runtime behavior works as expected

Do not assume import success means functional correctness.

## Lessons Confirmed So Far

### Confirmed Lesson 1

A synthetic `XPZ` can be generated and successfully imported into a GeneXus test KB.

### Confirmed Lesson 2

It is possible to package only requested objects and achieve a successful import.

### Confirmed Lesson 3

Destination KB safety requires avoiding KB/Version/Environment changes by default.

## Working Default Policy

Unless explicitly requested otherwise:
- generate only requested objects
- do not modify KB properties
- do not modify Version properties
- do not modify Environment definitions
- keep the package minimal and test-oriented
- when retaining an unpacked `XPZ`, name its directory exactly as the package file name without `.xpz`

## Open Items

The following still need more evidence:
- minimum safe metadata set per object type
- when checksums matter for import stability
- whether some object types require additional hidden parts
- whether the same rules apply across all GeneXus 18 upgrades

## Next Review Trigger

This file should be updated whenever one of these happens:
- a generated `XPZ` imports successfully
- a generated `XPZ` imports with warnings or errors
- an imported object fails compilation
- runtime behavior reveals structural problems
- a new safety rule is discovered
