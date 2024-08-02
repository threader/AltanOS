@echo on
set "altosdir=%cd%"
set "powshcmd=PowerShell -WindowStyle Normal"
set "usedir=%HOMEDRIVE%\AltanOS.inst"
set "bitsadminget=bitsadmin /transfer /Download /priority HIGH"
set "webgetps=%powshcmd% Invoke-WebRequest -uri "%geturl%" -OutFile %geturlout% -v"
set "admuser=%usedir%\bin\Nsudo\%nsarchbit%\NSudoLC.exe -UseCurrentConsole -Priority:AboveNormal -M:S -U:S -P:E --wait"

mkdir %usedir%

IF "%PROCESSOR_ARCHITECTURE%"=="AMD64" (set nsarchbit=x64
) ELSE (set nsarchbit=Win32)

set "uacadmuser=%usedir%\bin\Nsudo\%nsarchbit%\NSudoLG.exe -Priority:AboveNormal -M:S -U:S -P:E --wait"

if exist %usedir%\bin\Nsudo\%nsarchbit%\NSudoLG.exe goto skipnsudo
:: %bitsadminget% https://dotnet.microsoft.com/download/dotnet/scripts/v1/dotnet-install.ps1 %usedir%\dotnet-install.ps1
# %bitsadminget% https://github.com/M2TeamArchived/NSudo/releases/download/9.0-Preview1/NSudo_9.0_Preview1_9.0.2676.0.zip %usedir%\Nsudo.zip 
 %powshcmd% "Invoke-WebRequest -uri https://github.com/M2TeamArchived/NSudo/releases/download/9.0-Preview1/NSudo_9.0_Preview1_9.0.2676.0.zip -OutFile %usedir%\Nsudo.zip"
 %powshcmd% "Expand-Archive -Force '%usedir%\Nsudo.zip' '%usedir%\bin\Nsudo'"
:skipnsudo

 %uacadmuser% %powshcmd% 'mv %altanosdir% %HOMEDRIVE%\AltanOS̈́'

 %uacadmuser% %powshcmd% Set-ExecutionPolicy -ExecutionPolicy Bypass
 %uacadmuser% %powshcmd% -File %cd%\pkgs-prep.ps1
 %uacadmuser% %cd%\harden-AltanOS.cmd
%uacadmuser% reg load %cd%\harden.reg
:: %uacadmuser% %powshcmd% "New-ItemProperty -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Run" -Name "Update Windows and Applications" -Value "%cd%\autorun-update.cmd"  -PropertyType "String""
 %uacadmuser% %powshcmd% Set-ExecutionPolicy -ExecutionPolicy Restricted
 
 
:: powershell Start-process powershell -Verb RunAS %cd%\dotnet-install.ps1
:: %admuser% dotnet add package Microsoft.UI.Xaml 

:: i had a script to do this. Steal this example i guess 
::$taskTriggers = @(
:: Any better suggestions for -At? - Ask?
::New-ScheduledTaskTrigger -Weekly -DaysOfWeek Thuesday -At 17pm 
::New-ScheduledTaskTrigger -AtLogon
::)
:: The following will probably not work and include cd% in the path instead of the actual path
::$taskAction = New-ScheduledTaskAction -Execute "PowerShell" -Argument "-NoProfile -ExecutionPolicy Bypass -File '%cd%\autorun-update.cmd' -Output 'HTML'" -WorkingDirectory 'cd%\AltanOS'
:: Register-ScheduledTask 'Update Windows and Applications' -TaskPath 'AltanOS' -Action $taskAction -Trigger $taskTrigger
:: Get-ScheduledTask -TaskPath \AltanOS\

:: Aaha, so thats where i put that
:: Add to startup
:: New-ItemProperty -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Run" -Name "Update Windows and Applications" -Value "%HOMEDRIVE%\AltanOS\autorun-update.cmd"  -PropertyType "String"

pause

