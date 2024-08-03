# $DesktopPath = [Environment]::GetFolderPath("Desktop")
string sysdrive = Environment.ExpandEnvironmentVariables("%HOMEDRIVE%");
string altanosdir = $sysdrive\AltanOS
string altanosinstdir = $sysdrive\AltanOS.inst

#$usedir = $altanosinstdir
#if (-not (Test-Path -Path $usedir))
#	mkdir $usedir
#}

Write-Output "Removing non-essential packages and installing some bare minimums"
 Get-AppPackage | Remove-AppPackage
 Get-AppxPackage -allusers Microsoft.VCLibs* | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
 Get-AppxPackage -allusers Microsoft.NET.CoreRuntime* | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
 Get-AppxPackage -allusers Microsoft.NET.Native* | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
 Get-AppxPackage -allusers Microsoft.NET.Native.Runtime* | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
 Get-AppxPackage -allusers Microsoft.NET.Native.Framework.1.7* | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
 Get-AppxPackage -allusers Microsoft.NET.Native.Framework.2.2* | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
 Get-AppxPackage -allusers Microsoft.UI.Xaml* | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
 Get-AppxPackage -allusers Microsoft.PackageManagement.NuGetProvider* | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
 Get-AppxPackage -allusers Microsoft.UI.Xaml.2.7* | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
 Get-AppxPackage -allusers Microsoft.WindowsStore* | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
 Get-AppxPackage -allusers Microsoft.StorePurchaseApp* | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
## Get-AppxPackage -allusers Microsoft.MicrosoftOfficeHub* | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
## Get-AppxPackage -allusers Microsoft.Windows.Search* | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
 Get-AppxPackage -allusers Microsoft.WindowsCalculator* | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
 Get-AppxPackage -allusers Microsoft.MSPaint* | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
 Get-AppxPackage -allusers Microsoft.MicrosoftSolitaireCollection* | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}

if (-not (Test-Path "$altanosinstdir\Microsoft.DesktopAppInstaller.msixbundle")) {
	write-output "Winget not found. Grab and install" 
	Invoke-WebRequest -uri https://github.com/microsoft/winget-cli/releases/download/v1.8.1911/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle -OutFile $altanosinstdir\Microsoft.DesktopAppInstaller.msixbundle
}
add-appxpackage -Path "$altanosinstdir\Microsoft.DesktopAppInstaller.msixbundle"

# create .xml of this eventually when it settles
Write-Output "Install applications:"
winget install --disable-interactivity --accept-source-agreements --id abbodi1406.vcredist --source winget
winget remove  --disable-interactivity --accept-source-agreements --id Sandboxie.Plus --source winget
winget install --disable-interactivity --accept-source-agreements --id SomePythonThings.WingetUIStore --source winget
winget install --disable-interactivity --accept-source-agreements --id Git.Git --source winget
winget install --disable-interactivity --accept-source-agreements --id Microsoft.Sysinternals.ProcessMonitor --source winget
winget install --disable-interactivity --accept-source-agreements --id Microsoft.Sysinternals.ProcessExplorer --source winget
#winget install --disable-interactivity --accept-source-agreements --id Microsoft.Powershell --source winget
winget install --disable-interactivity --accept-source-agreements --id Google.Chrome  --source winget
winget install --disable-interactivity --accept-source-agreements --id Mozilla.Firefox --source winget
winget install --disable-interactivity --accept-source-agreements --id 7zip.7zip --source winget
winget install --disable-interactivity --accept-source-agreements --id VideoLAN.VLC --source winget
winget install --disable-interactivity --accept-source-agreements --id GIMP.GIMP --source winget
winget install --disable-interactivity --accept-source-agreements --id TheDocumentFoundation.LibreOffice --source winget
winget install --disable-interactivity --accept-source-agreements --id Piriform.Recuva --source winget
winget install --disable-interactivity --accept-source-agreements --id Piriform.Defraggler --source winget
winget install --disable-interactivity --accept-source-agreements --id Notepad++.Notepad++ --source winget
winget install --disable-interactivity --accept-source-agreements --id Nlitesoft.NTLite --source winget
winget install --disable-interactivity --accept-source-agreements --id Malwarebytes.Malwarebytes --source winget
winget install --disable-interactivity --accept-source-agreements --id SaferNetworking.SpybotAntiBeacon --source winget
winget install --exact --id SomePythonThings.WingetUIStore --source winget

Write-Output "Remove applications:"
winget remove --id Microsoft.Edge --accept-source-agreements --disable-interactivity
# winget remove --id Microsoft Edge Update* --accept-source-agreements --disable-interactivity # uuh, is this needed for Microsoft.EdgeWebView2Runtime that one probably needs?
winget remove --id Microsoft.Office.OneNote* --accept-source-agreements --disable-interactivity
winget remove --id Microsoft.ScreenSketch* --accept-source-agreements --disable-interactivity
winget remove --id Microsoft.SkypeApp* --accept-source-agreements --disable-interactivity
# winget remove --id Microsoft.OneDrive --accept-source-agreements --disable-interactivity

Write-Output "Updating all known exsisting applications."
winget upgrade --accept-source-agreements --disable-interactivity --include-unknown -r

Write-output "Installing and running PSWindowsUpdate."
# Set-ExecutionPolicy -ExecutionPolicy Bypass
Install-Module -Force PSWindowsUpdate
Import-Module PSWindowsUpdate
Get-WindowsUpdate -AcceptAll -Install
# Install-WindowsUpdate
# Set-ExecutionPolicy -ExecutionPolicy Restricted

# Scheduled Task new task 
$trigger0 = New-ScheduledTaskTrigger -Weekly -At 18pm -DaysOfWeek Tuesday 
$trigger1 = New-ScheduledTaskTrigger -AtLogon
$task_name = "Autorun update"

function shed_task() {	
$action = New-ScheduledTaskAction -Execute "PowerShell" -Argument "-NoProfile -ExecutionPolicy Bypass -File '$altanosdir\autorun-update.cmd"
$principal = "System\Administrator"
$settings = New-ScheduledTaskSettingsSet -WakeToRun
$task = New-ScheduledTask -Action $action -Trigger $trigger0 -Trigger $trigger1 -Settings $settings
Register-ScheduledTask $task_name -TaskPath 'AltanOS' -InputObject $task
}
shed_task

# i had a script to do this. Steal this example i guess 
#$taskTriggers = @(
# Any better suggestions for -At? - Ask?
#New-ScheduledTaskTrigger -Weekly -DaysOfWeek Thuesday -At 17pm 
#New-ScheduledTaskTrigger -AtLogon
#)
# The following will probably not work and include cd% in the path instead of the actual path
#$taskAction = New-ScheduledTaskAction -Execute "PowerShell" -Argument "-NoProfile -ExecutionPolicy Bypass -File '$altanosdir\autorun-update.cmd' -Output 'HTML'" -WorkingDirectory '$altanosdir'
# Register-ScheduledTask 'Update Windows and Applications' -TaskPath 'AltanOS' -Action $taskAction -Trigger $taskTrigger
# Get-ScheduledTask -TaskPath \AltanOS\

# Aaha, so thats where i put that
# Add to startup
# New-ItemProperty -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Run" -Name "Update Windows and Applications" -Value "$altanosdir\autorun-update.cmd"  -PropertyType "String"



Write-output "Pause here to review"
pause
