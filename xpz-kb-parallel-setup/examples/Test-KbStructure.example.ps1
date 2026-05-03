#requires -version 5.1
<#
.SYNOPSIS
Wrapper local sanitizado para verificar a estrutura da pasta paralela da KB.

.DESCRIPTION
Verifica presenca de pastas obrigatorias, scripts esperados,
KbIntelligence\kb-intelligence.sqlite e kb-source-metadata.md. Retorna relatorio
de presenca/ausencia de cada componente. Usado no setup inicial e em diagnostico
antes de qualquer operacao.

Os nomes de script verificados usam a forma curta sanitizada; na KB real, substituir
pelos nomes definitivos com o identificador da KB (ex: Test-FabricaBrasilKbGate.ps1).

.PARAMETER KbRoot
Caminho opcional para a raiz da pasta paralela da KB.
Quando omitido, usa a pasta pai da pasta scripts deste wrapper.

.EXAMPLE
.\Test-KbStructure.ps1

.EXAMPLE
.\Test-KbStructure.ps1 -KbRoot "C:\CAMINHO\PARA\PastaParalelaDaKb"
#>

param(
    [string]$KbRoot
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

if (-not $KbRoot) {
    $KbRoot = Split-Path -Parent $PSScriptRoot
}

function Get-KnownTypeMap {
    $repoRoot = Split-Path -Parent (Split-Path -Parent $PSScriptRoot)
    $catalogPath = Join-Path $repoRoot 'scripts\gx-object-type-catalog.json'
    if (-not (Test-Path -LiteralPath $catalogPath -PathType Leaf)) {
        throw "Object type catalog not found: $catalogPath"
    }

    $rawCatalog = Get-Content -LiteralPath $catalogPath -Raw
    $catalog = $rawCatalog | ConvertFrom-Json
    $map = @{}
    foreach ($property in $catalog.types.PSObject.Properties) {
        $entry = $property.Value
        if ($null -eq $entry.objectTypeGuid -or [string]::IsNullOrWhiteSpace([string]$entry.objectTypeGuid)) {
            continue
        }
        $map[[string]$entry.objectTypeGuid.ToLowerInvariant()] = [string]$property.Name
    }

    return $map
}

$results = [System.Collections.Generic.List[pscustomobject]]::new()

function Test-Component {
    param(
        [string]$Label,
        [string]$Path,
        [string]$Type  # 'Container' ou 'Leaf'
    )
    $exists = Test-Path -LiteralPath $Path -PathType $Type
    $results.Add([pscustomobject]@{
        Component = $Label
        Status    = if ($exists) { 'OK' } else { 'AUSENTE' }
        Path      = $Path
    })
}

foreach ($folder in @(
    'scripts',
    'Temp',
    'XpzExportadosPelaIDE',
    'ObjetosDaKbEmXml',
    'KbIntelligence',
    'ObjetosGeradosParaImportacaoNaKbNoGenexus',
    'PacotesGeradosParaImportacaoNaKbNoGenexus'
)) {
    Test-Component -Label "pasta\$folder" -Path (Join-Path $KbRoot $folder) -Type Container
}

foreach ($file in @('AGENTS.md', 'README.md', 'kb-source-metadata.md')) {
    Test-Component -Label $file -Path (Join-Path $KbRoot $file) -Type Leaf
}

$scriptsDir = Join-Path $KbRoot 'scripts'
foreach ($script in @(
    'Update-KbFromXpz.ps1',
    'Test-KbFullSnapshot.ps1',
    'Query-KbIntelligence.ps1',
    'Rebuild-KbIntelligenceIndex.ps1',
    'Test-KbGate.ps1',
    'Get-KbMetadata.ps1',
    'Test-KbMetadataWrapper.ps1',
    'Test-KbStructure.ps1',
    'Test-KbSetupAudit.ps1'
)) {
    Test-Component -Label "scripts\$script" -Path (Join-Path $scriptsDir $script) -Type Leaf
}

Test-Component -Label 'KbIntelligence\kb-intelligence.sqlite' `
    -Path (Join-Path $KbRoot 'KbIntelligence\kb-intelligence.sqlite') -Type Leaf

# Auditoria de parse dos scripts esperados
foreach ($scriptName in @(
    'Update-KbFromXpz.ps1',
    'Test-KbFullSnapshot.ps1',
    'Query-KbIntelligence.ps1',
    'Rebuild-KbIntelligenceIndex.ps1',
    'Test-KbGate.ps1',
    'Get-KbMetadata.ps1',
    'Test-KbMetadataWrapper.ps1',
    'Test-KbStructure.ps1',
    'Test-KbSetupAudit.ps1'
)) {
    $scriptPath = Join-Path $scriptsDir $scriptName
    if (-not (Test-Path -LiteralPath $scriptPath -PathType Leaf)) { continue }
    $parseTokens = $null
    $parseErrors = $null
    [System.Management.Automation.Language.Parser]::ParseFile($scriptPath, [ref]$parseTokens, [ref]$parseErrors) | Out-Null
    if ($parseErrors.Count -gt 0) {
        $errorSummary = ($parseErrors | ForEach-Object { "linha $($_.Extent.StartLineNumber): $($_.Message)" }) -join '; '
        $results.Add([pscustomobject]@{
            Component = "scripts\$scriptName"
            Status    = 'PARSE_ERROR'
            Path      = $errorSummary
        })
    }
}

# Auditoria de naming em ObjetosDaKbEmXml
$acervoPath = Join-Path $KbRoot 'ObjetosDaKbEmXml'
$namingDivergencias = [System.Collections.Generic.List[string]]::new()
if (Test-Path -LiteralPath $acervoPath -PathType Container) {
    $guidToType = Get-KnownTypeMap
    foreach ($dir in Get-ChildItem -LiteralPath $acervoPath -Directory | Sort-Object Name) {
        $xml = Get-ChildItem -LiteralPath $dir.FullName -Filter '*.xml' | Select-Object -First 1
        if (-not $xml) { continue }
        $content = Get-Content -LiteralPath $xml.FullName -Raw
        $first1024 = $content.Substring(0, [Math]::Min(1024, $content.Length))
        if ($first1024 -match '^\s*<\?xml[^>]*\?>\s*<Attributes?\b') {
            $canonicalType = 'Attribute'
        } elseif ($content -match '<Object\b[^>]*\btype="([^"]+)"') {
            $guid = $Matches[1]
            $canonicalType = if ($guidToType.ContainsKey($guid)) { $guidToType[$guid] } else { "GUID_DESCONHECIDO:$guid" }
        } else {
            $canonicalType = 'DESCONHECIDO'
        }
        $dirName = $dir.Name
        if ($dirName -eq $canonicalType) {
            $results.Add([pscustomobject]@{
                Component = "ObjetosDaKbEmXml\$dirName"
                Status    = 'NAMING_OK'
                Path      = $dir.FullName
            })
        } else {
            $results.Add([pscustomobject]@{
                Component = "ObjetosDaKbEmXml\$dirName"
                Status    = 'NAMING_DIVERGENTE'
                Path      = "tipo real: $canonicalType; renomear para '$canonicalType' via xpz-kb-parallel-setup"
            })
            $namingDivergencias.Add("  $dirName -> $canonicalType")
        }
    }
}

$results | Format-Table -AutoSize

if ($namingDivergencias.Count -gt 0) {
    Write-Warning "$($namingDivergencias.Count) diretorio(s) em ObjetosDaKbEmXml com nome divergente do tipo canonico:"
    $namingDivergencias | ForEach-Object { Write-Warning $_ }
    Write-Warning "Corrija os nomes via xpz-kb-parallel-setup (modo_atualizacao)."
}

$blocked = @($results | Where-Object { $_.Status -in @('AUSENTE', 'PARSE_ERROR') })
if ($blocked.Count -gt 0) {
    $ausenteCount = @($results | Where-Object { $_.Status -eq 'AUSENTE' }).Count
    $parseCount   = @($results | Where-Object { $_.Status -eq 'PARSE_ERROR' }).Count
    if ($ausenteCount -gt 0) {
        Write-Warning ("$ausenteCount componente(s) ausente(s). Execute xpz-kb-parallel-setup para corrigir.")
    }
    if ($parseCount -gt 0) {
        Write-Warning ("$parseCount script(s) com erro de parse detectado pelo parser do PowerShell. Corrija antes de continuar.")
    }
    exit 1
}

Write-Output 'STRUCTURE_OK'
