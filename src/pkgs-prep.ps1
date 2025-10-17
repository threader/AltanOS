$sysdrive =  $Env:SystemDrive
$altanosdir = "$sysdrive\AltanOS"
$altanosinstdir = "$sysdrive\AltanOS.inst"
# Put som paths and url's here eventually

if (-not (Test-Path -Path $altanosinstdir)) {
	mkdir "$altanosinstdir"
	mkdir "$altanosinstdir\bin"
	mkdir "$altanosinstdir\games"
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

	write-output "Winget not found. Grab and install. No progress bar as there is a bug in PowerShell making the download increadibly slow... ( https://github.com/PowerShell/PowerShell/issues/2138 )" 
	$ProgressPreference = 'SilentlyContinue'


function get_utils() {
	    if(-not ( Get-Machine-Architecture -eq "AMD64")) {
	    Write-Output "Assume x86"
		$niarchbit = $null
		 } else  {
		 $niarchbit = "-64"
		 }
 Invoke-WebRequest -uri "https://adwcleaner.malwarebytes.com/adwcleaner?channel=release" -OutFile "$altanosinstdir\bin\adwcleaner.exe"
 Start-Process -FilePath $altanosinstdir\bin\adwcleaner.exe

 Invoke-WebRequest -uri "https://tinywall.pados.hu/files/TinyWall-v3-Installer.msi" -OutFile "$altanosinstdir\TinyWall-v3-Installer.msi"

 Invoke-WebRequest -uri "http://www.itsamples.com/downloads/network-activity-indicator-setup$niarchbit.zip" -OutFile "$altanosinstdir\bin\network-indicator-setup$niarchbit.zip"

 Invoke-WebRequest -uri "https://privazer.com/en/PrivaZer.exe" -OutFile "$altanosinstdir\bin\PrivaZer.exe"

 cp $altanosdir\bin\PrivaZer.ini $altanosinstdir\bin\

 Expand-Archive -Force "$altanosinstdir\network-indicator-setup$niarchbit.zip" "$altanosinstdir\bin\network-indicator$niarchbit"
}
get_utils

# I think the "Are you shure" thingie is enough.
# cl remove all removable Windows packages on the system, for all users.. Are you sure you know what you are doing? Press any key to continue."
Write-Output "Removing non-essential packages and installing some bare minimums."

function disable_win_packages()  {
# Will need to check the version we are using, eventually, im sure i read get-apppackage is not available in newer ps
# so this will at least get the version:
# (Get-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\PowerShell\3\PowerShellEngine -Name 'PowerShellVersion').PowerShellVersion
# (Get-Host).Version and Get-Host should work.
# $altanosdir = "$sysdrive\AltanOS"
# PowerShell -command -wait $altanosdir\src\strip_windows.ps1
Get-Help >> $null
# Get-AppPackage -AllUsers | Remove-AppPackage -AllUsers
 # This will remove all user installed packages on the system.. 
 # this is for newer PowerShell versions.
 # Get-AppxPackage -AllUsers | Remove-AppPackage -AllUsers
 }
disable_win_packages


if (-not (Test-Path "$altanosinstdir\Microsoft.DesktopAppInstaller.msixbundle")) {

	function grab_winget_deps() {

	    if(-not ( Get-Machine-Architecture -eq "AMD64")) {
	    Write-Output "Assume x86"
#		Invoke-WebRequest -Uri "https://aka.ms/Microsoft.VCLibs.x86.14.00.Desktop.appx" -OutFile "$altanosinstdir\Microsoft.VCLibs.x86.14.00.Desktop.appx"
#		Invoke-WebRequest -Uri "https://github.com/microsoft/microsoft-ui-xaml/releases/download/v2.8.6/Microsoft.UI.Xaml.2.8.x86.appx" -OutFile "$altanosinstdir\Microsoft.UI.Xaml.2.8.x86.appx" 
#		Add-AppxPackage -Path "$altanosinstdir\Microsoft.UI.Xaml.2.8.x86.appx"
# ask
#		Invoke-WebRequest -Uri "https://github.com/TASEmulators/fceux/releases/download/interim-build/fceux-win64.zip" -OutFile "$altanosinstdir\fceux-win64.zip"
#		Expand-Archive -Force "$altanosinstdir\fceux-win32.zip" "$altanosinstdir\fceux-win32"

	      } else  {
	     Write-Output "Assume x64"
#		Invoke-WebRequest -Uri "https://aka.ms/Microsoft.VCLibs.x64.14.00.Desktop.appx" -OutFile "$altanosinstdir\Microsoft.VCLibs.x86.14.00.Desktop.appx"
#		Invoke-WebRequest -Uri "https://github.com/microsoft/microsoft-ui-xaml/releases/download/v2.8.6/Microsoft.UI.Xaml.2.8.x64.appx" -OutFile "$altanosinstdir\Microsoft.UI.Xaml.2.8.x64.appx"
#		Add-AppxPackage -Path "$altanosinstdir\Microsoft.UI.Xaml.2.8.x64.appx"
#
#		Invoke-WebRequest -Uri "https://github.com/TASEmulators/fceux/releases/download/interim-build/fceux-win64.zip" -OutFile "$altanosinstdir\fceux-win64.zip"
#		Expand-Archive -Force "$altanosinstdir\fceux-win64.zip" "$altanosinstdir\fceux-win64"
        }
	      
#Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force
#Register-PackageSource -provider NuGet -name nugetRepository -location https://www.nuget.org/api/v2
#Install-Package Microsoft.UI.Xaml --version 2.8.6 -Force

	Invoke-WebRequest -uri https://github.com/microsoft/winget-cli/releases/latest/download/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle -OutFile $altanosinstdir\Microsoft.DesktopAppInstaller.msixbundle
#	Invoke-WebRequest -uri https://github.com/microsoft/terminal/releases/download/v1.21.1772.0/Microsoft.WindowsTerminalPreview_1.21.1772.0_8wekyb3d8bbwe.msixbundle -OutFile $altanosdir\Microsoft.DesktopAppInstaller.msixbundle

# Invoke-WebRequest -uri https://github.com/marticliment/UniGetUI/releases/download/3.1.3/UniGetUI.Installer.exe  -OutFile $altanosinstdir\UniGetUI.Installer.exe
	}
	grab_winget_deps

# Enable progress bar
	$ProgressPreference = 'Continue'
	write-output "Installing winget, this might actually get stuck for some reason." 
	add-appxpackage -Path "$altanosinstdir\Microsoft.DesktopAppInstaller.msixbundle"
# cannot accept 'the source agreeement terms' from within ISE...
}

# create .xml of this eventually when it settles
#
# This should not really be needed
# winget install --disable-interactivity --accept-source-agreements --id abbodi1406.vcredist --source winget
#
function winget_pkgs() {
Write-Output "Install applications:"
winget install --disable-interactivity --accept-source-agreements --id Microsoft.AppInstaller --source winget # winget winget
winget install --disable-interactivity --accept-source-agreements --id MartiCliment.UniGetUI --source winget
# Must accept terms of agreement, doesnt work in ISE
winget install --accept-source-agreements --id 9N0DX20HK701 --source msstore
# winget install --exact --id SomePythonThings.WingetUIStore --source winget # WingetUI
winget install --disable-interactivity --accept-source-agreements --id Sandboxie.Plus --source winget
winget install --disable-interactivity --accept-source-agreements --id SomePythonThings.WingetUIStore --source winget

# Maybe drop AltanOS in $sysdrive. 
winget install --disable-interactivity --accept-source-agreements --id Git.Git --source winget

if (-not (Test-Path -Path $altanosdir)) {
# ask?
#  cp -r $PWD\..\AltanOS $altanosdir
Set-Location $altanosdir
git clone https://github.com/threader/AltanOS $altanosdir
# cd $altanosdir
git submodule update --init --recursive
} else {
Set-Location $altanosdir
git pull
git submodule update --recursive
 if (-not (Test-Path -Path $altanosdir)) {
   cp -r $PWD\..\AltanOS $altanosdir
 }
}




# winget install --disable-interactivity --accept-source-agreements --id Microsoft.Sysinternals.PsTools --source winget
# use psexec to scheduel task to run as SYSTEM. accept eual
# winget install --disable-interactivity --accept-source-agreements --id Microsoft.Sysinternals.ProcessMonitor --source winget
# psexec.exe -accepteula

winget install --disable-interactivity --accept-source-agreements --id Microsoft.Sysinternals.ProcessExplorer --source winget
winget install --disable-interactivity --accept-source-agreements --id Microsoft.Sysinternals.SysMon --source winget
winget install --disable-interactivity --accept-source-agreements --id WinDirStat.WinDirStat --source winget
# winget install --disable-interactivity --accept-source-agreements --id Microsoft.Powershell --source winget
winget install --disable-interactivity --accept-source-agreements --id eloston.ungoogled-chromium  --source winget
# winget install --disable-interactivity --accept-source-agreements --id Google.Chrome  --source winget
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
# https://learn.microsoft.com/en-us/windows/powertoys/
winget install --disable-interactivity --accept-source-agreements --id Microsoft.PowerToys --source winget

# dev tools - ask
winget install --accept-source-agreements --id Cygwin.Cygwin.Cygwin --source winget
# 
# coco install mingw -y --params "ALLUSERS=1"
winget install --disable-interactivity --accept-source-agreements --id Meld.Meld.Meld --source winget
winget install --disable-interactivity --accept-source-agreements --id KDE.KDiff3 --source winget
winget install --disable-interactivity --accept-source-agreements --id WinMgerge.WinMerge--source winget
winget install --disable-interactivity --accept-source-agreements --id Rizin.Cutter --source winget

# ask
winget install --disable-interactivity --accept-source-agreements --id VSCodium.VSCodium--source winget
# winget install --disable-interactivity --accept-source-agreements --id Microsoft.VisualStudioCode --source winget

# for ghidra
winget install --disable-interactivity --accept-source-agreements --id Oracle.JDK.17 --source winget
winget install --disable-interactivity --accept-source-agreements --id Python.Python.3.12 --source winget

# ask
# games 
# Heroes 3
winget install --disable-interactivity --accept-source-agreements --id vcmi.vcmi --source winget
# Xmoto - surely replaces minesweaper 
winget install --disable-interactivity --accept-source-agreements --id XMoto.XMoto --source winget
# Voodoo Glide Wrapper
# winget install --disable-interactivity --accept-source-agreements --id ZeusSoftware.nGlide --source winget
# DOS
winget install --disable-interactivity --accept-source-agreements --id DOSBox.DOSBox.DOSBoxStaging --source winget
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

 $ProgressPreference = 'SilentlyContinue'
 
	# get dev tools
	    if(-not ( Get-Machine-Architecture -eq "AMD64")) {
	    Write-Output "Assume x86"
	    		 Invoke-WebRequest -uri "httmps://github.com/radareorg/radare2/releases/download/5.9.4/radare2-5.9.4-w32.zip" -OutFile "$altanosinstdir\radare2-5.9.4-w64.zip"
			
			 Expand-Archive -Force "$altanosinstdir\adare2-5.9.4-w32.zip" "$altanosinstdir\bin\radare2-5.9.4-w32"
		 } else  {
		
			Invoke-WebRequest -Uri "https://malcat.fr/latest/malcat_win64_lite.zip" -OutFile "$altanosinstdir\malcat_win64_lite.zip"
			Invoke-WebRequest -Uri "https://github.com/radareorg/radare2/releases/download/5.9.4/radare2-5.9.4-w32.zip" -OutFile "$altanosinstdir\radare2-5.9.4-w64.zip"
			
			 Expand-Archive -Force "$altanosinstdir\malcat_win64_lite.zip" "$altanosinstdir\bin\malcat_win64_lite"
			 Expand-Archive -Force "$altanosinstdir\radare2-5.9.4-w64.zip" "$altanosinstdir\bin\radare2-5.9.4-w64"
		 }
 Invoke-WebRequest -uri "https://github.com/NationalSecurityAgency/ghidra/releases/download/Ghidra_11.1.2_build/ghidra_11.1.2_PUBLIC_20240709.zip" -OutFile "$altanosinstdir\ghidra_11.1.2_PUBLIC_20240709.zip"
 Expand-Archive -Force "$altanosinstdir\ghidra_11.1.2_PUBLIC_20240709.zip" "$altanosinstdir\bin\ghidra_11.1.2_PUBLIC_20240709"

#ask
## Games:
# Invoke-WebRequest -uri "https://archive.org/download/commandos_202403/Commandos.bin" --OutFile "$altanosinstdir/games/Commandos.bin" 

# Invoke-WebRequest -uri "https://archive.org/download/Commandos_Beyond_The_Call_Of_Duty_-_Windows95_EidosEng/CBTCOD.B6I" --OutFile "$altanosinstdir/games/"
# Invoke-WebRequest -uri "https://archive.org/download/setup_commandos_-_beyond_the_call_of_duty_1.1_23150/Commandos%20BCD%20Ultimate%20Fix.rar" --OutFile "$altanosinstdir/games/Commandos CD Ultimate Fix.rar"
# Invoke-WebRequest -uri "https://archive.org/download/setup_commandos_-_beyond_the_call_of_duty_1.1_23150/setup_commandos_-_beyond_the_call_of_duty_1.1_%2823150%29.exe" --OutFile "$altanosinstdir/games/setup_commandos_-_beyond_the_call_of_duty_1.1_2315029.exe" 

# Invoke-WebRequest -uri "https://github.com/bsnesemulator/SNES-ROMS/raw/main/Super%20Mario%20All-Stars%20(USA).zip" --OutFile "Super Mario All-Stars (USA).zip"
# Invoke-WebRequest -uri "https://archive.org/download/1986-super-mario-bros.-2-the-lost-levels-japan/1986 Super Mario Bros.2 B The Lost Levels Japan.nes" --OutFile "$altanosinstdir/games/1986 Super Mario Bros.2 B The Lost Levels Japan.nes"

# Invoke-WebRequest -uri "https://archive.org/download/carmageddon2/carmageddon2.iso" --OutFile "$altanosinstdir/games/carmageddon2.iso"

# Invoke-WebRequest -uri "https://archive.org/download/GTA1MAX/GTA1-MAX.ZIP" --OutFile "$altanosinstdir\GTA1-MAX.ZIP"
# Expand-Archive -Force "$altanosinstdir\GTA1-MAX.ZIP" "$altanosinstdir/GTA1-MAX"

# Invoke-WebRequest -uri "https://archive.org/download/gta2_20200403/GTA2.exe" --OutFile "$altanosinstdir\GTA2.exe"
# Invoke-WebRequest -uri "https://archive.org/download/BloodIITheChosenUSA/Blood%20II%20-%20The%20Chosen%20%28USA%29.zip" --OutFile "$altanosinstdir\Blood II - The Chosen (USA).zip"

# note https://github.com/elishacloud/dxwrapper
# Invoke-WebRequest -uri "https://github.com/elishacloud/dxwrapper/releases/download/v1.1.6900.22/dxwrapper.zip" --OutFile "$altanosinstdir\dxwrapper.zip"
# Expand-Archive -Force "$altanosinstdir\dxwrapper.zip" "$altanosinstdir\dxwrapper" 
# https://github.com/elishacloud/dxwrapper/wiki/Blood-II-The-Chosen
# Invoke-WebRequest -uri "https://github.com/elishacloud/wiki-attachments/raw/master/dxwrapper/Games/Blood%20II%20The%20Chosen/blood2-fix.zip" --OutFile "$altanosinstdir\blood2-fix-git\"
# Expand-Archive -Force "$altanosinstdir\Blood II - The Chosen (USA).zip" "$altanosinstdir\Blood II - The Chosen"
 
# Invoke-WebRequest -uri "https://sjc4.dl.dbolical.com/dl/2015/09/14/B2P_224b.zip?st=DW3S6XZDygKXPvhqeHTRnA==&e=1725685936" --OutFile "$altonsinstdir\B2P_224b.zip"
#https://fmt2.dl.dbolical.com/dl/2015/09/14/B2P_224b.zip?st=w43H86DLtKH_0b4Zi7wYtQ==&e=1725687286
#https://www.moddb.com/downloads/start/90285/all?referer=https%3A%2F%2Fwww.pcgamingwiki.com%2F
# Invoke-WebRequest -uri "https://fmt4.dl.dbolical.com/dl/2015/07/21/B2P_021.exe?st=Z0KzuJDE6RQ01a73MoV6UA==&e=1725686044" --OutFile "$altonsinstdir\B2P_021.exe"
#https://fmt4.dl.dbolical.com/dl/2015/07/21/B2P_021.exe?st=3rsOI-cYPaiepZke9nUm5A==&e=1725687320
#https://www.moddb.com/downloads/start/90285/all?referer=https%3A%2F%2Fwww.pcgamingwiki.com%2F

# Expand-Archive -Force "$altonsinstdir\B2P_224b.zip"  "$altonsinstdir\B2P_224b"

# 7zip blood 2 exe?
#
# Wings Of Glory, was quite unstable as i remember, might be fun to try for 5 whole minutes.
# https://archive.org/download/wingsofglory-pc-redump/WINGSOFGLORY-PC-REDUMP/ (EU/US)
# https://archive.org/download/GLORY_EXE/GLORY.EXE
# https://archive.org/download/wings-1-6/WINGS1_6.iso
$ProgressPreference = 'Continue'

# Display My Computer on desktop
#(New-Object -ComObject shell.application).toggleDesktop() # Thsi simply doesnt work and temporarily removes the search bar from tray....


# This will need to reboot....
#Write-output "Installing and running PSWindowsUpdate. - temp. Workaround: script continuing while previous operations not done."

#Install-Module -Force PSWindowsUpdate
#Import-Module PSWindowsUpdate
# This will grab everything, optional included , Reboot's might be needed, this needs to run first boot again..
#Get-WindowsUpdate -AcceptAll -Install


Read-Host -Prompt "Press any key to continue"
