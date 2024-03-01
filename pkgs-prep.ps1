$DesktopPath = [Environment]::GetFolderPath("Desktop")
$usedir = $DesktopPath\AltanOS.inst\
if (-not (Test-Path -Path $usedir))
	mkdir $usedir
}

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


# Invoke-WebRequest -uri https://globalcdn.nuget.org/packages/microsoft.ui.xaml.2.8.2.nupkg -OutFile $DesktopPath\AltanOS.inst\microsoft.ui.xaml.2.8.2.nupkg
if (-not (Test-Path "$DesktopPath\AltanOS.inst\Microsoft.DesktopAppInstaller.msixbundle")) {
	write-output "Winget not found. Grab and install" 
	Invoke-WebRequest -uri https://github.com/microsoft/winget-cli/releases/download/v1.4.10173/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle -OutFile $DesktopPath\AltanOS.inst\Microsoft.DesktopAppInstaller.msixbundle
	# Install-Package https://globalcdn.nuget.org/packages/microsoft.ui.xaml.2.8.2.nupkg
}
add-appxpackage -Path "$DesktopPath\AltanOS.inst\Microsoft.DesktopAppInstaller.msixbundle"

Write-Output "Installing a set of applications and updating all recognized by 'winget'"
# todo: change source to MStore find vcredist
# winget install --disable-interactivity --accept-source-agreements --id vcredist
winget install --disable-interactivity --accept-source-agreements --id SomePythonThings.WingetUIStore --source winget
winget install --disable-interactivity --accept-source-agreements --id Git.Git --source winget
winget install --disable-interactivity --accept-source-agreements --id Microsoft.Sysinternals.ProcessMonitor --source winget
winget install --disable-interactivity --accept-source-agreements --id Microsoft.Sysinternals.ProcessExplorer --source winget
#winget install --disable-interactivity --accept-source-agreements --id Microsoft.Powershell --source winget
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
# winget remove --id Microsoft.Edge --accept-source-agreements --disable-interactivity
# winget remove --id Microsoft.OneDrive --accept-source-agreements --disable-interactivity
winget upgrade --accept-source-agreements --disable-interactivity --include-unknown -r

Write-output "Installing and running PSWindowsUpdate."
# Set-ExecutionPolicy -ExecutionPolicy Bypass
Install-Module -Force PSWindowsUpdate
Import-Module PSWindowsUpdate
Get-WindowsUpdate -AcceptAll -Install
# Install-WindowsUpdate
# Set-ExecutionPolicy -ExecutionPolicy Restricted

# Add to startup
# New-ItemProperty -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Run" -Name "Update Windows and Applications" -Value "%HOMEDRIVE%%HOMEPATH%\Desktop\AltanOS\autorun-update.cmd"  -PropertyType "String"

# Scheduled Task new task 
$trigger0 = New-ScheduledTaskTrigger -Weekly -At 18pm -DaysOfWeek Tuesday 
$trigger1 = New-ScheduledTaskTrigger -AtLogon
$task_name = "Autorun update"

function shed_task() {	
$action = New-ScheduledTaskAction -Execute "%HOMEDRIVE%%HOMEPATH%\Desktop\AltanOS\autorun-update.cmd"
$principal = "System\Administrator"
$settings = New-ScheduledTaskSettingsSet -WakeToRun
$task = New-ScheduledTask -Action $action -Trigger $trigger0 -Trigger $trigger1 -Settings $settings
Register-ScheduledTask $task_name -InputObject $task
}
shed_task


Write-output "Pause here to review"
pause
