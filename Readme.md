## AltanOS - started it's life as an overdue todo item of severe necessity, randomly being inspired to persue after reading trough the scripts of PC-Tuning and Atlas by 'amitvxv' and co. and having a handfull of recrent tricks worth looking into.

This project is undergoing change, testing and has not settled. It might not run as expected, experience adviced, so is a fresh install. Be prepared to step trough the script with PowerShell ISE. This will remove all removable Windows packages for all users on the system.

The goal of this project is to optimize/minimize and harden Windows systems, making the deployed system more maintainable with tools like winget and UniGetUI and the 3rd party module 'PSWindowsUpdate'.

Run AltanOS.cmd from It's parent directory and the rest happens with some interaction. There are some pauses for input and information text, uninstalling Edge needs a mouse button click, 'PSWindowsUpdate' also require NuGet that requires confirmation.

This project will copy itself to the system partition equivlent to C:\AltanOS and C:\AltanOS.inst

- Important notes:
	* Remember to grab the submodules. 
	```console 
	:: After first git clone: 
	git submodule update --init --recursive 
	:: pull latest submodules changes:
	git submodule update --recursive
	```
	
	* Fastboot/Hiberboot is disabled, so Windows will properly shut down, unmount disks, unlock the NTFS journal and take some extra time to boot.

	* Mind the TinyWall firewall - select 'Autolearn' if you have problems and use the 'Manage' dialog to tune the selection. Hopefully a more elegant solution cand be found like importing the .tws file in AltanOS\bin

	* N.B: Uninstalling TinyWall while configured to block an application or default settings will lead to connection blocking even after uninstall!

	* N.B: Malwarebytes and Spybot AntiBeacon. AntiBeacon modifies the host file and Malwarebytes believes this is host file hijacking.

	* N.B: The Intel HD 3000 driver will fail to load the kernel mode driver, 'Core isolation\Memory integrity' will have to be disabled on these systems.

- On the pluss side I found a patched driver to allow OpenGL3.1 and a trick with using Mesa 20.2.0 that should allow OpenGL 3.3 on these devices

	* https://gist.github.com/rb-dahlb/26f316c5b6089807a139fc44ee69f0d1

	* https://www.intel.com/content/www/us/en/support/articles/000091878/graphics.html#:~:text=Download%20Display%20Driver%20Uninstaller%20(DDU,in%20safe%20mode%20in%20Windows.)

	* https://www.reddit.com/r/lowendgaming/comments/1258usx/updated_win1011_drivers_for_intel_hd_3000/

If it is the case that old drivers are missbehaving - Run and reboot:

