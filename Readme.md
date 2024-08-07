# AltanOS - started it's life as an overdue todo item of severe necessity and randomly being inspired to persue after reading trough the scripts of from PC-Tuning and Atlas by 'amitvxv' and co.

This project is undergoing change, testing and has not settled. It might not run as expected, experience adviced. This will remove all removable Windows packages on the system.

The goal of this project is to optimize/minimize and harden Windows systems, making the deployed system more maintainable with tools like winget and UniGetUI and the 3rd party module 'PSWindowsUpdate'.

Run AltanOS.cmd from It's parent directory and the rest happens with some interaction. There are some pauses for input and information text, uninstalling Edge needs a mouse button click, 'PSWindowsUpdate' also require NuGet that requires confirmation.

It will copy itself to the system partition equivlent to C:\AltanOS and C:\AltanOS.inst

Mind the TinyWall firewall - select 'Autolearn' if you have problems and use the 'Manage' dialog to tune the selection. Hopefully a more elegant solution cand be found like importing the .tws file in AltanOS\bin

N.B: Uninstalling TinyWall while configured to block an application or default settings will lead to connection blocking even after uninstall!

N.B: Malwarebytes and Spybot AntiBeacon. AntiBeacon modifies the host file and Malwarebytes believes this is host file hijacking.

Tested on Windows 10 and Windows 11.


# The following files can run standalone if needed:
* harden-AltanOS.cmd
* harden.reg 				- ofc 
* pkgs-prep.ps1
* schedule-tasks.ps1

# The following packages are installed:
* VCLibs
* NET.CoreRuntime
* NET.Native
* NET.Native.Runtime
* NET.Native.Framework.1.7
* UI.Xaml* 
* PackageManagement.NuGetProvider
* UI.Xaml.2.7* 
* WindowsStore
* StorePurchaseApp
* ##MicrosoftOfficeHub
* WindowsCalculator
* MSPaint
* MicrosoftSolitaireCollection

# The folloiwng packages are grabbed by 'WinGet'
* Sandboxie.Plus
* SomePythonThings.WingetUIStore
* Git.Git
* Microsoft.Sysinternals.ProcessMonitor
* Microsoft.Sysinternals.ProcessExplorer
* #Microsoft.Powershell
* Google.Chrome 
* Mozilla.Firefox
* 7zip.7zip
* VideoLAN.VLC
* GIMP.GIMP
* TheDocumentFoundation.LibreOffice
* Piriform.Recuva
* Piriform.Defraggler
* Nlitesoft.NTLite
* Malwarebytes.Malwarebytes
* SaferNetworking.SpybotAntiBeacon

# It will schedule tasks to be autorun: 
* autorun-update.ps1                - Runs PSWindowsUpdate every thuesday at 17pm
* autorun-maintain.ps1              - Runs sfc /scannow and DISM /Online /Cleanup-Image /StartComponentCleanup /ResetBase /RestoreHealth every 3 weeks at 18pm  
* autorun-privazer.ps1              - Runs PrivaZer to delete residue in the NTFS journal, and write ZERO to the free disk space as well as remove temporary files everywhere. Every 3 weeks Wedensday at 17pm
* autorun-awdcleaner.ps1            - Runs AwdClenaer every Wedensday at 16pm.

autorun-maintain.ps1 will also be run upon login, once, after a reboot(!!!).

# TODO:
* Bother to ask when to schedule thing.
* Ask to either install MalwareBytes or run to AwdCleaner sometimes? - Just shecule AwdCleaner to run anyway.
* Add AwdCleaner and scan quickly before proceeding. - Added, but not set any arguments and requires user interaction.
* Ask if you wish to install LibreOffice or Microsoft Office.
* Dig around for more hardening or other things that make sense.
* Better Readme and explenation, 2 days now i've layed down in bed to sleep then having a great idea what to write, then not when i wake up... - Done?
* Try to preconfigure Sandboxie.

v 0.0.1 - ish

* Fix the sheduled task and create one for sfc and dism every... two, maybe three weeks? - Maybe fixed
* Move AltanOS* to somewhere predictable. - Fixed
* More testing. - Ongoing - Still.. 
* Add a script to run once at first startup to resolve an iusse where we are already in need to reboot. - Maybe fixed
* Try to stop loosing work when hibernating linux and not properly shutting down windows (holding left ctrl while selecting power off), linux isnt grabbing the new journal state of the NTFS drive file states after resuming from hibernation, this results in data loss and corruption if you then proceed ot unmount the volume in linux, a chkdsk from windows _can_ fix this, or a hard reset of linux if you've got nothing to loose....   - I almost lost all this again instead ...

v 0.0.0
