# psexec -i 1 -s -priority -realtime 

SCHTASKS /Create /RU "", "NT AUTHORITY\SYSTEM" /SC ONLOGON /Z /TN cleanup_besure "powershell -command -NoProfile -ExecutionPolicy Bypass -File  %SystemDrive%\AltanOS\ "

SCHTASKS /Create /RU "", "NT AUTHORITY\SYSTEM" /SC ONLOGON /TN autorun-update /TR "powershell -command -NoProfile -ExecutionPolicy Bypass -File  %SystemDrive%\AltanOS\src\autorun-update.ps1"

SCHTASKS /Create /RU "", "NT AUTHORITY\SYSTEM" /SC WEEKLY /D WED /TN autorun-awdcleaner /TR "powershell -command -NoProfile -ExecutionPolicy Bypass -File %SystemDrive%\AltanOS\src\autorun-adwcleaner.ps1"
SCHTASKS /Create /RU "", "NT AUTHORITY\SYSTEM" /SC WEEKLY /D WED /TN autorun-maintain /TR "powershell -command -NoProfile -ExecutionPolicy Bypass -File %SystemDrive%\AltanOS\src\autorun-maintain.ps1"
SCHTASKS /Create /RU "", "NT AUTHORITY\SYSTEM" /SC WEEKLY /D THU /TN autorun-update /TR "powershell -command "start-process "powershell -Wait -Verb RunAS" -NoProfile -ExecutionPolicy Bypass -File %SystemDrive%\AltanOS\src\autorun-update.ps1"

SCHTASKS /Create /RU "", "NT AUTHORITY\SYSTEM" /SC MONTHLY /TN autorun-privazer /TR "powershell -NoProfile -ExecutionPolicy Bypass -File %SystemDrive%\AltanOS\src\autorun-privazer.ps1"