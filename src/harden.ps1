$sysdrive =  $Env:SystemDrive
$altanosinstdir = "$sysdrive\AltanOS.inst"
# Put som paths and url's here eventually

if (-not (Test-Path -Path $altanosinstdir)) {
	mkdir "$altanosinstdir"
	mkdir "$altanosinstdir\bin"
	mkdir "$altanosinstdir\games"
}
# Taken from (old) Atlas
New-Object -comObject WScript.Shell; $Shortcut = $WshShell.CreateShortcut("""$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Process Explorer.lnk"""); $Shortcut.TargetPath = """$Env:Username/AppData/Local/Microsoft/WinGet/Packages/Microsoft.Sysinternals.ProcessExplorer_Microsoft.Winget.Source_8wekyb3d8bbwe/procexp.exe"""; $Shortcut.Save()
New-Object -comObject WScript.Shell; $Shortcut = $WshShell.CreateShortcut("""$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Process Monitor.lnk"""); $Shortcut.TargetPath = """$Env:Username/AppData/Local/Microsoft/WinGet/Packages/Microsoft.Sysinternals.ProcessMonitor_Microsoft.Winget.Source_8wekyb3d8bbwe/procmon.exe"""; $Shortcut.Save()

# huge thanks to Matthew Graeber @ SpecterOps - https://github.com/palantir/exploitguard
function harden_processes() {
Set-ProcessMitigation -Name outlook.exe -Enable DEP,BottomUp,ForceRelocateImages,CFG,AuditRemoteImageLoads,AuditLowLabelImageLoads,EnableExportAddressFilter,EnableExportAddressFilterPlus,EnableImportAddressFilter,EnableRopStackPivot,EnableRopCallerCheck,EnableRopSimExec,SEHOP,TerminateOnError,AuditChildProcess
Set-ProcessMitigation -Name winword.exe -Enable DEP,BottomUp,ForceRelocateImages,CFG,AuditRemoteImageLoads,AuditLowLabelImageLoads,EnableExportAddressFilter,EnableExportAddressFilterPlus,EnableImportAddressFilter,EnableRopStackPivot,EnableRopCallerCheck,EnableRopSimExec,SEHOP,TerminateOnError,AuditChildProcess
Set-ProcessMitigation -Name excel.exe -Enable DEP,BottomUp,ForceRelocateImages,CFG,AuditRemoteImageLoads,AuditLowLabelImageLoads,EnableExportAddressFilter,EnableExportAddressFilterPlus,EnableImportAddressFilter,EnableRopStackPivot,EnableRopCallerCheck,EnableRopSimExec,SEHOP,TerminateOnError,AuditChildProcess
Set-ProcessMitigation -Name powerpnt.exe -Enable DEP,BottomUp,ForceRelocateImages,CFG,AuditRemoteImageLoads,AuditLowLabelImageLoads,EnableExportAddressFilter,EnableExportAddressFilterPlus,EnableImportAddressFilter,EnableRopStackPivot,EnableRopCallerCheck,EnableRopSimExec,SEHOP,TerminateOnError,AuditChildProcess
Set-ProcessMitigation -Name visio.exe -Enable DEP,BottomUp,ForceRelocateImages,CFG,AuditRemoteImageLoads,AuditLowLabelImageLoads,EnableExportAddressFilter,EnableExportAddressFilterPlus,EnableImportAddressFilter,EnableRopStackPivot,EnableRopCallerCheck,EnableRopSimExec,SEHOP,TerminateOnError,AuditChildProcess
Set-ProcessMitigation -Name pptview.exe -Enable DEP,BottomUp,ForceRelocateImages,CFG,AuditRemoteImageLoads,AuditLowLabelImageLoads,EnableExportAddressFilter,EnableExportAddressFilterPlus,EnableImportAddressFilter,EnableRopStackPivot,EnableRopCallerCheck,EnableRopSimExec,SEHOP,TerminateOnError,AuditChildProcess
Set-ProcessMitigation -Name groove.exe -Enable DEP,BottomUp,ForceRelocateImages,CFG,BlockRemoteImageLoads,AuditLowLabelImageLoads,EnableExportAddressFilter,EnableExportAddressFilterPlus,EnableImportAddressFilter,EnableRopStackPivot,EnableRopCallerCheck,EnableRopSimExec,SEHOP,TerminateOnError,DisallowChildProcessCreation
Set-ProcessMitigation -Name onedrive.exe -Enable DEP,BottomUp,CFG,AuditRemoteImageLoads,AuditLowLabelImageLoads,EnableExportAddressFilter,EnableExportAddressFilterPlus,EnableImportAddressFilter,EnableRopStackPivot,EnableRopCallerCheck,EnableRopSimExec,SEHOP,TerminateOnError,AuditChildProcess
Set-ProcessMitigation -Name iexplore.exe -Enable DEP,BottomUp,ForceRelocateImages,CFG,AuditRemoteImageLoads,AuditLowLabelImageLoads,EnableExportAddressFilter,EnableExportAddressFilterPlus,EnableImportAddressFilter,EnableRopStackPivot,EnableRopCallerCheck,EnableRopSimExec,SEHOP,TerminateOnError,AuditChildProcess
Set-ProcessMitigation -Name microsoftedge.exe -Enable DEP,BottomUp,ForceRelocateImages,CFG,AuditRemoteImageLoads,AuditLowLabelImageLoads,EnableExportAddressFilter,EnableExportAddressFilterPlus,EnableImportAddressFilter,EnableRopStackPivot,EnableRopCallerCheck,EnableRopSimExec,SEHOP,TerminateOnError,AuditChildProcess
Set-ProcessMitigation -Name chrome.exe -Enable DEP,BottomUp,CFG,AuditRemoteImageLoads,AuditLowLabelImageLoads,SEHOP,AuditChildProcess
Set-ProcessMitigation -Name AcroRd32.exe -Enable DEP,BottomUp,ForceRelocateImages,CFG,AuditRemoteImageLoads,AuditLowLabelImageLoads,EnableExportAddressFilter,EnableExportAddressFilterPlus,EnableImportAddressFilter,EnableRopStackPivot,EnableRopCallerCheck,EnableRopSimExec,SEHOP,TerminateOnError,AuditChildProcess
Set-ProcessMitigation -Name acrobat.exe -Enable DEP,BottomUp,ForceRelocateImages,CFG,AuditRemoteImageLoads,AuditLowLabelImageLoads,EnableExportAddressFilter,EnableExportAddressFilterPlus,EnableImportAddressFilter,EnableRopStackPivot,EnableRopCallerCheck,EnableRopSimExec,SEHOP,TerminateOnError,AuditChildProcess
Set-ProcessMitigation -Name firefox.exe -Enable DEP,BottomUp,ForceRelocateImages,CFG,AuditRemoteImageLoads,AuditLowLabelImageLoads,EnableExportAddressFilter,EnableExportAddressFilterPlus,EnableImportAddressFilter,EnableRopStackPivot,EnableRopCallerCheck,EnableRopSimExec,SEHOP,TerminateOnError,AuditChildProcess
Set-ProcessMitigation -Name slack.exe -Enable DEP,BottomUp,CFG,AuditRemoteImageLoads,AuditLowLabelImageLoads,SEHOP,AuditChildProcess
Set-ProcessMitigation -Name quip.exe -Enable DEP,BottomUp,CFG,AuditRemoteImageLoads,AuditLowLabelImageLoads,SEHOP,AuditChildProcess
Set-ProcessMitigation -Name zoom.exe -Enable DEP,BottomUp,CFG,AuditRemoteImageLoads,AuditLowLabelImageLoads,SEHOP,AuditChildProcess
Set-ProcessMitigation -Name mspub.exe -Enable DEP,BottomUp,CFG,AuditRemoteImageLoads,AuditLowLabelImageLoads,EnableExportAddressFilter,EnableExportAddressFilterPlus,EnableImportAddressFilter,EnableRopStackPivot,EnableRopCallerCheck,EnableRopSimExec,SEHOP,TerminateOnError,AuditChildProcess
Set-ProcessMitigation -Name msaccess.exe -Enable DEP,BottomUp,CFG,AuditRemoteImageLoads,AuditLowLabelImageLoads,EnableExportAddressFilter,EnableExportAddressFilterPlus,EnableImportAddressFilter,EnableRopStackPivot,EnableRopCallerCheck,EnableRopSimExec,SEHOP,TerminateOnError,AuditChildProcess
Set-ProcessMitigation -Name lync.exe -Enable DEP,BottomUp,CFG,AuditRemoteImageLoads,AuditLowLabelImageLoads,EnableExportAddressFilter,EnableExportAddressFilterPlus,EnableImportAddressFilter,EnableRopStackPivot,EnableRopCallerCheck,EnableRopSimExec,SEHOP,TerminateOnError,AuditChildProcess
Set-ProcessMitigation -Name fltldr.exe -Enable DEP,BottomUp,CFG,AuditRemoteImageLoads,AuditLowLabelImageLoads,EnableExportAddressFilter,EnableExportAddressFilterPlus,EnableImportAddressFilter,EnableRopStackPivot,EnableRopCallerCheck,EnableRopSimExec,SEHOP,TerminateOnError,AuditChildProcess
Set-ProcessMitigation -Name infopath.exe -Enable DEP,BottomUp,CFG,AuditRemoteImageLoads,AuditLowLabelImageLoads,EnableExportAddressFilter,EnableExportAddressFilterPlus,EnableImportAddressFilter,EnableRopStackPivot,EnableRopCallerCheck,EnableRopSimExec,SEHOP,TerminateOnError,AuditChildProcess
Set-ProcessMitigation -Name wordpad.exe -Enable DEP,BottomUp,CFG,AuditRemoteImageLoads,AuditLowLabelImageLoads,EnableExportAddressFilter,EnableExportAddressFilterPlus,EnableImportAddressFilter,EnableRopStackPivot,EnableRopCallerCheck,EnableRopSimExec,SEHOP,TerminateOnError,AuditChildProcess
Set-ProcessMitigation -Name plugin-container.exe -Enable DEP,BottomUp,CFG,AuditRemoteImageLoads,AuditLowLabelImageLoads,EnableExportAddressFilter,EnableExportAddressFilterPlus,EnableImportAddressFilter,EnableRopStackPivot,EnableRopCallerCheck,EnableRopSimExec,SEHOP,TerminateOnError,AuditChildProcess
Set-ProcessMitigation -Name java.exe -Enable DEP,BottomUp,CFG,AuditRemoteImageLoads,AuditLowLabelImageLoads,EnableExportAddressFilter,EnableExportAddressFilterPlus,EnableImportAddressFilter,EnableRopStackPivot,EnableRopCallerCheck,EnableRopSimExec,SEHOP,TerminateOnError,AuditChildProcess
Set-ProcessMitigation -Name javaw.exe -Enable DEP,BottomUp,CFG,AuditRemoteImageLoads,AuditLowLabelImageLoads,EnableExportAddressFilter,EnableExportAddressFilterPlus,EnableImportAddressFilter,EnableRopStackPivot,EnableRopCallerCheck,EnableRopSimExec,SEHOP,TerminateOnError,AuditChildProcess
Set-ProcessMitigation -Name javaws.exe -Enable DEP,BottomUp,CFG,AuditRemoteImageLoads,AuditLowLabelImageLoads,EnableExportAddressFilter,EnableExportAddressFilterPlus,EnableImportAddressFilter,EnableRopStackPivot,EnableRopCallerCheck,EnableRopSimExec,SEHOP,TerminateOnError,AuditChildProcess
Set-ProcessMitigation -Name wmplayer.exe -Enable DEP,BottomUp,CFG,AuditRemoteImageLoads,AuditLowLabelImageLoads,EnableRopStackPivot,EnableRopCallerCheck,EnableRopSimExec,SEHOP,TerminateOnError,AuditChildProcess
}
harden_processes

