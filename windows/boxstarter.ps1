#  ▓▓▓▓▓▓▓▓▓▓
#  ▓ author ▓ dek <https://git.io/gitdek>
#  ▓ repo   ▓ https://github.com/gitdek/dotfiles
#  ▓ mirror ▓ https://git.io/.dekdotfiles
#  ▓▓▓▓▓▓▓▓▓▓


# Run from a PowerShell prompt with administrative privileges:
# Install-BoxstarterPackage -PackageName <url> -DisableReboots

Set-TimeZone -Name "Eastern Standard Time" -Verbose
choco install ChocolateyGUI -y
choco install autohotkey -y
choco install vlc -y
choco install steam -y
choco install googlechrome -y
choco install firefox -y
choco install git -y
choco install wsl -y
choco install vscode -y
choco install vscode-powershell -y
Disable-BingSearch
Set-TaskbarOptions -Dock Bottom
Set-ExplorerOptions -showHiddenFilesFoldersDrives -showFileExtensions
Enable-PSRemoting -Force
Update-Help
Install-WindowsUpdate
