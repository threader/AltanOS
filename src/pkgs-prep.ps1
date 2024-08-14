$sysdrive =  $Env:SystemDrive
$altanosdir = "$sysdrive\AltanOS"
$altanosinstdir = "$sysdrive\AltanOS.inst"

if (-not (Test-Path -Path $altanosinstdir)) {
	mkdir -p $altanosinstdir\bin
}

# $DesktopPath = [Environment]::GetFolderPath("Desktop")
# Get-Location | Foreach-Object { $_.Path }

function Get-Machine-Architecture() {
  #  Say-Invocation $MyInvocation

    # On PS x86, PROCESSOR_ARCHITECTURE reports x86 even on x64 systems.
    # To get the correct architecture, we need to use PROCESSOR_ARCHITEW6432.
    # PS x64 doesn't define this, so we fall back to PROCESSOR_ARCHITECTURE.
    # Possible values: amd64, x64, x86, arm64, arm
    if( $ENV:PROCESSOR_ARCHITEW6432 -ne $null ) {
        return $ENV:PROCESSOR_ARCHITEW6432
    }

    try {        
        if( ((Get-CimInstance -ClassName CIM_OperatingSystem).OSArchitecture) -like "ARM*") {
            if( [Environment]::Is64BitOperatingSystem )
            {
                return "arm64"
            }  
            return "arm"
        }
    }
    catch {
        # Machine doesn't support Get-CimInstance
    }

    return $ENV:PROCESSOR_ARCHITECTURE
}

# I think the "Are you shure" thingie is enough.
# cl remove all removable Windows packages on the system, for all users.. Are you sure you know what you are doing? Press any key to continue."
Write-Output "Removing non-essential packages and installing some bare minimums."

function disable_win_packages()  {
 Get-AppPackage -AllUsers | Remove-AppPackage -AllUsers
 # This will remove all user installed packages on the system.. 
 Get-AppxPackage -AllUsers | Remove-AppPackage -AllUsers
 }
disable_win_packages

function enable_win_packages() {
 Get-AppxPackage -allusers Microsoft.VCLibs* | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
 Get-AppxPackage -allusers Microsoft.NET.CoreRuntime* | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
 Get-AppxPackage -allusers Microsoft.NET.Native* | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
 Get-AppxPackage -allusers Microsoft.NET.Native.Runtime* | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
 Get-AppxPackage -allusers Microsoft.NET.Native.Framework.1.7* | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
 Get-AppxPackage -allusers Microsoft.NET.Native.Framework.2.2* | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
 Get-AppxPackage -allusers Microsoft.UI.Xaml* | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
 Get-AppxPackage -allusers Microsoft.PackageManagement.NuGetProvider* | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
 Get-AppxPackage -allusers Microsoft.UI.Xaml.2.7* | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
 Get-AppxPackage -allusers Microsoft.UI.Xaml.2.8* | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
 Get-AppxPackage -allusers Microsoft.WindowsStore* | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
 Get-AppxPackage -allusers Microsoft.StorePurchaseApp* | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
## Get-AppxPackage -allusers Microsoft.MicrosoftOfficeHub* | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
 Get-AppxPackage -allusers Microsoft.WindowsCalculator* | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
 Get-AppxPackage -allusers Microsoft.MSPaint* | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
 Get-AppxPackage -allusers Microsoft.MicrosoftSolitaireCollection* | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
}
enable_win_packages

