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
   Write-Output "---------------------------------------------" 
   Write-Output "WindowsCapability list prior:"         
Get-WindowsCapability -online | Where-Object { ($_.Name) -and ($_.State -like 'Installed') }
   Write-Output "---------------------------------------------" 
Get-WindowsCapability -online | Where-Object { ($_.Name) -and ($_.State -like 'Installed') -and ($_.Name -notlike "Language.Basic*") -and ($_.Name -notlike "Language.Handwriting*") -and ($_.Name -notlike "Windows.Client.ShellComponents*") -and ($_.Name -notlike "OpenSSH.Client*") -and ($_.Name -notlike "Microsoft.Windows.Powershell.ISE*") -and ($_.Name -notlike "Microsoft.Windows.Notepad*") -and ($_.Name -notlike "Microsoft.Windows.MSPaint") -and ($_.Name -notlike "MathRecognizer*") -and ($_.Name -notlike "Print.Fax.Scan") | Remove-WindowsCapability -online }
   Write-Output "---------------------------------------------" 
   Write-Output "WindowsCapability list after:" 
Get-WindowsCapability -online | Where-Object { ($_.Name) -and ($_.State -like 'Installed') }
   Write-Output "---------------------------------------------" 

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
 $GET_APPXPPACKAGE_ALL = Get-AppXProvisionedPackage -online | Where-Object { ($_.PackageName) }
 $GET_APPXPPACKAGE = Get-AppXProvisionedPackage -online | Where-Object { ($_.PackageName) -and ($_.PackageName -notlike "Microsoft.DesktopAppInstaller*") -and ($_.PackageName -notlike "Microsoft.HEIFImageExtension*") -and ($_.PackageName -notlike "Microsoft.MicrosoftSolitaireCollection*") -and ($_.PackageName -notlike "Microsoft.MSPaint*") -and ($_.PackageName -notlike "Microsoft.MicrosoftStickyNotes") -and ($_.PackageName -notlike "Microsoft.Windows.Photos*") -and ($_.PackageName -notlike "Microsoft.MicrosoftEdge*") -and ($_.PackageName -notlike "Microsoft.StorePurchaseApp*") -and ($_.PackageName -notlike "Microsoft.VP9*") -and ($_.PackageName -notlike "Microsoft.VP9VideoExtensions*") -and ($_.PackageName -notlike "Microsoft.Web*Extension*") -and ($_.PackageName -notlike "Microsoft.Wallet*") -and ($_.PackageName -notlike "Microsoft.Windows.DevHome*") -and ($_.PackageName -notlike "Microsoft.WindowsStore*") -and ($_.PackageName -notlike "Microsoft.WindowsMaps*")  -and ($_.PackageName -notlike "Microsoft.WindowsSoundRecorder*") -and ($_.PackageName -notlike "Microsoft.VCLibs*") -and ($_.PackageName -notlike "Microsoft.VP9VideoEstension*") -and ($_.PackageName -notlike "Microsoft.Web*Extension*") -and ($_.PackageName -notlike "Microsoft.Wallet*") -and ($_.PackageName -notlike "Microsoft.Windows.DevHome*") -and ($_.PackageName -notlike "Microsoft.WindowsAlarms*") -and ($_.PackageName -notlike "Microsoft.WindowsCalculator*") }
 $GET_APPXPPACKAGE_NAME = Write-Output $GET_APPXPPACKAGE.PackageName
 $GET_APPXPPACKAGE_NAME_ALL = Write-Output $GET_APPXPPACKAGE_ALL.PackageName
  # Write-Output $GET_APPXPPACKAGE_NAME_ALL
   Write-Output "---------------------------------------------" 
   Write-Output "Packages list prior:"        
   Write-Output $GET_APPXPPACKAGE_NAME_ALL   
   Write-Output "---------------------------------------------" 
   Write-Output "Packages to be removed: $GET_APPXPPACKAGE_NAME"
   Write-Output "---------------------------------------------"
 ForEach ($_ in $GET_APPXPPACKAGE_NAME) {
   Remove-AppxProvisionedPackage -AllUsers -Online -PackageName $GET_APPXPPACKAGE_NAME
}
   Write-Output "Packages list after:"
   Write-Output $GET_APPXPPACKAGE_NAME_ALL
   Write-Output "---------------------------------------------" 

}
disable_win_feature

$sysdrive =  $Env:SystemDrive
# To replace the command in harden-*.cmd - https://learn.microsoft.com/en-us/powershell/module/dism/repair-windowsimage?view=windowsserver2022-ps
 Repair-WindowsImage -Online -RestoreHealth -Source "Ssysdrive\Windows\WinSxS" 
# Repair-WindowsImage -CheckHealth -ScanHealth -RestoreHealth -StartComponentCleanup -ResetBase -NoRestart -Online


# note :
# It is my opinion that encrypting the entire HDD is a complete waste of read/write cycles, 
# using something like a bellow encrypted throw away disposable VM image or really something makes more sense. 
# nb. maintainability and backup in case of emergency, that emergency could be some poor animal, an ant or idk, snail crawling scross your TPM module? it is afer all a lot easier to ask the user 'do you happen to remember 
# your users/ passwo, your windows/system password or %programfiles% or Documents password than do you remember your password and 
#'oh yeah have you maybe seen that 128 digit hex decimal or whatever hash that flew by that one time you'r computer crashed'. 

# while im noting notes, keep the VM encryption script in .bat or .cmd or so, these scripts are with 
# probably little to no modification compatible as far back as powershell goes? and even then the .ps1 
# scripts can simply be dropped and you have a reasonable result, or what do i know, powershell might 
# be running on "'win2k'" with all those whacky backports that was floating around.  
# Since i'm a sucker for backwards and fowards compabilbity, at least try to make notes of breakge and possible w/a

