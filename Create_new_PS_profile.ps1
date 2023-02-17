# Create default profile
$filePath = "$env:USERPROFILE\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1"
$dateTimeFormat = "yyyy-MM-dd_HH-mm-ss"

if (Test-Path $filePath) {
    $backupFilePath = "$filePath-bkp-$(Get-Date -Format $dateTimeFormat)"
    Rename-Item $filePath $backupFilePath
}

$newProfileContents = @'
function setPrompt {
    $location = (Get-Location).Path
    $separator = "\\"
    if ($location.Length -eq 3) {
        return $location[0]
    } elseif ($location -notlike "*\\*") {
        $separator = "\"
    }
    return $location.Split($separator)[-1]
}

function prompt {
    $securePaths = @("C:\Windows",
        "C:\Windows\System32",
        "C:\Program Files",
        "C:\Program Files (x86)")

    if($securePaths -contains (Get-Location).ProviderPath)
    {
        $devDir = "C:\DEV"
        if (-not (Test-Path $devDir)) {
            New-Item -ItemType Directory -Force -Path $devDir
        }
        Set-Location -Path $devDir
    }

    $shortLocation = setPrompt(Get-Location)
    Write-Host $shortLocation -nonewline -Foreground Cyan
    return ' '
}

Set-Location -Path $PWD.Path
prompt
Clear-Host
'@

New-Item $filePath -ItemType File -Force | Out-Null
Set-Content $filePath $newProfileContents

# Copy icon to profile path
$sourcePath = ".\terminal.ico"
$destPath = "$env:USERPROFILE\Documents\WindowsPowerShell\terminal.ico"

if (Test-Path $sourcePath) {
    if (!(Test-Path (Split-Path $destPath))) {
        New-Item -ItemType Directory -Force -Path (Split-Path $destPath)
    }
    Copy-Item $sourcePath $destPath -Force
}
