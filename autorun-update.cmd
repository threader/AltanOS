%usedir%="%HOMEDRIVE%%HOMEPATH%\Desktop\AltanOS"

%uacadmuser% %powshcmd% Set-ExecutionPolicy -ExecutionPolicy Bypass

powershell Start-process powershell -Verb RunAS %usedir%/winupdate.ps1

%uacadmuser% %powshcmd% Set-ExecutionPolicy -ExecutionPolicy Restricted
