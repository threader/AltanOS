Write-output "Running Win Update and winget update all, warnings may ensue"

winget upgrade --accept-source-agreements --disable-interactivity --include-unknown -r

# Set-ExecutionPolicy -ExecutionPolicy Bypass
# Install-Module PSWindowsUpdate
# Import-Module PSWindowsUpdate
Get-WindowsUpdate -AcceptAll -Install
# Install-WindowsUpdate
# Set-ExecutionPolicy -ExecutionPolicy Restricted
pause