# hmm, win2k... hmmm thats been a while, might be handy to have a bootable image to boot from usb, no?
# this is for research and i hope some verified valied sources can be found so this too can be handled 
# from the ground up, "easily", i'm sure this will be real quick, i mean, how much fuss can win2k 
# and all the patched until extended EOL support or whatever and finding some sort of 
# verified link to the 2bn patches for that really be, anyway? and what about crawiling up the windowses 
# to have them all handy on one bootable usb drive for support, reaserch etc? 

# Where to begin. ... 
# https://archive.org/details/win2kproiso
# https://archive.org/details/Windows2000_en-us 
# https://archive.org/details/windows-2000-kb-935839-v-30e-x-86-extendedkernel-enu
# https://w2k.phreaknet.org/guide 
# https://www.reddit.com/r/windows2000/comments/10jbglp/windows_2000_in_2023_and_more/ 


# niice https://archive.org/details/windows-nt-4_202102
# Nt 4 note:
# https://archive.org/download/windows-nt-4_202102/Windows%20NT%204.iso
 # https://archive.org/download/WinNT40SP6aISOEXE/sp6ai386.iso
 # https://archive.org/download/WinNT40SP6aISOEXE/sp6ai386.exe
 # https://winworldpc.com/product/windows-nt-40/patches
 # https://winworldpc.com/download/41c384c2-a875-18c3-9a11-c3a4e284a2ef (nt4 usb support)
# https://www.itprotoday.com/devops/adding-wmi-to-nt-4-0-and-win95-systems
  # 
# ahem. i want dos 7.0 https://archive.org/download/windows-me_202103/MEFull.iso
# 
# could i get away with grabbing SP4 and the extended kernel and replacing it with win 10 maybe?
# # nopw, i must have misread or sorthing.. there was a time when wine happily chewed windows .dll's, those old versions could come in handy developing the win2kX images.
# Right, this could be fun :D --- huhm, i believe win2k could be stripped rather hard in it self, does OneFileLinux have a companion?
# hmm. continuing that trail of thought, maybe get something around win7(x86/x64) or so, see how far that can be stripped, use that 
# as something of a recovery for windows stuff, have win2k handy for booting in something like an .efi or load fron grub/2/wingrub/ whatever 
# in either case, i also wonder if it's possible to somehow chainload upwards in some fasion, create all sorts of imaginable recovery
# options and see what floats what. having win2k booted in ram sounds rather cool either way so i think i'll start there slowly.
# I guess the next reasonable version is win2003 etc, maybe research the server releases here as this isnt to be used at bastille and
# for recovery and research anyway. huhm, that wound mean if onefilelinux incudeed qemu... there are chances of recovery there. 
# as like fixing ntfs volumes requires a proper ntfs.dll version etc , not to mention this bitlocker madnsess... in the end 
# i fully expect to be stuffing things trough an early version as possible bitlocker to if i so must shoehorn something in
# win7-x64 or whatever the earliest can be made to decrypt win10/11 etc. bitlocker encrypted volumes? hrmf, ReactOS or.. something...?
# christ , what is this, my theisis is OS design; what about making everything configurable, creating all the above mentioned versions
# and why not include everything from some DOS to some franken Win9x/ME thing or something. I'm pretty sure you could just run GRUB from
# OFL.efi already so it would be just a matter of mounting the .img/.iso/.wmi or something. so then the design would be something like:
# win2k/03/08 compatible unencrypted ntfs c:\ with encerypted %Documents% %programfiles% etc.. etc.. it's really just a matter 
# of exporting the .reg for programs to run across platforms anwyay so you could have a sit. where you have a drive r: with .reg
# and other config files and just boot any random WinNT version and rock on... hmmm  
 
# Mkay my draft proposal of the layout for this I would like to be something like: 
# ESP/EFI Partition: 512mb fat16
#  * One File Linux w/GRUB and Win2kX .wmi
# RECOVERY_BASIC 
# * (Win2008 or the first basic common denomenator that supports the generation laptop and the requierd versions
# something with bitlocker compatible with win 10/11 say) 
# * (a debian stable to chroot to from One File Linux or something)
# RECOVERY_ENCRYPTED_OR_WHATEVER(if needed for increased security or maybe use this as the backup partition)
# * Encrypted volume or image files of some sort
# SYSTEM (NTFS)
# * Win 10/11 ( user ) *image 
# * Win 2016/2025 * Images 
# * Win 2008/2012??? * Images 
# SYSTEM ( EXT 4 )
# u know what to do
# BACKUP
# Then comes what to do, or how to handle things so that we can have users/ %programfiles% (most interesting right now since there 
# will be some switching between the early winnt versions as a startingpoint here etc. on a different "HDD" alltogether etc and have 
# this work like mount -o loop etc. 



# Maybe have an encrypted WMI or whatever that you boot from, mabye encrypt the windows folder 
# maybe encrypt the /Users/<user> foler or maybe just documents or pictures or something. ,
# Reasonably, id say create an encrypted 'stable' windows image and store somewhere as a backup anyway, 
# and copy this and use it as the regular 'day to day' boot image. create another encrypted image
# and store /users/ in , and this can be on something like d:  

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
Set-VMProcessor -VMName VM-Sandbox -ExposeVirtualizationExtensions $true
Update-VMVersion -VMName VM-Sandbox
Enable-WindowsOptionalFeature -FeatureName "Containers-DisposableClientVM" -All -Online


