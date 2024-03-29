# Windows Terminal little tweaks

Pequenas modificações para deixar o Windows Terminal mais elegante.

- Exibe apenas o diretório atual no Shell, deixando mais espaço para comandos.
- Altera as cores de texto padrão.
- Redireciona a abertura do terminal para o diretório **C:\DEV**, caso o mesmo seja aberto em pastas internas do Sistema Operacional.

Antes:

![Windows Terminal tweak][before]

Depois:

![Windows Terminal padrão][after]

## Requisitos

- Windows PowerShell
- Windows Terminal

1. Baixe os scripts e o terminal.ico na mesma pasta. Ex: C:\script
2. Execute o Create_a_profile_to_settings_json.ps1 para criar um novo perfil do terminal.
3. Execute o Create_new_PS_profile.ps1 para habilitar as configurações no Windows Terminal.

Obs: Abaixo estão os diretórios com os backups, caso necessário restaurar.

```shell
#Profile - settings.json
%LOCALAPPDATA%\\Packages\\Microsoft.WindowsTerminal_8wekyb3d8bbwe\\LocalState\

#Windows Terminal - Microsoft.PowerShell_profile.ps1
%USERPROFILE%\\Documents\\WindowsPowerShell
```

Fique à vontade para fazer modificações e melhorias no script.

Bons estudos e bons códigos! :sunglasses:

<!-- LINKS -->

    [after]: /assets/img/after.png "Windows Terminal modificado"

[before]: /assets/img/before.png "Windows Terminal padrão"
