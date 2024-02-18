# Define o novo servidor de timesync
$timesyncServer = "pool.ntp.org"

# Configura o novo servidor de timesync
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\W32Time\Parameters" `
    -Name "NtpServer" `
    -Value $timesyncServer `
    -Force

# Reinicia o serviço de timesync
Restart-Service w32time -Force

# Aguarda um momento para que o serviço de timesync seja reiniciado
Start-Sleep -Seconds 5

# Sincroniza o horário do sistema com o servidor de timesync
w32tm /resync /nowait
Pause