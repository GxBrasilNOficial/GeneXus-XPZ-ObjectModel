#requires -version 5.1
<#
.SYNOPSIS
Wrapper local sanitizado para gate leve de sanidade do `Source` em XMLs locais.

.DESCRIPTION
Executa o script compartilhado `Test-GeneXusSourceSanity.ps1` sobre um XML
especifico ou sobre todos os XMLs da subpasta ativa de uma frente em
`ObjetosGeradosParaImportacaoNaKbNoGenexus`.

Use este wrapper antes de gerar `import_file.xml` a partir de XML local
ajustado pelo agente. Ele nao prova importacao nem build; apenas separa
`xmlWellFormed`, `sourceSanityStatus` e `probablyImportable`.

.PARAMETER InputPath
Caminho de um XML especifico ou de uma pasta contendo os XMLs da frente ativa.

.PARAMETER SharedSkillsRoot
Raiz local da base compartilhada `GeneXus-XPZ-Skills`.

.EXAMPLE
.\Test-KbSourceSanity.ps1 -InputPath C:\KB\ObjetosGeradosParaImportacaoNaKbNoGenexus\MinhaFrente_GUID_20260428

.EXAMPLE
.\Test-KbSourceSanity.ps1 -InputPath C:\KB\ObjetosGeradosParaImportacaoNaKbNoGenexus\MinhaFrente_GUID_20260428\MinhaProcedure.xml
#>

param(
    [Parameter(Mandatory = $true)]
    [string]$InputPath,

    [string]$SharedSkillsRoot = "C:\CAMINHO\PARA\GeneXus-XPZ-Skills"
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$enginePath = Join-Path $SharedSkillsRoot "scripts\Test-GeneXusSourceSanity.ps1"
if (-not (Test-Path -LiteralPath $enginePath)) {
    throw "Shared source sanity script not found: $enginePath"
}

$resolvedInput = Resolve-Path -LiteralPath $InputPath
$targetPath = $resolvedInput.Path

$files = @()
if (Test-Path -LiteralPath $targetPath -PathType Leaf) {
    $files = @($targetPath)
} elseif (Test-Path -LiteralPath $targetPath -PathType Container) {
    $files = @(Get-ChildItem -LiteralPath $targetPath -Filter *.xml -File | Select-Object -ExpandProperty FullName)
} else {
    throw "InputPath is neither file nor directory: $targetPath"
}

if ($files.Count -eq 0) {
    throw "No XML files found in: $targetPath"
}

$results = New-Object System.Collections.Generic.List[object]
foreach ($file in $files) {
    $json = & $enginePath -InputPath $file -AsJson
    $parsed = $json | ConvertFrom-Json
    $results.Add($parsed) | Out-Null
}

$hasXmlError = @($results | Where-Object { -not $_.xmlWellFormed }).Count -gt 0
$hasFail = @($results | Where-Object { $_.sourceSanityStatus -eq 'fail' }).Count -gt 0
$hasWarn = @($results | Where-Object { $_.sourceSanityStatus -eq 'warn' }).Count -gt 0

$summary = [pscustomobject]@{
    inputPath          = $targetPath
    fileCount          = $files.Count
    xmlWellFormed      = (-not $hasXmlError)
    sourceSanityStatus = if ($hasFail) { 'fail' } elseif ($hasWarn) { 'warn' } else { 'pass' }
    probablyImportable = (-not $hasXmlError) -and (-not $hasFail)
    results            = $results.ToArray()
}

$summary | ConvertTo-Json -Depth 8

if ($hasXmlError -or $hasFail) {
    exit 1
}
