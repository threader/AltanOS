## AltanOS - started it's life as an overdue todo item of severe necessity, randomly being inspired to persue after stumbling over and reading trough the scripts of PC-Tuning and Atlas by 'amitvxv' and co. JIT for me to be re-installing a Windows having a handfull of recrent tricks worth looking into.

This project is _undergoing change_, (_not much_) testing and _has not settled_. It _might not run as expected_, _experience_ adviced, so is a _fresh install/Windows image_. Be prepared to step trough the script with PowerShell ISE. _This will remove all non essential Windows core packages for all users on the system._ And I _warn_ on a Win 11 Home I was looking this winter going trough and otherwise picking out bits of hardening i wanted for that system, [somehow(?)](https://github.com/threader/AltanOS/blob/main/src/harden-AltanOS.cmd#L100) the password and pin for the user/machine did not work after, this was a Microsoft account connected device where the only way to log back on and change tha pin and passwords were the online login... Needless to say I will be stuffing in two local users, one $USER-adm and one $USER-user in my next gesture to sanity and logic.

One goal of this project is to optimize/minimize and harden Windows systems, making the deployed system more maintainable with tools like WinGet, UniGetUI and the 3rd party module 'PSWindowsUpdate'. Especially importent on Win 10 as the Windows Update feature there is...well, more of a random occurance?

I might end up creating some recovery env. where a prepared and exported a .wim as the result running this script that may be booted as say by GRUB4DOS or so. 

A forced update to this repository is planned in the near future to keep the weight minimal. * Done?

I've noticed the script expects an input somewhere, either a 'Y' or 'Enter' and appears to stop, i've put pauses at some points to review the output, (some) logs should end up in %systemdrive%\Altanos.inst\logs . 

A checkdisk is forced triggerd at the end of this script, allocate a lot of time for this check to complete after a reboot that ought be immediate. 
End of warnings?
---
Run AltanOS.cmd from It's parent directory and the rest happens with some interaction. There are some pauses for input and information text, and even an unexpected pause where i think the correct thing is to press Y or ENTER, uninstalling Edge needs a mouse button click, 'PSWindowsUpdate' also require NuGet that requires confirmation. And some WinGet packages absolutley require you to press 'Y' or a swallow randomly implodes outside.

This project will copy itself to the system partition equivlent to C:\AltanOS and store downloadeds in C:\AltanOS.inst

- Important notes:
	* Remember to grab the submodules. 
	```console
	:: After first git clone: 
	git submodule update --init --recursive 
	:: pull latest submodules changes:
	git submodule update --recursive
	```
	
	* Fastboot/Hiberboot is disabled, so Windows will properly shut down, unmount disks, unlock the NTFS journal.

	* !Not handled or automatically installed yet! - Mind the TinyWall firewall - select 'Autolearn' if you have problems and use the 'Manage' dialog to tune the selection. Hopefully a more elegant solution cand be found like importing the .tws file in AltanOS\bin 
	
	* N.B: Some basic Firewall rules are applied by the 'windows-hardening-scripts'.

	* N.B: Uninstalling TinyWall while configured to block an application or default settings will lead to connection blocking even after uninstall!

	* N.B: Malwarebytes and Spybot AntiBeacon. AntiBeacon modifies the host file and Malwarebytes believes this is host file hijacking.

	* N.B: The Intel HD 3000 driver will fail to load the kernel mode driver, 'Core isolation\Memory integrity' will have to be disabled on these systems.

- On the pluss side I found a patched driver to allow OpenGL3.1 and a trick with using Mesa 20.2.0 that should allow OpenGL 3.3 on these devices

	* https://gist.github.com/rb-dahlb/26f316c5b6089807a139fc44ee69f0d1

	* https://www.intel.com/content/www/us/en/support/articles/000091878/graphics.html#:~:text=Download%20Display%20Driver%20Uninstaller%20(DDU,in%20safe%20mode%20in%20Windows.)

	* https://www.reddit.com/r/lowendgaming/comments/1258usx/updated_win1011_drivers_for_intel_hd_3000/

- If it is the case that old drivers are missbehaving - Run and reboot:

	```console
	reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DeviceGuard" /t REG_DWORD /v "HypervisorEnforcedCodeIntegrity" /d "0" /f
	reg add "HKLM\SYSTEM\CurrentControlSet\Control\DeviceGuard" /v "EnableVirtualizationBasedSecurity" /t REG_DWORD /d 0/f
	```

	* Upon further reading - https://learn.microsoft.com/en-us/windows/security/hardware-security/enable-virtualization-based-protection-of-code-integrity there are two ways to enable/disable this, without efi (locked), the command done above and this method bellow ...  - Bah read more here.... 
	```console
	reg add "HKLM\SYSTEM\CurrentControlSet\Control\DeviceGuard" /v "EnableVirtualizationBasedSecurity" /t REG_DWORD /d 0 /f
	reg add "HKLM\SYSTEM\CurrentControlSet\Control\DeviceGuard" /v "RequirePlatformSecurityFeatures" /t REG_DWORD /d 0 /f
	reg add "HKLM\SYSTEM\CurrentControlSet\Control\DeviceGuard" /v "Locked" /t REG_DWORD /d 0 /f
	reg add "HKLM\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity" /v "Enabled" /t REG_DWORD /d 0 /f
	reg add "HKLM\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity" /v "Locked" /t REG_DWORD /d 0 /f
	```

- This will enable "fastboot/Hiberboot" if so desired:

	```console
	reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v "HiberbootEnabled" /t REG_DWORD /d "1" /f
	```

- This should solve TinyWall blockage: 

	```console
	:: clean up firewall rules
	reg delete "HKLM\SYSTEM\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\FirewallRules" /f
	reg add "HKLM\SYSTEM\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\FirewallRules" /f
	```


Solutions moved because of formatting issues, I will actually have to read about .md formatting...
		

Tested on Windows 10 and Windows 11. Some applications are x86 only, arm could easily be added but I wont bother for now.

## Hardening

Too many to list, read the harden-* files? Read all the scripts? 

There is room for improvement and granular tuning of the set process mitigations:
I have been evaluating and running this:
```console
Set-ProcessMitigation -System -Enable DEP, EmulateAtlThunks, RequireInfo, BottomUp, HighEntropy, StrictHandle, SuppressExports, SEHOP, AuditSEHOP, SEHOPTelemetry, AuditMicrosoftSigned, AuditStoreSigned, EnforceModuleDependencySigning, DisableNonSystemFonts, AuditFont
```

However, in a test against a Win 11 Pro that was to be set up as a gaming rig, everything anti cheat kernel mode failed. I ended up with something like: 
```console
Set-ProcessMitigation -System -Enable DEP, EmulateAtlThunks, RequireInfo, BottomUp, HighEntropy, SEHOP, DisableNonSystemFonts
```

There are certainly other options that could be enabled.
- https://learn.microsoft.com/en-us/defender-endpoint/enable-exploit-protection 
- https://learn.microsoft.com/en-us/powershell/module/processmitigations/set-processmitigation?view=windowsserver2022-ps


The following projects are included in one form or another:
* [exploitguard](https://github.com/palantir/exploitguard/) - Added to AltanOS/src/harden.ps1 
* [Modified: Windows-Defender-Exploit-Guard-Configuration](https://github.com/threader/Windows-Defender-Exploit-Guard-Configuration) - Runs AltanOS/wdegc/Enable-ExploitGuard-AttackSurfaceReduction.ps1 originally by [Gunnar Haslinger](https://github.com/gunnarhaslinger/).
* [Modified: windows-hardening-scripts](https://github.com/threader/windows-hardening-scripts) by [atlantsecurity](https://github.com/atlantsecurity/windows-hardening-scripts) and [zer0lightning](https://github.com/zer0lightning/windows-hardening-scripts).
* [Modified: EnableWindowsLogSettings](https://github.com/threader/EnableWindowsLogSettings) by [Yamato-Security](https://github.com/Yamato-Security/EnableWindowsLogSettings) - Increases log sizes substantially (1GBx4, so mind the windows\logs directory) to better detection of unwanted events .
* [Modified: Sysmon-config](https://github.com/threader/sysmon-config) maintained by [THEVER1TAS](https://github.com/THEVER1TAS/sysmon-config) - Sysmon configration to detect and block malicious and vulnerable drivers, binaries and events.

Disabled - well, strip_windows.ps1 now verbatim disables everything, but essentially: 
 * SMB1
 * RemoteDesktopConnection
 * WorkFolders
 * Internetprinting
 * MSRDC
 * VBSCRIPT

On Windows 10 and 11 _pro_ and above enabled: 
 * [Containers-DisposableClientVM](https://learn.microsoft.com/en-us/windows/security/application-security/application-isolation/windows-sandbox/windows-sandbox-overview)
	See the config file commented out in harden.ps1 . # VM_Config.wsb :
	
Good reading: 
* https://blog.palantir.com/assessing-the-effectiveness-of-a-new-security-data-source-windows-defender-exploit-guard-860b69db2ad2?gi=e48021ca0dde

## The following files can run standalone if needed:
* harden-AltanOS.cmd										- Now runs script in submodules so it can't _really_ be said to run standalone anymore.
* harden.ps1
* harden.reg								 				- ofc
* mouse-config.ps1								 			- There is just one item that is enabled atm, jump to default button.  
* pkgs-prep.ps1												- pkgs: 
* pref-cnt.ps1												- Reset preformance counters. (Might be a good idea if initially installed via VM?)
* schedule-tasks.ps1								        		- Not yet working.
* strip_windows.ps1											- Strips all and everything , still needs some testing as i cobbled this together being quite tired and at a time while i needed to give _it a rest_.
* wsl-2-debian.ps1											- Not executed yet.
* wdegc\Enable-ExploitGuard-AttackSurfaceReduction.ps1							- Modified: script by Gunnar Haslinger to handle the [attack surface reduction rules](https://learn.microsoft.com/en-us/defender-endpoint/attack-surface-reduction-rules-reference).
* whs\windows-hardening-script.cmd									- Modified: script by 'atlantsecurity' with work by 'zer0lightning' - https://github.com/atlantsecurity/windows-hardening-scripts 
* ewls\YamatoSecurityConfigureWinEventLogs.bat								- Modified: Script by [Yamato-Security](https://github.com/Yamato-Security/EnableWindowsLogSettings)
* sysmon.exe -i -accepteula sysmon-config\sysmonconfig-export-block-loldrivers.xml			- Modified: XML by [THEVER1TAS](https://github.com/THEVER1TAS/sysmon-config) - 

## The following packages are left installed: - _this is an incomplete list_, see strip_windows.ps1 and doc\w11pro.nonremovable.def.txt as it ought\must have additions for _at least_ AMD stuff ( On a side note(quest) anyone want to see what happens if you run strip_windows.ps1 in reverse install and enable all windows features? :D)
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
* #MicrosoftOfficeHub - To be made optional and not installed. 
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
* Microsoft.Sysinternals.SysMon
* Microsoft.PowerToys - https://learn.microsoft.com/en-us/windows/powertoys/
* #Microsoft.Powershell
* #Google.Chrome
* Chromium 
* Mozilla.Firefox
* 7zip.7zip
* VideoLAN.VLC
* GIMP.GIMPlicense
* TheDocumentFoundation.LibreOffice
* Piriform.Recuva
* Piriform.Defraggler
* Nlitesoft.NTLite
* Malwarebytes.Malwarebytes
* SaferNetworking.SpybotAntiBeacon
* #Microsoft.VisualStudioCode - This is to be made optional and not installed. 
* VSCodium.VSCodium - Refuses to install without accepting the license, so this fails to automatically install.
* Oracle.JDK.17 
* Python.Python.3.12 
* Rizin.Cutter
* WinMgerge.WinMerge
* KDE.KDiff3
* Meld
* Cygwin

To be made optional:
* VCMI - Heroes 3 launcher.
* XMoto
* nGlide - Voodoo 3dfx wrappers. tbd.
* DOSBox
* A small collection of old strategy games.

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
* MiniGW

## It will schedule tasks to be autorun - N.B! Not yet working, scheduling script is bonkers: 
* autorun-update.ps1			- Runs PSWindowsUpdate every thuesday at 17pm
* autorun-maintain.ps1			- Runs DISM /Online /Cleanup-Image /StartComponentCleanup /ResetBase /RestoreHealth and sfc /scannow every 3 weeks at 18pm  
* autorun-privazer.ps1			- Runs PrivaZer to delete residue in the NTFS journal, and write ZERO to the free disk space as well as remove temporary files everywhere. Every 3 weeks Wedensday at 17pm
* autorun-awdcleaner.ps1		- Runs AwdClenaer every Wedensday at 16pm.
* autorun-sysmon.ps1			- Runs sysmon service config for blocking unwanted events - TBD.

autorun-maintain.ps1 will (once i fix this....) also be run upon login, once, after a reboot(!!!).

## Conveience 

* Removed "Windows Welcome Experience" after update.
* Finally got around to adding "Open PowerShell/cmd in current directory".
* https://github.com/gunnarhaslinger/Add-or-Remove-Application-To-Windows-10-Taskbar - Not yet tested
* Allow BitLocker without a compatible TPM - This will be needed later for things like [Create-BitLocker-Encrypted-VHDX-Virtual-Disk-Containerfile](https://github.com/threader/Create-BitLocker-Encrypted-VHDX-Virtual-Disk-Containerfile)

## Look and feel: 

* Remove the 'Window snapping' 'feature' on Windows 11 to avoid an aneurisme. 
* Revert to 'Old context menu' on Windows 11, again to avoid an aneurisme.
* Mouse is set to (hopefully) jump to a prompt and land on the default answer, this saves time.
* Revert8Plus (turns windows 10/11 into Windows7) install script is not initialized.
* Black theme enabled in harden.reg. - Must bother to split this soon - there migt be a bug here leading to black text on dark windows, before first reboot?
* Disable widgets\news&interest
* Block new Outlook

Also in harden.reg (- ofc.. where else would you logically put the taskbar colour settings?)
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
* Add logging, eyeballing whats going on here by now is becomming... hard... (its 2025 mike, add logging you twat you have no idea whats going on anymore)
* Absolutley stop using NTFS for GIT stuff, now it screwed some .git/ object and corrupted god knows... 
 - Why the f* is it so hard to properly unmount the f*ing filesystem when I SHUT DOWN!
* Read more on this
 - https://github.com/Ccmexec/PowerShell/blob/master/Customize%20TaskBar%20and%20Start%20Windows%2011/CustomizeTaskbar%20v1.1.ps1
 - https://ccmexec.com/2022/10/customizing-taskbar-and-start-in-windows-11-22h2-with-powershell/
 - most certainly run this with '-StartMoreRecommendations -StartMorePins -RemoveChat -RunForExistingUsers'
* Move scripts to own folder, it's getting messy. - done
* Bother to ask when to schedule thing. ... Must fix now for SysMon service....
* Ask to either install MalwareBytes or run to AwdCleaner sometimes? - Just schedule AwdCleaner to run anyway.
* Add AwdCleaner and scan quickly before proceeding. - Added, but not set any arguments and requires user interaction.
* Ask if you wish to install LibreOffice or Microsoft Office, VSCodium or VisualStudioCode
* Dig around for more hardening or other things that make sense. - Found some really cool things now i think
* Better Readme and explenation, 2 days now i've layed down in bed to sleep then having a great idea what to write, then not when i wake up... - Done?
* Try to preconfigure Sandboxie. -Naaah

v 0.0.1 - ish

* Fix the sheduled task and create one for sfc and dism every... two, maybe three weeks? - Not fixed... 
* Move AltanOS* to somewhere predictable. - Fixed
* More testing. - Ongoing - Still.. ... Still... still... 
* Add a script to run once at first startup to resolve an iusse where we are already in need to reboot. - Maybe fixed
* Try to stop loosing work when hibernating linux and not properly shutting down windows (holding left ctrl while selecting power off), linux isnt grabbing the new journal state of the NTFS drive file states after resuming from hibernation, this results in data loss and corruption if you then proceed ot unmount the volume in linux, a chkdsk from windows _can_ fix this, or a hard reset of linux if you've got nothing to loose....   - I almost lost all this again instead ...

v 0.0.0