```console
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DeviceGuard" /t REG_DWORD /v "HypervisorEnforcedCodeIntegrity" /d "0" /f
```
Upon further reading - https://learn.microsoft.com/en-us/windows/security/hardware-security/enable-virtualization-based-protection-of-code-integrity there are two ways to enable/disable this, without efi (locked), the command done above and this method bellow ...  - Bah read more here.... 
```console
::reg add "HKLM\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity" /v "Locked" /t REG_DWORD /d "0" /f 
``
This will enable "fastboot/Hiberboot" if so desired:
```console
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v "HiberbootEnabled" /t REG_DWORD /d "1" /f
```

This should solve TinyWall blockage: 

```console
:: clean up firewall rules
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\FirewallRules" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\FirewallRules" /f
```


Solutions moved because of formatting issues, I will actually have to read about .md formatting...
		

Tested on Windows 10 and Windows 11. Some applications are x86 only, arm could easily be added but I wont bother for now.

## Hardening

Maybe list some¿ Read the harden-* files? Read the scripts? 

* [exploitguard](https://github.com/palantir/exploitguard/) - Added 
* [Windows-Defender-Exploit-Guard-Configuration](https://github.com/gunnarhaslinger/Windows-Defender-Exploit-Guard-Configuration) - Runs AltanOS/wdegc/Windows10_ExploitGuard-Config.ps1

Good reading: 
* https://blog.palantir.com/assessing-the-effectiveness-of-a-new-security-data-source-windows-defender-exploit-guard-860b69db2ad2?gi=e48021ca0dde

## The following files can run standalone if needed:
* harden-AltanOS.cmd
* harden.ps1
* harden.reg 				- ofc 
* pkgs-prep.ps1
* pref-cnt.ps1
* schedule-tasks.ps1        - Not yet working.
* wsl-2-debian.ps1			- Not at all asked even if to be executed yet.
* mouse-config.ps1 			- There is just one item that is enabled atm. 

## The following packages are installed:
* VCLibs
* NET.CoreRuntime
* NET.Native
* NET.Native.Runtime
* NET.Native.Framework.1.7
* UI.Xaml* 
* PackageManagement.NuGetProvider
* PSWindowsUpdate
* UI.Xaml.2.7*
* UI.Xaml.2.8* 
* WindowsStore
* StorePurchaseApp
* ##MicrosoftOfficeHub
* WindowsCalculator
* MSPaint
* MicrosoftSolitaireCollection
* Windows Terminal

## The folloiwng programs are grabbed by 'WinGet'
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
* Microsoft.VisualStudioCode
* VSCodium.VSCodium
* Oracle.JDK.17 
* Python.Python.3.12 
* Rizin.Cutter
* WinMgerge.WinMerge
* KDE.KDiff3
* Meld
* Cygwin

## Dev tools
* Cygwin
* Ghidra
* Cutter
* Radare2
* Malcat 
* Rizin
* Meld - Eventully get the far superior GTK2.x version
* KDiff3
* WinMerge - Where is WinMerge2011
* VSCodium
* VisualStudioCode
* MiniGW

## It will schedule tasks to be autorun - N.B! Not yet working, scheduling script is bonkers: 
* autorun-update.ps1                - Runs PSWindowsUpdate every thuesday at 17pm
* autorun-maintain.ps1              - Runs sfc /scannow and DISM /Online /Cleanup-Image /StartComponentCleanup /ResetBase /RestoreHealth every 3 weeks at 18pm  
* autorun-privazer.ps1              - Runs PrivaZer to delete residue in the NTFS journal, and write ZERO to the free disk space as well as remove temporary files everywhere. Every 3 weeks Wedensday at 17pm
* autorun-awdcleaner.ps1            - Runs AwdClenaer every Wedensday at 16pm.

autorun-maintain.ps1 will (once i fix this....) also be run upon login, once, after a reboot(!!!).

## Conveience 

Adeed:
* Finally got around to adding "Open PowerShell/cmd in current directory".
* https://github.com/gunnarhaslinger/Add-or-Remove-Application-To-Windows-10-Taskbar - Not yet tested

## Look and feel: 

* Mouse is set to (hopefully) jump to a prompt and land on the default answer, this saves time.
* Revert8Plus (turns windows 10/11 into Windows7) install script is added but not initialized.
* Black theme enabled in harden.reg. - Might bother to split this - there migt be a bug here leading to black text on dark windows, before first reboot?

In harden.reg (- ofc.. where else would you logically put the taskbar colour settings?)
The following settings live there, that are turned off because they are untested.

```console
; https://superuser.com/questions/952500/custom-color-for-windows-10-taskbar
; This is supposed to be a Cyan taskbar - this is something to mess around with eventually
; [HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\DWM]
; "Composition"=dword:00000001
; "AccentColor"=dword:00c3b700
; "ColorPrevalence"=dword:00000001
; "ColorizationGlassAttribute"=dword:00000000
; "ColorizationColor"=dword:c400b7c3
; "ColorizationColorBalance"=dword:00000059
; "ColorizationAfterglow"=dword:c400b7c3
; "ColorizationAfterglowBalance"=dword:0000000a
; "ColorizationBlurBalance"=dword:00000001
; "EnableWindowColorization"=dword:0000000
```

# TODID:
* Move scripts to own folder, it's getting messy. - done
* Bother to ask when to schedule thing.
* Ask to either install MalwareBytes or run to AwdCleaner sometimes? - Just schedule AwdCleaner to run anyway.
* Add AwdCleaner and scan quickly before proceeding. - Added, but not set any arguments and requires user interaction.
* Ask if you wish to install LibreOffice or Microsoft Office, VSCodium or VisualStudioCode
* Dig around for more hardening or other things that make sense.
* Better Readme and explenation, 2 days now i've layed down in bed to sleep then having a great idea what to write, then not when i wake up... - Done?
* Try to preconfigure Sandboxie. -Naaah

v 0.0.1 - ish

* Fix the sheduled task and create one for sfc and dism every... two, maybe three weeks? - Not fixed...
* Move AltanOS* to somewhere predictable. - Fixed
* More testing. - Ongoing - Still.. ... Still...
* Add a script to run once at first startup to resolve an iusse where we are already in need to reboot. - Maybe fixed
* Try to stop loosing work when hibernating linux and not properly shutting down windows (holding left ctrl while selecting power off), linux isnt grabbing the new journal state of the NTFS drive file states after resuming from hibernation, this results in data loss and corruption if you then proceed ot unmount the volume in linux, a chkdsk from windows _can_ fix this, or a hard reset of linux if you've got nothing to loose....   - I almost lost all this again instead ...

v 0.0.0
