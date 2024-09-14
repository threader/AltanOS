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
 
# https://learn.microsoft.com/en-us/powershell/module/dism/get-windowscapability?view=windowsserver2022-ps
# https://learn.microsoft.com/en-us/powershell/module/dism/remove-windowscapability?view=windowsserver2022-ps
# Get-WindowsCapability -online | Where-Object { $_.Name -like '*VBSCRIPT*' } | Remove-WindowsCapability -online

Get-WindowsCapability -online | Where-Object { ($_.Name) -and ($_.State -like 'Installed') -and ($_.Name -notlike "Language.Basic*") -and ($_.Name -notlike "Language.Handwriting*") -and ($_.Name -notlike "Windows.Client.ShellComponents*") -and ($_.Name -notlike "OpenSSH.Client*") -and ($_.Name -notlike "Microsoft.Windows.Powershell.ISE*") -and ($_.Name -notlike "Microsoft.Windows.Notepad*") -and ($_.Name -notlike "Microsoft.Windows.MSPaint") -and ($_.Name -notlike "MathRecognizer*") -and ($_.Name -notlike "Print.Fax.Scan") | Remove-WindowsCapability -online }

# to check installed:
# Get-WindowsCapability -online | Where-Object { ($_.Name) -and ($_.State -like 'Installed') }
#
# These are the packages that _were_ left on the system prior to the commands above: 
#  add-windowscapability -online -Name "MathRecognizer~~~~0.0.1.0"
#  add-windowscapability -online -Name "Microsoft.Windows.MSPaint~~~~0.0.1.0"
#  add-windowscapability -online -Name "Microsoft.Windows.Notepad~~~~0.0.1.0"
#  add-windowscapability -online -Name "Microsoft.Windows.PowerShell.ISE~~~~0.0.1.0" # Not reinstallable
#  add-windowscapability -online -Name "Windows.Client.ShellComponents~~~~0.0.1.0" # Not reinstallable
#  add-windowscapability -online -Name "OpenSSH.Client~~~~0.0.1.0" # Not reinstallable
#  add-windowscapability -online -Name "Language.Basic~~~en-GB~0.0.1.0"
#  add-windowscapability -online -Name Language.Handwriting~~~en-GB~0.0.1.0
#  add-windowscapability -online -Name Language.OCR~~~en-GB~0.0.1.0
#  add-windowscapability -online -Name Language.Speech~~~en-GB~0.0.1.0
#  add-windowscapability -online -Name Language.TextToSpeech~~~en-GB~0.0.1.0
#  add-windowscapability -online -Name Microsoft.Windows.WordPad~~~~0.0.1.0
#  add-windowscapability -online -Name OneCoreUAP.OneSync~~~~0.0.1.0
#  add-windowscapability -online -Name Print.Fax.Scan~~~~0.0.1.0 # this could probably be handy? - Not reinstallable

# 
 $GET_APPXPPACKAGE = Get-AppXProvisionedPackage -online | Where-Object { ($_.PackageName) -and ($_.PackageName -notlike "Microsoft.DesktopAppInstaller*") -and ($_.PackageName -notlike "Microsoft.HEIFImageExtension*") -and ($_.PackageName -notlike "Microsoft.MicrosoftSolitaireCollection*") -and ($_.PackageName -notlike "Microsoft.MSPaint*") -and ($_.PackageName -notlike "Microsoft.MicrosoftStickyNotes") -and ($_.PackageName -notlike "Microsoft.Windows.Photos*") -and ($_.PackageName -notlike "Microsoft.MicrosoftEdge*") -and ($_.PackageName -notlike "Microsoft.StorePurchaseApp*") -and ($_.PackageName -notlike "Microsoft.VP9*") -and ($_.PackageName -notlike "Microsoft.VP9VideoExtensions*") -and ($_.PackageName -notlike "Microsoft.Web*Extension*") -and ($_.PackageName -notlike "Microsoft.Wallet*") -and ($_.PackageName -notlike "Microsoft.Windows.DevHome*") -and ($_.PackageName -notlike "Microsoft.WindowsStore*") -and ($_.PackageName -notlike "Microsoft.WindowsMaps*")  -and ($_.PackageName -notlike "Microsoft.WindowsSoundRecorder*") -and ($_.PackageName -notlike "Microsoft.VCLibs*") -and ($_.PackageName -notlike "Microsoft.VP9VideoEstension*") -and ($_.PackageName -notlike "Microsoft.Web*Extension*") -and ($_.PackageName -notlike "Microsoft.Wallet*") -and ($_.PackageName -notlike "Microsoft.Windows.DevHome*") -and ($_.PackageName -notlike "Microsoft.WindowsAlarms*") -and ($_.PackageName -notlike "Microsoft.WindowsCalculator*") }
 $GET_APPXPPACKAGE_NAME = Write-Output $GET_APPXPPACKAGE.PackageName
  # Write-Output $GET_APPXPPACKAGE_NAME
 
 ForEach ($_ in $GET_APPXPPACKAGE_NAME) {
   Write-Output $_
   Remove-AppxProvisionedPackage -AllUsers -Online -PackageName $_
 }

}
disable_win_feature

# To replace the command in harden-*.cmd 
Repair-WindowsImage -CheckHealth -ScanHealth -RestoreHealth -StartComponentCleanup -ResetBase -NoRestart -Online

# note: https://learn.microsoft.com/en-us/powershell/module/dism/?view=windowsserver2022-ps 
# Get-NonRemovableAppsPolicy -Online  # or -Path ".\wim\image.wim"
# Set-NonRemovableAppsPolicy -Online -PackageFamilyName Application1_1.0.0.0+x64__ms7gsqeatfeb6 -NonRemovable 0
# Get-AppxProvisionedPackage -Online 
# Remove-AppxProvisionedPackage -PackageName MyAppxPkg -AllUsers -Online <package_name>
# Remove-WindowsDriver -Path "c:\offline" -Driver "OEM1.inf"
# Optimize-AppXProvisionedPackages -Online 
# Optimize-WindowsImage -Path "c:\" -OptimizationTarget "WIMBoot" 
# https://learn.microsoft.com/en-us/powershell/module/dism/new-windowsimage?view=windowsserver2022-ps :
# New-WindowsImage -ImagePath "c:\imagestore\custom.wim" -CapturePath "d:\" -Name "Drive D"
# https://learn.microsoft.com/en-us/powershell/module/dism/export-windowsimage?view=windowsserver2022-ps
# Export-WindowsImage -SourceImagePath C:\imagestore\custom.wim -SourceIndex 1 -DestinationImagePath c:\imagestore\export.wim -DestinationName "Exported Image"
# Export-WindowsImage -CheckIntegrity -SourceImagePath C:\imagestore\custom.wim -SourceIndex 1 -DestinationImagePath c:\imagestore\export.wim -DestinationName "Exported Image" -Setbootable -WIMBoot

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



