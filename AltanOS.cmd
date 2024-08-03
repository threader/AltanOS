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

 %uacadmuser% %powshcmd% 'cp -r %altanosdir% %HOMEDRIVE%\AltanOS̈́'
 %uacadmuser% %powshcmd% 'cp -r %altanosinstdir% %HOMEDRIVE%\AltanOS̈́.inst'
 
 %uacadmuser% %powshcmd% Set-ExecutionPolicy -ExecutionPolicy Bypass
 %uacadmuser% %powshcmd% -File %altanosdir%\pkgs-prep.ps1
 %uacadmuser% %altanosdir%\harden-AltanOS.cmd
%uacadmuser% reg load %altanosdir%\harden.reg
 %uacadmuser% %powshcmd% -File %altanosdir%\schedule-tasks.ps1
:: %uacadmuser% %powshcmd% "New-ItemProperty -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Run" -Name "Update Windows and Applications" -Value "%altanosdir%\autorun-update.cmd"  -PropertyType "String""
 %uacadmuser% %powshcmd% Set-ExecutionPolicy -ExecutionPolicy Restricted
 
 
:: powershell Start-process powershell -Verb RunAS %cd%\dotnet-install.ps1
:: %admuser% dotnet add package Microsoft.UI.Xaml 


pause

