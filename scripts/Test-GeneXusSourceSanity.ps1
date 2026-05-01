[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [string]$InputPath,

    [switch]$AsJson
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

function Get-LinePreview {
    param(
        [string]$Line
    )

    if ($null -eq $Line) {
        return ""
    }

    $trimmed = $Line.Trim()
    if ($trimmed.Length -le 140) {
        return $trimmed
    }

    return $trimmed.Substring(0, 140) + "..."
}

function New-Finding {
    param(
        [string]$Severity,
        [string]$Code,
        [string]$Message,
        [int]$LineNumber,
        [string]$LinePreview
    )

    return [pscustomobject]@{
        severity    = $Severity
        code        = $Code
        message     = $Message
        lineNumber  = $LineNumber
        linePreview = $LinePreview
    }
}

function Get-OpenTokenKind {
    param(
        [string]$Line
    )

    if ($Line -match '^(?i)\s*sub\b') {
        return "Sub"
    }

    if ($Line -match '^(?i)\s*for\b') {
        return "ForEach"
    }

    if ($Line -match '^(?i)\s*do\s+case\b') {
        return "DoCase"
    }

    if ($Line -match '^(?i)\s*if\b') {
        if ($Line -match ';\s*$') { return $null }
        return "If"
    }

    return $null
}

function Get-CloseTokenKind {
    param(
        [string]$Line
    )

    if ($Line -match '^(?i)\s*endsub\b') {
        return "Sub"
    }

    if ($Line -match '^(?i)\s*endfor\b') {
        return "ForEach"
    }

    if ($Line -match '^(?i)\s*endcase\b') {
        return "DoCase"
    }

    if ($Line -match '^(?i)\s*endif\b') {
        return "If"
    }

    return $null
}

function Test-SourceTextSanity {
    param(
        [string]$SourceText,
        [string]$SourceLabel
    )

    $lines = ($SourceText -split "`r?`n")
    $stack = New-Object System.Collections.Generic.List[object]
    $findings = New-Object System.Collections.Generic.List[object]

    for ($index = 0; $index -lt $lines.Count; $index++) {
        $lineNumber = $index + 1
        $rawLine = $lines[$index]
        $lineWithoutComment = [regex]::Replace($rawLine, '//.*$', '')
        $preview = Get-LinePreview -Line $rawLine

        $closeKind = Get-CloseTokenKind -Line $lineWithoutComment
        if ($null -ne $closeKind) {
            if ($stack.Count -eq 0) {
                $findings.Add((New-Finding -Severity "fail" -Code "unexpected-close" -Message "${SourceLabel}: fechamento '$closeKind' sem abertura correspondente." -LineNumber $lineNumber -LinePreview $preview)) | Out-Null
            } else {
                $top = $stack[$stack.Count - 1]
                if ($top.kind -ne $closeKind) {
                    $message = "${SourceLabel}: fechamento '$closeKind' nao corresponde ao ultimo bloco aberto '$($top.kind)' iniciado na linha $($top.lineNumber)."
                    $findings.Add((New-Finding -Severity "fail" -Code "mismatched-close" -Message $message -LineNumber $lineNumber -LinePreview $preview)) | Out-Null
                } else {
                    $stack.RemoveAt($stack.Count - 1)
                }
            }
        }

        $openKind = Get-OpenTokenKind -Line $lineWithoutComment
        if ($null -ne $openKind) {
            $stack.Add([pscustomobject]@{
                kind       = $openKind
                lineNumber = $lineNumber
                preview    = $preview
            }) | Out-Null
        }

        if ($lineWithoutComment -match '(?i)\belseif\b') {
            $findings.Add((New-Finding -Severity "warn" -Code "elseif" -Message "${SourceLabel}: uso de 'elseif' detectado; prefira forma conservadora documentada quando houver duvida." -LineNumber $lineNumber -LinePreview $preview)) | Out-Null
        }

        if ($lineWithoutComment -match '(?i)\biif\s*\(') {
            $findings.Add((New-Finding -Severity "warn" -Code "iif" -Message "${SourceLabel}: uso de 'iif(...)' detectado; revisar se a trilha metodologica sustenta essa forma." -LineNumber $lineNumber -LinePreview $preview)) | Out-Null
        }

        if ($lineWithoutComment -match '^(?i)\s*(if|elseif)\b') {
            $booleanOps = ([regex]::Matches($lineWithoutComment, '(?i)\b(and|or|not)\b')).Count
            if ($booleanOps -ge 4 -or $lineWithoutComment.Length -ge 160) {
                $findings.Add((New-Finding -Severity "warn" -Code "dense-condition" -Message "${SourceLabel}: condicao potencialmente densa; revisar se o delta pode ser reescrito em forma mais conservadora." -LineNumber $lineNumber -LinePreview $preview)) | Out-Null
            }

            if ($lineWithoutComment -match '(?i)\b[a-z_][a-z0-9_]*\s*\(') {
                $findings.Add((New-Finding -Severity "warn" -Code "call-in-condition" -Message "${SourceLabel}: chamada detectada dentro de condicao; comparar com o estilo dominante do proprio objeto antes de empacotar." -LineNumber $lineNumber -LinePreview $preview)) | Out-Null
            }
        }
    }

    foreach ($remaining in $stack) {
        $message = "${SourceLabel}: bloco '$($remaining.kind)' aberto na linha $($remaining.lineNumber) sem fechamento correspondente."
        $findings.Add((New-Finding -Severity "fail" -Code "unclosed-block" -Message $message -LineNumber $remaining.lineNumber -LinePreview $remaining.preview)) | Out-Null
    }

    return $findings
}

function Get-ObjectSourceParts {
    param(
        [System.Xml.XmlElement]$ObjectNode
    )

    $parts = New-Object System.Collections.Generic.List[object]
    $partNodes = $ObjectNode.SelectNodes("./Part[Source]")
    foreach ($partNode in $partNodes) {
        $sourceNode = $partNode.SelectSingleNode("./Source")
        if ($null -eq $sourceNode) {
            continue
        }

        $parts.Add([pscustomobject]@{
            partType   = $partNode.GetAttribute("type")
            sourceText = $sourceNode.InnerText
        }) | Out-Null
    }

    return $parts
}

if (-not (Test-Path -LiteralPath $InputPath)) {
    throw "InputPath not found: $InputPath"
}

$rawXml = Get-Content -LiteralPath $InputPath -Raw -Encoding UTF8
$result = [ordered]@{
    inputPath              = (Resolve-Path -LiteralPath $InputPath).Path
    xmlWellFormed          = $false
    rootElement            = $null
    sourceSanityStatus     = "not-applicable"
    probablyImportable     = $false
    objectCount            = 0
    sourcePartCount        = 0
    failCount              = 0
    warnCount              = 0
    findings               = @()
}

try {
    $xmlDocument = New-Object System.Xml.XmlDocument
    $xmlDocument.PreserveWhitespace = $true
    $xmlDocument.LoadXml($rawXml)
    $result.xmlWellFormed = $true
    $result.rootElement = $xmlDocument.DocumentElement.LocalName
} catch {
    $result.findings = @(
        [pscustomobject]@{
            severity    = "fail"
            code        = "xml-parse"
            message     = "XML malformado: $($_.Exception.Message)"
            lineNumber  = 0
            linePreview = ""
        }
    )
    $result.failCount = 1
    if ($AsJson) {
        $result | ConvertTo-Json -Depth 6
    } else {
        [pscustomobject]$result
    }
    return
}

$sourceTargets = New-Object System.Collections.Generic.List[object]
$root = $xmlDocument.DocumentElement

if ($root.LocalName -eq "ExportFile") {
    $objectNodes = $root.SelectNodes("./Objects/Object")
    foreach ($objectNode in $objectNodes) {
        $objectName = $objectNode.GetAttribute("name")
        $objectType = $objectNode.GetAttribute("type")
        $partSources = Get-ObjectSourceParts -ObjectNode $objectNode
        foreach ($partSource in $partSources) {
            $sourceTargets.Add([pscustomobject]@{
                objectName  = $objectName
                objectType  = $objectType
                partType    = $partSource.partType
                sourceLabel = "Object:$objectName Part:$($partSource.partType)"
                sourceText  = $partSource.sourceText
            }) | Out-Null
        }
    }
    $result.objectCount = $objectNodes.Count
} elseif ($root.LocalName -eq "Object") {
    $partSources = Get-ObjectSourceParts -ObjectNode $root
    foreach ($partSource in $partSources) {
        $sourceTargets.Add([pscustomobject]@{
            objectName  = $root.GetAttribute("name")
            objectType  = $root.GetAttribute("type")
            partType    = $partSource.partType
            sourceLabel = "Object:$($root.GetAttribute("name")) Part:$($partSource.partType)"
            sourceText  = $partSource.sourceText
        }) | Out-Null
    }
    $result.objectCount = 1
}

$allFindings = New-Object System.Collections.Generic.List[object]
foreach ($sourceTarget in $sourceTargets) {
    if ([string]::IsNullOrWhiteSpace($sourceTarget.sourceText)) {
        continue
    }

    $findings = Test-SourceTextSanity -SourceText $sourceTarget.sourceText -SourceLabel $sourceTarget.sourceLabel
    foreach ($finding in $findings) {
        $allFindings.Add($finding) | Out-Null
    }
}

$result.sourcePartCount = $sourceTargets.Count
$result.findings = $allFindings.ToArray()
$result.failCount = @($allFindings | Where-Object { $_.severity -eq "fail" }).Count
$result.warnCount = @($allFindings | Where-Object { $_.severity -eq "warn" }).Count

if ($sourceTargets.Count -eq 0) {
    $result.sourceSanityStatus = "not-applicable"
    $result.probablyImportable = [bool]$result.xmlWellFormed
} elseif ($result.failCount -gt 0) {
    $result.sourceSanityStatus = "fail"
    $result.probablyImportable = $false
} elseif ($result.warnCount -gt 0) {
    $result.sourceSanityStatus = "warn"
    $result.probablyImportable = $true
} else {
    $result.sourceSanityStatus = "pass"
    $result.probablyImportable = $true
}

if ($AsJson) {
    $result | ConvertTo-Json -Depth 6
} else {
    [pscustomobject]$result
}
