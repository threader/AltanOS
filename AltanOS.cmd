@echo on
set "altanosdir=%cd%"
set "powshcmd=PowerShell -command"
set "usedir=%HOMEDRIVE%\AltanOS.inst"
set "bitsadminget=bitsadmin /transfer /Download /priority HIGH"
set "webgetps=%powshcmd% Invoke-WebRequest -uri "%geturl%" -OutFile %geturlout% -v"
set "admuser=%usedir%\bin\Nsudo\%nsarchbit%\NSudoLC.exe -UseCurrentConsole -Priority:AboveNormal -M:S -U:S -P:E --wait"

set "powshadmcmd=%powshcmd% "start-process "powershell -Verb RunAS""
 :: [Environment]::CurrentDirectory = $ExecutionContext.SessionState.Path.CurrentFileSystemLocation.ProviderPath
if exist %usedir% goto skipusedir
 mkdir %usedir%
:skipusedir

%powshcmd% 'cp -r %altanosdir% %HOMEDRIVE%\AltanOS'

IF "%PROCESSOR_ARCHITECTURE%"=="AMD64" (set nsarchbit=x64
) ELSE (set nsarchbit=Win32)

:: set "uacadmuser=%usedir%\bin\Nsudo\%nsarchbit%\NSudoLG.exe -Priority:AboveNormal -M:S -U:S -P:E --wait"

:: Flagged bt Defender
if exist %usedir%\bin\Nsudo\%nsarchbit%\NSudoLG.exe goto skipnsudo
:: %bitsadminget% https://dotnet.microsoft.com/download/dotnet/scripts/v1/dotnet-install.ps1 %usedir%\dotnet-install.ps1
:: %bitsadminget% https://github.com/M2TeamArchived/NSudo/releases/download/9.0-Preview1/NSudo_9.0_Preview1_9.0.2676.0.zip %usedir%\Nsudo.zip 
:: %powshcmd% "Invoke-WebRequest -uri https://github.com/M2TeamArchived/NSudo/releases/download/9.0-Preview1/NSudo_9.0_Preview1_9.0.2676.0.zip -OutFile %usedir%\Nsudo.zip"
:: %powshcmd% "Expand-Archive -Force '%usedir%\Nsudo.zip' '%usedir%\bin\Nsudo'"
:skipnsudo
 
 %powshadmcmd% '%powshcmd% "Set-ExecutionPolicy -ExecutionPolicy Bypass"'
 %powshadmcmd% %altanosdir%\pkgs-prep.ps1
 %powshadmcmd% %altanosdir%\harden-AltanOS.cmd
%powshadmcmd% reg load %altanosdir%\harden.reg
 %powshadmcmd% %altanosdir%\schedule-tasks.ps1
:: %uacadmuser% %powshcmd% "New-ItemProperty -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Run" -Name "Update Windows and Applications" -Value "%altanosdir%\autorun-update.cmd"  -PropertyType "String""
 %powshadmcmd% '%powshcmd% "Set-ExecutionPolicy -ExecutionPolicy Restricted"'
 
 
:: powershell Start-process powershell -Verb RunAS %cd%\dotnet-install.ps1
:: %admuser% dotnet add package Microsoft.UI.Xaml 


pause

