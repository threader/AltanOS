# AltanOS - a middle ground project between PC-Tuning and Atlas by 'amitvxv' and co.
With whatever I can think of that may be of use - this is a re-learning experience having focused on everything but Windows since 1999, and now all proper options are gone from the menues as far as I can see. 

The goal here is to optimize/minimize and harden Windows based systems with currently known tricks and tried and tested tools like winget. With an option to to optimize for real-time tasks eventually, once I properly poke trough the PC-Tuning scripts.
Baiscally I've butchered Atlas so far and added 'winget' instead of providing the binaries, also using I'm using the 3rd party module 'PSWindowsUpdate' which should get added to run on startup, or eventually scheduled as a tasks to run every so often.

Windows Defender flagged some of the files in PC-Tuning as PUP, so moving this to a new project while investigating this. 
Currently works on Windows 10, on Windows 11 failed to install 'winget' but completes all other tasks. 

Simply tun AltanOS.cmd and the rest should happen automagically.

TODO: 
* Test more and find vcredist in winget, changing source to MSStore
* Move AltanOS.inst somewhere safer, as this should not be removed.