Invoke-WebRequest -Uri https://demo.wd.microsoft.com/Content/ProcessMitigation.xml -OutFile $altanosinstdir\ProcessMitigation.xml
Set-ProcessMitigation -PolicyFilePath $altanosinstdir\ProcessMitigation.xml

# Disable SMBv3 compression
# You can disable compression to block unauthenticated attackers from exploiting the vulnerability against an SMBv3 Server with the PowerShell command below.
# No reboot is needed after making the change. This workaround does not prevent exploitation of SMB clients.
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" DisableCompression -Type DWORD -Value 1 -Force

# Enable Defender signatures for Potentially Unwanted Applications (PUA)
Set-MpPreference -PUAProtection enable

# Enable Network protection
# Enabled - Users will not be able to access malicious IP addresses and domains
# Disable (Default) - The Network protection feature will not work. Users will not be blocked from accessing malicious domains
# AuditMode - If a user visits a malicious IP address or domain, an event will be recorded in the Windows event log but the user will not be blocked from visiting the address.
Set-MpPreference -EnableNetworkProtection Enabled 

# List the optional features in the running Operating System:
#    PS C:\> Get-WindowsOptionalFeature –Online
function disable_win_feature() {
Disable-WindowsOptionalFeature -NoRestart -Online -FeatureName SMB1Protocol
Disable-WindowsOptionalFeature -NoRestart -Online -FeatureName SMB1Protocol-client
Disable-WindowsOptionalFeature -NoRestart -Online -FeatureName Microsoft-RemoteDesktopConnection
Disable-WindowsOptionalFeature -NoRestart -Online -FeatureName WorkFolders-Client
Disable-WindowsOptionalFeature -NoRestart -Online -FeatureName Printing-Foundation-Internetprinting-Client
Disable-WindowsOptionalFeature -NoRestart -Online -FeatureName MSRDC-Infrastructure
Disable-WindowsOptionalFeature -NoRestart -Online -FeatureName MicrosoftWindowsPowerShellV2
Disable-WindowsOptionalFeature -NoRestart -Online -FeatureName MicrosoftWindowsPowerShellV2Root
}
disable_win_feature

