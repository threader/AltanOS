@echo off
set "altosdir=%HOMEDRIVE%\AltanOS"
set "usedir=%HOMEDRIVE%\AltanOS.inst"
set "powshcmd=powershell -WindowStyle Normal"

IF "%PROCESSOR_ARCHITECTURE%"=="AMD64" (set nsarchbit=x64
) ELSE (set nsarchbit=Win32)

set "uacadmuser=%usedir%\bin\Nsudo\%nsarchbit%\NSudoLG.exe -Priority:AboveNormal -M:S -U:S -P:E --wait"

:: %uacadmuser% %powshcmd% "Set-ExecutionPolicy -ExecutionPolicy Bypass"
%uacadmuser% %powshcmd% -File %altosdir%\winupdate.ps1
pause
%uacadmuser% %powshcmd% "Set-ExecutionPolicy -ExecutionPolicy Restricted"
