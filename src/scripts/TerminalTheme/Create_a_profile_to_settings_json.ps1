$terminalSettingsPath = "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"

if (Test-Path $terminalSettingsPath) {
    $backupPath = "$terminalSettingsPath-bkp-$(Get-Date -Format 'dd-MM-yyyy_HH-mm-ss')"
    Copy-Item $terminalSettingsPath $backupPath
}

$terminalSettings = Get-Content $terminalSettingsPath | ConvertFrom-Json

$newGuid = [guid]::NewGuid().ToString()

$newTerminal = @{
    "guid" = "{$newGuid}"
    "name" = "Windows Terminal"
    "commandline" = "powershell.exe -NoLogo -NoExit %USERPROFILE%\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1"
    "icon" = "%USERPROFILE%\Documents\WindowsPowerShell\terminal.ico"
    "hidden" = $false
    "suppressApplicationTitle" = $false
    "startingDirectory" = $null
    "tabTitle" = "Windows Terminal"
    "tabColor" = "#8A2BE2"
    "colorScheme" = "One Half Dark"
}

# Remove any existing terminal with the name "Windows Terminal"
$oldTerminal = $terminalSettings.profiles.list | Where-Object { $_.name -eq "Windows Terminal" }
if ($oldTerminal) {
    $tempList = $terminalSettings.profiles.list | Where-Object { $_.name -ne "Windows Terminal" }
    $terminalSettings.profiles.list = $tempList
}

$terminalSettings.defaultProfile = "{$newGuid}"
$terminalSettings.profiles.list += $newTerminal

$terminalSettings | ConvertTo-Json -Depth 100 | Set-Content $terminalSettingsPath
