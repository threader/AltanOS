# AltanOS - started it's life as a deviation from PC-Tuning and Atlas by 'amitvxv' and co.

This project is undergoing change, testing and has not settled. It might not run as expected, experience adviced. 

The goal of this project is to optimize/minimize and harden Windows systems, making the deployed system more maintainable with tools like winget and UniGetUI and the 3rd party module 'PSWindowsUpdate'.

Run AltanOS.cmd and the rest happens with little interaction. Just be sure to run it from it's parent directory. It will copy itself to C:\AltanOS and C:\AltanOS.inst
Mind the TinyWall firewall - select 'Autolearn' if you have problems and use the 'Manage' dialog to tune the selection. Hopefully a more elegant solution cand be found like importing the .tws file in AltanOS\bin
N.B: Uninstalling TinyWall while configured to block an application or default settings will lead to connection blocking even after uninstall!

Tested on Windows 10 and Windows 11. 

TODO:
* Fix the sheduled task and create one for sfc and dism every... two, maybe three weeks? - Maybe fixed
* Move AltanOS* to somewhere predictable. - Fixed
* More testing.
* Add a script to run once at first startup to resolve an iusse where we are already in need to reboot. - Maybe fixed
* Try to stop loosing work due to inconsistent behavior when hibernating linux and not properly shutting down windows (holding left ctrl while selecting power off), linux isnt grabbing the new journal state of the NTFS drive file states after resuming from hibernation, this results in data loss and corruption if you then proceed ot unmount the volume in linux, a chkdsk from windows _can_ fix this, or a hard reset of linux if you've got nothing to loose.... - I almost lost all this again instead ...
* Try to preconfigure Sandboxie.
