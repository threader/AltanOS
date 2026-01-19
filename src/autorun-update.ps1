Write-output "Running 'winget update' and Windows Update."
$ProgressPreference = 'SilentlyContinue'
winget upgrade --accept-source-agreements --disable-interactivity --include-unknown -r

# Set-ExecutionPolicy -ExecutionPolicy Bypass

# Do this incase there is an update to PSWindowsUpdate
 Install-Module -Force PSWindowsUpdate 
 Import-Module PSWindowsUpdate
 
 # Install-WindowsUpdates
Get-WindowsUpdate -AcceptAll -Install

Set-ExecutionPolicy -ExecutionPolicy Restricted

Read-Host -Prompt "Press any key to continue".
