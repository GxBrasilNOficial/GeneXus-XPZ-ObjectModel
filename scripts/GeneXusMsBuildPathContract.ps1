function Get-FullPathSafe {
    param([string]$PathValue)

    if ([string]::IsNullOrWhiteSpace($PathValue)) {
        return $null
    }

    return [System.IO.Path]::GetFullPath($PathValue)
}

function Test-IsUnderProgramFilesX86 {
    param(
        [string]$PathValue,
        [string]$ProgramFilesX86 = [System.IO.Path]::GetFullPath('C:\Program Files (x86)')
    )

    if ([string]::IsNullOrWhiteSpace($PathValue)) {
        return $false
    }

    $fullPath = Get-FullPathSafe -PathValue $PathValue
    $candidate = $fullPath.TrimEnd('\')
    $root = $ProgramFilesX86.TrimEnd('\')
    return $candidate.StartsWith($root, [System.StringComparison]::OrdinalIgnoreCase)
}

function Resolve-ExplicitWorkingDirectory {
    param(
        [Parameter(Mandatory = $true)]
        [string]$PathValue,

        [string]$ProgramFilesX86 = [System.IO.Path]::GetFullPath('C:\Program Files (x86)'),

        [int]$FailureCode = 13
    )

    $resolved = Get-FullPathSafe -PathValue $PathValue
    $checkName = 'WorkingDirectory outside Program Files x86'
    $invalidReason = "WorkingDirectory inválido ou inseguro: '{0}'." -f $resolved

    if ([string]::IsNullOrWhiteSpace($resolved)) {
        return [ordered]@{
            path = $resolved
            result = 'fail'
            detail = 'WorkingDirectory não pôde ser resolvido para um caminho completo.'
            code = $FailureCode
            check = [ordered]@{
                name = $checkName
                result = 'fail'
                detail = 'WorkingDirectory não pôde ser resolvido para um caminho completo.'
            }
            autoCreated = $false
            pathAction = 'blocked-invalid'
            blockingReason = $invalidReason
            warning = $null
            strategyTrace = 'WorkingDirectory explícito não pôde ser resolvido e permaneceu bloqueado.'
        }
    }

    if (Test-IsUnderProgramFilesX86 -PathValue $resolved -ProgramFilesX86 $ProgramFilesX86) {
        return [ordered]@{
            path = $resolved
            result = 'fail'
            detail = 'Diretório aponta para árvore estritamente somente leitura.'
            code = $FailureCode
            check = [ordered]@{
                name = $checkName
                result = 'fail'
                detail = 'Diretório aponta para árvore estritamente somente leitura.'
            }
            autoCreated = $false
            pathAction = 'blocked-readonly'
            blockingReason = $invalidReason
            warning = $null
            strategyTrace = 'WorkingDirectory explícito foi bloqueado por apontar para a árvore somente leitura.'
        }
    }

    if (Test-Path -LiteralPath $resolved -PathType Leaf) {
        return [ordered]@{
            path = $resolved
            result = 'fail'
            detail = 'O caminho informado existe como arquivo, não como diretório.'
            code = $FailureCode
            check = [ordered]@{
                name = $checkName
                result = 'fail'
                detail = 'O caminho informado existe como arquivo, não como diretório.'
            }
            autoCreated = $false
            pathAction = 'blocked-file'
            blockingReason = $invalidReason
            warning = $null
            strategyTrace = 'WorkingDirectory explícito foi bloqueado porque aponta para um arquivo existente.'
        }
    }

    if (Test-Path -LiteralPath $resolved -PathType Container) {
        return [ordered]@{
            path = $resolved
            result = 'ok'
            detail = 'Diretório válido e fora da árvore somente leitura.'
            code = 0
            check = [ordered]@{
                name = $checkName
                result = 'ok'
                detail = 'Diretório válido e fora da árvore somente leitura.'
            }
            autoCreated = $false
            pathAction = 'validated-existing'
            blockingReason = $null
            warning = $null
            strategyTrace = 'WorkingDirectory explícito já existia e foi validado como seguro.'
        }
    }

    try {
        [System.IO.Directory]::CreateDirectory($resolved) | Out-Null
        return [ordered]@{
            path = $resolved
            result = 'ok'
            detail = 'Diretório ausente no caminho seguro informado; pasta auto-criada.'
            code = 0
            check = [ordered]@{
                name = $checkName
                result = 'ok'
                detail = 'Diretório ausente no caminho seguro informado; pasta auto-criada.'
            }
            autoCreated = $true
            pathAction = 'validated-and-created'
            blockingReason = $null
            warning = ('WorkingDirectory ausente foi criado automaticamente no caminho explícito e seguro: {0}' -f $resolved)
            strategyTrace = 'WorkingDirectory explícito não existia; o script criou exatamente o diretório informado após validar segurança.'
        }
    }
    catch {
        return [ordered]@{
            path = $resolved
            result = 'fail'
            detail = 'Falha ao criar o diretório explícito informado após validação de segurança.'
            code = $FailureCode
            check = [ordered]@{
                name = $checkName
                result = 'fail'
                detail = 'Falha ao criar o diretório explícito informado após validação de segurança.'
            }
            autoCreated = $false
            pathAction = 'blocked-create-failed'
            blockingReason = ("WorkingDirectory inválido ou inseguro: '{0}'. Falha ao criar a pasta explícita: {1}" -f $resolved, $_.Exception.Message)
            warning = $null
            strategyTrace = 'WorkingDirectory explícito passou na validação de segurança, mas a criação da pasta falhou.'
        }
    }
}
