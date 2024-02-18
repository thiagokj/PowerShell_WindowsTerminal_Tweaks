# Configurando o OhMyPosh

Instale via powershell
```shell
Install-Module oh-my-posh -Scope CurrentUser

# Crie um arquivo para configurar o perfil
Microsoft.PowerShell_profile.ps1

# Para acessa-lo, utilize
notepad $PROFILE

# Adicione esses comandos para usar o tema Paradox
Import-Module oh-my-posh
Set-PoshPrompt -Theme paradox
```

Outros temas podem ser adicionados. No Windows, os temas ficam no diretorio
`C:\Users\%USERNAME%\AppData\Local\Programs\oh-my-posh\themes`

## Habilitando o uso no JetBrains Rider Windows11

Salve o script em um diretorio que tenha permissão de acesso. Em seguida, acesse no Rider `Settings -> Tools -> Terminal`.
Agora, utilize a seguinte linha de comando ao Shell Path, alterando SEU_NOME_DE_USUARIO:

```shell
C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -NoLogo -NoExit C:\Users\SEU_NOME_DE_USUARIO\Documents\WindowsPowerShell\Microsoft.PowerShell_OhMyPosh.ps1
```

Abrindo o terminal no Rider
![TerminalRiderOhMyPosh][TerminalRiderOhMyPosh]

<!-- LINKS -->
[TerminalRiderOhMyPosh]: assets/oh-my-posh-custom-theme-jd.png