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

# List the optional features in the running Operating System:
#    PS C:\> Get-WindowsOptionalFeature –Online
function disable_win_feature() {
Disable-WindowsOptionalFeature -NoRestart -Online -FeatureName SMB1Protocol
Disable-WindowsOptionalFeature -NoRestart -Online -FeatureName SMB1Protocol-client
Disable-WindowsOptionalFeature -NoRestart -Online -FeatureName Microsoft-RemoteDesktopConnection
Disable-WindowsOptionalFeature -NoRestart -Online -FeatureName WorkFolders-Client
Disable-WindowsOptionalFeature -NoRestart -Online -FeatureName Printing-Foundation-Internetprinting-Client
Disable-WindowsOptionalFeature -NoRestart -Online -FeatureName MSRDC-Infrastructure
# im not even on a pc or remotely close to home but read about this, more reading to follow i guess.
# it may be possible to run something like the get-appxpackage | remove-appxpackage
# https://learn.microsoft.com/en-us/powershell/module/dism/get-windowscapability?view=windowsserver2022-ps
# https://learn.microsoft.com/en-us/powershell/module/dism/remove-windowscapability?view=windowsserver2022-ps
Get-WindowsCapability -online | Where-Object { $_.Name -like '*VBSCRIPT*' } | Remove-WindowsCapability -online

$PKG_RM = @("Media.WindowsMediaPlayer*","Media.Windows.WordPad*", "Language.Speech*", "Language.TextToSpeech*","Hello.Face.18967*", " Hello.Face.Migration.18967*", "Browser.InternetExplorer*", "App.Support.QuickAssist*", "App.StepRecorder*")
#  "MathRecognize*",
For ($i=0; $i -lt $PKG_RM.Length; $i++) {
Get-WindowsCapability -online | Where-Object { $_.Name -like '$i' } | Remove-WindowsCapability -online
}

# Media.WindowsMediaPlayer
# Media.Windows.WordPad
# MathRecognize
# Language.Speech
# Language.TextToSpeech
# Hello.Face.18967
# Hello.Face.Migration.18967
# Browser.InternetExplorer
# App.Support.QuickAssist
# App.StepRecorder
}
disable_win_feature

# todo: detect if the running windows meets the requirements
# https://learn.microsoft.com/en-us/windows/security/application-security/application-isolation/windows-sandbox/windows-sandbox-overview
# https://learn.microsoft.com/en-us/windows/security/application-security/application-isolation/windows-sandbox/windows-sandbox-configure-using-wsb-file
# VM_Config.wsb
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
# AppContainer Isolation provides Credential, Device, File, Network, Process, and Window isolation.
# <ProtectedClient>Enable</ProtectedClient>
# Printer sharing is disabled by default
# <PrinterRedirection>Enable</PrinterRedirection> 
# Clipboard sharing is enabled by default 
# <ClipboardRedirection>Disable</ClipboardRedirection>
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
Set-VMProcessor -VMName VM-Sandbox -ExposeVirtualizationExtensions $true
Update-VMVersion -VMName VM-Sandbox
Enable-WindowsOptionalFeature -FeatureName "Containers-DisposableClientVM" -All -Online

# Make this a choice
# Docs: 
# https://learn.microsoft.com/en-us/windows/win32/secprov/getencryptionmethod-win32-encryptablevolume
# https://learn.microsoft.com/en-us/windows/security/operating-system-security/data-protection/bitlocker/operations-guide?tabs=powershell#bitlocker-powershell-module 
# https://learn.microsoft.com/en-us/powershell/module/bitlocker/add-bitlockerkeyprotector?view=windowsserver2022-ps
# https://learn.microsoft.com/en-us/powershell/module/bitlocker/enable-bitlocker?view=windowsserver2022-ps
# 
# "BitLocker automatically encrypts internal drives during the out-of-box experience (OOBE) "

# Disable for devices in need of performance over security 
# Disable-Bitlocker

# $sysdrive =  $Env:SystemDrive
#
# Rip from MS docs - note "Allow BitLocker without a compatible TPM " is set in harden.reg
# $pw = Read-Host -AsSecureString
# Add-BitLockerKeyProtector E: -PasswordProtector -Password $pw

# Add-BitLockerKeyProtector -MountPoint $sysdrive -RecoveryPasswordProtector
# $SecureString = ConvertTo-SecureString "123456" -AsPlainText -Force
# Enable-BitLocker $sysdrive -StartupKeyProtector -EncryptionMethod XtsAes256 -Pin $SecureString # -TPMandPinProtector # -TpmProtector
#
# Obtain the ID of the new recovery password:
# (Get-BitLockerVolume -mountpoint $env:SystemDrive).KeyProtector | where-object {$_.KeyProtectorType -eq 'RecoveryPassword'} | ft KeyProtectorId,RecoveryPassword



