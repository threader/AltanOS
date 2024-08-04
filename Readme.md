# AltanOS - started it's life as a deviation from PC-Tuning and Atlas by 'amitvxv' and co.

This project is undergoing change, testing and has not settled. It might not run as expected, experience adviced. 

The goal of this project is to optimize/minimize and harden Windows systems, making the deployed system more maintainable with tools like winget and UniGetUI and the 3rd party module 'PSWindowsUpdate'.

Run AltanOS.cmd from It's parent directory and the rest happens with little interaction. There are some pauses for input and information text, uninstalling Edge needs a mouse button click, 'PSWindowsUpdate' also require NuGet that requires confirmation.
It will copy itself to the system partition equivlent to C:\AltanOS and C:\AltanOS.inst
Mind the TinyWall firewall - select 'Autolearn' if you have problems and use the 'Manage' dialog to tune the selection. Hopefully a more elegant solution cand be found like importing the .tws file in AltanOS\bin
N.B: Uninstalling TinyWall while configured to block an application or default settings will lead to connection blocking even after uninstall!

Tested on Windows 10 and Windows 11.

A bit of topology.

The following files can run standalone if needed:
harden-AltanOS.cmd
harden.reg 				- ofc 
pkgs-prep.ps1
schedule-tasks.ps1

TODO:
* Dig around for more hardening or other things that make sense.
* Better Readme and explenation, 2 days now i've layed down in bed to sleep then having a great idea what to write, then not when i wake up...
* Try to preconfigure Sandboxie.
v 0.0.1 - ish
* Fix the sheduled task and create one for sfc and dism every... two, maybe three weeks? - Maybe fixed
* Move AltanOS* to somewhere predictable. - Fixed
* More testing. - Ongoing 
* Add a script to run once at first startup to resolve an iusse where we are already in need to reboot. - Maybe fixed
* Try to stop loosing work due to inconsistent behavior when hibernating linux and not properly shutting down windows (holding left ctrl while selecting power off), linux isnt grabbing the new journal state of the NTFS drive file states after resuming from hibernation, this results in data loss and corruption if you then proceed ot unmount the volume in linux, a chkdsk from windows _can_ fix this, or a hard reset of linux if you've got nothing to loose.... - I almost lost all this again instead ...
v 0.0.0
