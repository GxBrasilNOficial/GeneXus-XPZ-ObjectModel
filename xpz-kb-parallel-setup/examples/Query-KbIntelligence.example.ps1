#requires -version 5.1
<#
.SYNOPSIS
Wrapper local sanitizado para consultar o indice derivado da KB.

.DESCRIPTION
Usa o indice local padrao da pasta paralela da KB e delega a consulta ao motor
compartilhado desta base metodologica.

.PARAMETER Query
Consulta a executar no indice.

.PARAMETER IndexPath
Caminho opcional para um SQLite alternativo. O padrao local aponta para
`KbIntelligence\kb-intelligence.sqlite`.

.PARAMETER SharedSkillsRoot
Raiz local da base compartilhada `GeneXus-XPZ-Skills`. Use este parametro quando
o wrapper sanitizado for adaptado para um ambiente com outro caminho local.

.EXAMPLE
.\Query-KbIntelligence.ps1 -Query impact-basic -ObjectType Procedure -ObjectName procExemplo -Limit 10 -Format text

.EXAMPLE
.\Query-KbIntelligence.ps1 -Query functional-trace-basic -ObjectType Procedure -ObjectName procExemplo -Limit 20 -Format text

.EXAMPLE
.\Query-KbIntelligence.ps1 -Query index-metadata -Format text
#>

param(
    [Parameter(Mandatory = $true)]
    [ValidateSet("object-info", "search-objects", "who-uses", "what-uses", "show-evidence", "impact-basic", "functional-trace-basic", "index-metadata")]
    [string]$Query,

    [string]$IndexPath,

    [string]$ObjectType,
    [string]$ObjectName,
    [int]$RelationId,
    [string]$SourceType,
    [string]$SourceName,
    [string]$TargetType,
    [string]$TargetName,
    [int]$Limit,

    [ValidateSet("json", "text")]
    [string]$Format = "json",

    [string]$SharedSkillsRoot = "C:\CAMINHO\PARA\GeneXus-XPZ-Skills"
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$repoRoot = Split-Path -Parent $PSScriptRoot
$enginePath = Join-Path $SharedSkillsRoot "scripts\Query-KbIntelligenceIndex.ps1"

if (-not $IndexPath) {
    $IndexPath = Join-Path $repoRoot "KbIntelligence\kb-intelligence.sqlite"
}

if (-not (Test-Path -LiteralPath $enginePath)) {
    throw "Engine script not found: $enginePath"
}

if (-not (Test-Path -LiteralPath $IndexPath)) {
    throw "KB Intelligence index not found: $IndexPath"
}

$params = @{
    IndexPath = $IndexPath
    Query     = $Query
    Format    = $Format
}

if ($ObjectType) { $params.ObjectType = $ObjectType }
if ($ObjectName) { $params.ObjectName = $ObjectName }
if ($RelationId) { $params.RelationId = $RelationId }
if ($SourceType) { $params.SourceType = $SourceType }
if ($SourceName) { $params.SourceName = $SourceName }
if ($TargetType) { $params.TargetType = $TargetType }
if ($TargetName) { $params.TargetName = $TargetName }
if ($Limit) { $params.Limit = $Limit }

& $enginePath @params
exit $LASTEXITCODE
