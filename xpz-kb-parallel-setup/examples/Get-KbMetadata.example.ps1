#requires -version 5.1
<#
.SYNOPSIS
Wrapper local sanitizado para ler campos chave de kb-source-metadata.md.

.DESCRIPTION
Le kb-source-metadata.md na raiz da pasta paralela da KB e retorna campos chave
como texto estruturado. Elimina o padrao recorrente de Select-String + regex
inline nos chamadores.

Campos retornados: last_xpz_materialization_run_at, kb_name, source_guid.
Campos ausentes sao indicados com "(ausente)" em vez de falha silenciosa.

.PARAMETER MetadataPath
Caminho opcional para kb-source-metadata.md.
Quando omitido, usa kb-source-metadata.md na raiz da pasta paralela da KB.

.EXAMPLE
.\Get-KbMetadata.ps1

.EXAMPLE
.\Get-KbMetadata.ps1 -MetadataPath "C:\CAMINHO\PARA\kb-source-metadata.md"
#>

param(
    [string]$MetadataPath
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$repoRoot = Split-Path -Parent $PSScriptRoot

if (-not $MetadataPath) {
    $MetadataPath = Join-Path $repoRoot 'kb-source-metadata.md'
}

if (-not (Test-Path -LiteralPath $MetadataPath -PathType Leaf)) {
    throw "kb-source-metadata.md not found: $MetadataPath"
}

$fields = @(
    'last_xpz_materialization_run_at',
    'kb_name',
    'source_guid'
)

foreach ($field in $fields) {
    $match = Select-String -LiteralPath $MetadataPath -Pattern "^$field\s*[:=]\s*(.+)$"
    if ($match) {
        $value = $match.Matches[0].Groups[1].Value.Trim()
        "${field}: $value"
    } else {
        "${field}: (ausente)"
    }
}
