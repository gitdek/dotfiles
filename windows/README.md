
# Windows

* Open PowerShell as an administrator
* Install [Chocolately](https://chocolatey.org/)
* Install [Boxstarter](https://boxstarter.org/)
* Run the `boxstarter.ps1` script: `Install-BoxstarterPackage -PackageName <url> -DisableReboots`

`Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/gitdek/dotfiles/master/windows/boxstarter.ps1'));`
