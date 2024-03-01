Write-output "Running a 'winget' update for installed programs and Windows Update."

winget upgrade --accept-source-agreements --disable-interactivity --include-unknown -r

# Set-ExecutionPolicy -ExecutionPolicy Bypass

# Do this incase there is an update to PSWindowsUpdate
 Install-Module -Force PSWindowsUpdate 
 Import-Module PSWindowsUpdate
 
Get-WindowsUpdate -AcceptAll -Install
# Install-WindowsUpdate
# Set-ExecutionPolicy -ExecutionPolicy Restricted
pause