# To replace the command in harden-*.cmd - https://learn.microsoft.com/en-us/powershell/module/dism/repair-windowsimage?view=windowsserver2022-ps
# Repair-WindowsImage -Online -RestoreHealth -Source "$sysdrive\Windows\WinSxS" 
Repair-WindowsImage  -RestoreHealth -StartComponentCleanup  -ResetBase -NoRestart -Online

# Repair-WindowsImage -CheckHealth -ScanHealth -RestoreHealth -StartComponentCleanup -ResetBase -NoRestart -Online

# Quick note: maybe export the resulting image to a https://github.com/threader/Create-BitLocker-Encrypted-VHDX-Virtual-Disk-Containerfile and drop into that if not on win pro?
# todo: detect if the running windows meets the requirements
# https://learn.microsoft.com/en-us/windows/security/application-security/application-isolation/windows-sandbox/windows-sandbox-overview
# https://learn.microsoft.com/en-us/windows/security/application-security/application-isolation/windows-sandbox/windows-sandbox-configure-using-wsb-file
# VM_Config.wsb :
#
# <Configuration>
#   <MappedFolders>
#    <MappedFolder>
#     <HostFolder>C:\Users\Public\Downloads</HostFolder>
#     <SandboxFolder>C:\Users\WDAGUtilityAccount\Downloads</SandboxFolder>
#     <ReadOnly>Enable</ReadOnly>
#    </MappedFolder>
#  </MappedFolders>
# <AudioInput>Disable</AudioInput>
# <VideoInput>Disable</VideoInput>
#
# https://learn.microsoft.com/en-us/windows/win32/secauthz/appcontainer-isolation
# AppContainer Isolation provides Credential, Device, File, Network, Process, and Window isolation.
# <ProtectedClient>Enable</ProtectedClient>
#
# Printer sharing is disabled by default
# <PrinterRedirection>Enable</PrinterRedirection> 
#
# Clipboard sharing is enabled by default 
# <ClipboardRedirection>Disable</ClipboardRedirection>
#
# <MemoryInMB>value</MemoryInMB>
#
#   <LogonCommand>
#    <Command>explorer.exe C:\users\WDAGUtilityAccount\Downloads</Command>
#  </LogonCommand>
#
#  <LogonCommand>
#    <Command>powershell.exe -ExecutionPolicy Bypass -File C:\sandbox\SwapMouse.ps1</Command>
#  </LogonCommand>
#
# 
# </Configuration>
# EOF VM_Config.wsb
#
#  to swap the primary mouse button for left-handed users:
# https://learn.microsoft.com/en-us/windows/security/application-security/application-isolation/windows-sandbox/windows-sandbox-configure-using-wsb-file#swapmousewsb
# SwapMouse.ps1:
# [Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") | Out-Null
#
# $SwapButtons = Add-Type -MemberDefinition @'
# [DllImport("user32.dll")]
# public static extern bool SwapMouseButton(bool swap);
# '@ -Name "NativeMethods" -Namespace "PInvoke" -PassThru

# $SwapButtons::SwapMouseButton(!([System.Windows.Forms.SystemInformation]::MouseButtonsSwapped))
#
# EOF SwapMouse.ps1
#

# https://learn.microsoft.com/en-us/powershell/module/hyper-v/set-vmprocessor?view=windowsserver2025-ps
# https://learn.microsoft.com/en-us/windows/security/application-security/application-isolation/windows-sandbox/windows-sandbox-overview
# This sets up a 6.4 gb image in \ProgramData\Microsoft\Contrainers\*
Enable-WindowsOptionalFeature -FeatureName "Containers-DisposableClientVM" -All -Online
# Set-VMProcessor -VMName VM-Sandbox -ExposeVirtualizationExtensions $true
# Update-VMVersion -VMName VM-Sandbox


Read-Host -Prompt "Press any key to continue"