if (-not (Test-Path "$altanosinstdir\Microsoft.DesktopAppInstaller.msixbundle")) {
	write-output "Winget not found. Grab and install. No progress bar as there is a bug in PowerShell making the download increadibly slow... ( https://github.com/PowerShell/PowerShell/issues/2138 )" 
	$ProgressPreference = 'SilentlyContinue'

	function grab_winget_deps() {

	    if(-not ( Get-Machine-Architecture -eq "AMD64")) {
	    Write-Output "Assume x86"
		Invoke-WebRequest -Uri "https://aka.ms/Microsoft.VCLibs.x86.14.00.Desktop.appx" -OutFile "$altanosinstdir\Microsoft.VCLibs.x86.14.00.Desktop.appx"
		Invoke-WebRequest -Uri "https://github.com/microsoft/microsoft-ui-xaml/releases/download/v2.8.6/Microsoft.UI.Xaml.2.8.x86.appx" -OutFile "$altanosinstdir\Microsoft.UI.Xaml.2.8.x86.appx" 
		Add-AppxPackage -Path "$altanosinstdir\Microsoft.UI.Xaml.2.8.x86.appx"
	      } else  {
	     Write-Output "Assume x64"
		Invoke-WebRequest -Uri "https://aka.ms/Microsoft.VCLibs.x64.14.00.Desktop.appx" -OutFile "$altanosinstdir\Microsoft.VCLibs.x86.14.00.Desktop.appx"
		Invoke-WebRequest -Uri "https://github.com/microsoft/microsoft-ui-xaml/releases/download/v2.8.6/Microsoft.UI.Xaml.2.8.x64.appx" -OutFile "$altanosinstdir\Microsoft.UI.Xaml.2.8.x64.appx"
		Add-AppxPackage -Path "$altanosinstdir\Microsoft.UI.Xaml.2.8.x64.appx"
	      }
	      
#Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force
#Register-PackageSource -provider NuGet -name nugetRepository -location https://www.nuget.org/api/v2
#Install-Package Microsoft.UI.Xaml --version 2.8.6 -Force

	Invoke-WebRequest -uri https://github.com/microsoft/winget-cli/releases/download/v1.8.1911/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle -OutFile $altanosinstdir\Microsoft.DesktopAppInstaller.msixbundle
	Invoke-WebRequest -uri https://github.com/microsoft/terminal/releases/download/v1.21.1772.0/Microsoft.WindowsTerminalPreview_1.21.1772.0_8wekyb3d8bbwe.msixbundle -OutFile $altanosdir\Microsoft.DesktopAppInstaller.msixbundle
	}
	grab_winget_deps

# Enable progress bar
	$ProgressPreference = 'Continue'
	write-output "Installing winget, this might actually get stuck for some reason." 
	start-process "powershell -Wait "add-appxpackage -Path "$altanosinstdir\Microsoft.DesktopAppInstaller.msixbundle" " "
	add-appxpackage -Path "$altanosinstdir\Microsoft.DesktopAppInstaller.msixbundle"
}

# create .xml of this eventually when it settles
#
# This should not really be needed
# winget install --disable-interactivity --accept-source-agreements --id abbodi1406.vcredist --source winget
#
function winget_pkgs() {
Write-Output "Install applications:"
winget install --disable-interactivity --accept-source-agreements --id Sandboxie.Plus --source winget
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

# dev tools

winget install --disable-interactivity --accept-source-agreements --id Cygwin.Cygwin.Cygwin --source winget
coco install -y mingw
winget install --disable-interactivity --accept-source-agreements --id Meld.Meld.Meld --soure winget
winget install --disable-interactivity --accept-source-agreements --id KDE.KDiff3 --source winget
winget install --disable-interactivity --accept-source-agreements --id WinMgerge.WinMerge--source winget
winget install --disable-interactivity --accept-source-agreements --id Rizin.Cutter --source winget
# ask
winget install --disable-interactivity --accept-source-agreements --id VSCodium.VSCodium--source winget
winget install --disable-interactivity --accept-source-agreements --id Microsoft.VisualStudioCode --source winget

}
winget_pkgs

function winget_rm_pkgs() {
Write-Output "Remove applications:"
winget remove --id Microsoft.Edge* --accept-source-agreements --disable-interactivity
# winget remove --id Microsoft Edge Update* --accept-source-agreements --disable-interactivity # uuh, is this needed for Microsoft.EdgeWebView2Runtime that one probably needs?
winget remove --id Microsoft.Office.OneNote* --accept-source-agreements --disable-interactivity
winget remove --id Microsoft.ScreenSketch* --accept-source-agreements --disable-interactivity
winget remove --id Microsoft.SkypeApp* --accept-source-agreements --disable-interactivity
# winget remove --id Microsoft.OneDrive --accept-source-agreements --disable-interactivity
}
winget_rm_pkgs

Write-Output "Updating all known exsisting applications."
winget upgrade --accept-source-agreements --disable-interactivity --include-unknown -r

# This will reboot....
#Write-output "Installing and running PSWindowsUpdate. - temp. Workaround: script continuing while previous operations not done."
# Set-ExecutionPolicy -ExecutionPolicy Bypass
#	start-process "powershell -Wait "Install-Module -Force PSWindowsUpdate" "
#	start-process "powershell -Wait "Import-Module PSWindowsUpdate" "
#	start-process "powershell -Wait "Get-WindowsUpdate -AcceptAll -Install""
# Install-WindowsUpdate
# Set-ExecutionPolicy -ExecutionPolicy Restricted

Read-Host -Prompt "Press any key to continue"
