# AltanOS - started it's life as a deviation from PC-Tuning and Atlas by 'amitvxv' and co.

This project is undergoing change, testing and has not settled. It might not run as expected, experience adviced. 

The goal of this project is to optimize/minimize and harden Windows systems, making the deployed system more maintainable with tools like winget and UniGetUI and the 3rd party module 'PSWindowsUpdate'.

Run AltanOS.cmd and the rest should happen with little interaction. Just be sure to run it from it's parent directory. It will copy itself to C:\AltanOS and C:\AltanOS.inst
Mind the TinyWall firewall - select 'Autolearn' if you have problems and use the 'Manage' dialog to tune the selection. Hopefully a more elegant solution cand be found like importing the .tws file in AltanOS\bin
N.B: Uninstalling TinyWall while configured to block an application or default settings will lead to connection blocking even after uninstall!

Tested on Windows 10 and Windows 11. 

TODO:
* Fix the sheduled task and create one for sfc and dism every... two, maybe three weeks? - Maybe fixed
* Move AltanOS* to somewhere predictable. - Maybe fixed
* More testing.
* Add a script to run once at first startup to resolve an iusse where we are already in need to reboot. - Maybe fixed
* Try to stop loosing work due to inconsistent behavior when hibernating linux and not properly shutting down windows, linux isnt grabbing the state of the NTFS drive file states after resuming from hibernation.... - I almost lost all this again instead ...
