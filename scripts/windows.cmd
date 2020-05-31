echo "Installing chocolatey"
@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"

choco install nodejs.install -y
choco install git -y -params '"/GitAndUnixToolsOnPath"'
choco install javaruntime -y
echo "Java runtime installed. A restart is likely required"
choco install vscode -y
choco install GoogleChrome -y
choco install winmerge -y

refreshenv
git config --global user.name "Anthony Ciccarello"
git config --global user.email "aciccarello@users.noreply.github.com"
