# AltanOS - started as a middle ground project between PC-Tuning and Atlas by 'amitvxv' and co.

Windows Defender flagged some of the files in PC-Tuning as PUP, so moving this to a new project. 

The goal of this project is to optimize/minimize and harden Windows systems, making the deployed system more maintainable with tools like winget and the 3rd party module 'PSWindowsUpdate'.

Run AltanOS.cmd and the rest should happen with little interaction.
Mind the TinyWall firewall - select 'Autolearn' if you have problems and use the 'Manage' dialog to tune the selection. Hopefully a more elegant solution cand be found like importing the .tws file in AltanOS\bin

Currently works on Windows 10 and should on Windows 11. 

TODO: 
* Test more and find vcredist in winget, changing source to MSStore
* Move AltanOS.inst somewhere out of the way like Documents or something.
