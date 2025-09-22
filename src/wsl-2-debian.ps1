# WSL
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux -NoRestart 
wsl --set-default-version 2
wsl --install -d Debian
# wsl --set-version Debian 2
