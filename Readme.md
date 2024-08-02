# AltanOS - started it's life as a deviation from PC-Tuning and Atlas by 'amitvxv' and co.

This project is undergoing change, testing and has not settled. It might not run as expected, experience adviced. 

The goal of this project is to optimize/minimize and harden Windows systems, making the deployed system more maintainable with tools like winget and UniGetUI and the 3rd party module 'PSWindowsUpdate'.

Run AltanOS.cmd and the rest should happen with little interaction.
Mind the TinyWall firewall - select 'Autolearn' if you have problems and use the 'Manage' dialog to tune the selection. Hopefully a more elegant solution cand be found like importing the .tws file in AltanOS\bin
N.B: Uninstalling TinyWall while configured to block an application or default settings will lead to connection blocking even after uninstall!

Tested on Windows 10 and Windows 11. 

TODO:
* Fix the sheduled task and create one for sfc and dism every... two, maybe three weeks?
* Move AltanOS* to somewhere predictable. 
* More testing.
* Add a script to run at startup to resolve an iusse where we are already in need to reboot.
* Try to stop loosing work due to inconsistent behavior when hibernating linux and not properly exiting windows....
