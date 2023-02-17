# Create default profile
$filePath = "$env:USERPROFILE\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1"
$dateTimeFormat = "yyyy-MM-dd_HH-mm-ss"

if (Test-Path $filePath) {
    $backupFilePath = "$filePath-bkp-$(Get-Date -Format $dateTimeFormat)"
    Rename-Item $filePath $backupFilePath
}

$newProfileContents = @'
function formatCurrentLocation {
    param([string]$location)
    $separator = "\\"
    if ($location.Length -eq 3) {
        return $location[0]
    } elseif ($location -notlike "*\\*") {
        $separator = "\"
    }
    return $location.Split($separator)[-1]
}

$securePaths = @("C:\Windows\System32")
$securePathAccessCount = @{}
$defaultColor = "Cyan"
$alertColor = "Red"

function prompt {
    $providerPath = (Get-Location).ProviderPath  
    if($securePaths -contains $providerPath)
    {
        if ($securePathAccessCount.ContainsKey($providerPath)) {
            $securePathAccessCount[$providerPath] += 1
        } else {
            $securePathAccessCount[$providerPath] = 1
        }
        
        if ($securePathAccessCount[$providerPath] -gt 1) {
            Set-Location -Path $providerPath
        } else {
            $devDir = "C:\DEV"
            if (-not (Test-Path $devDir)) {
                New-Item -ItemType Directory -Force -Path $devDir
            }
            Set-Location -Path $devDir

            Write-Host "First access to secure location denied. Second attempt is allowed." -ForegroundColor $alertColor
            Write-Host "$(formatCurrentLocation($devDir))" -NoNewline -ForegroundColor $defaultColor
            return ' '
        }
    }
    
    Write-Host "$(formatCurrentLocation(Get-Location))" -NoNewline -ForegroundColor $defaultColor
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