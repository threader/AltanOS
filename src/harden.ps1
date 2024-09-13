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
}
disable_win_feature

# todo: detect if the running windows meets the requirements
# https://learn.microsoft.com/en-us/windows/security/application-security/application-isolation/windows-sandbox/windows-sandbox-overview
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

# Add-BitLockerKeyProtector -MountPoint C -RecoveryPasswordProtector
# $SecureString = ConvertTo-SecureString "123456" -AsPlainText -Force
# Enable-BitLocker $sysdrive -StartupKeyProtector -EncryptionMethod XtsAes256 -Pin $SecureString # -TPMandPinProtector # -TpmProtector


