@echo on
set "altanosdir=%cd%"
set "powshcmd=PowerShell -command"
set "usedir=%HOMEDRIVE%\AltanOS.inst"
set "bitsadminget=bitsadmin /transfer /Download /priority HIGH"
set "webgetps=%powshcmd% Invoke-WebRequest -uri "%geturl%" -OutFile %geturlout% -v"
set "powshadmcmd=%powshcmd% "start-process "powershell -Wait -Verb RunAS""
set "msipkg=msiexec.exe /quiet /norestart /passive /package"
set "gitget=%ProgramFiles%\Git\bin\git.exe"
 :: [Environment]::CurrentDirectory = $ExecutionContext.SessionState.Path.CurrentFileSystemLocation.ProviderPath

if exist %usedir% goto skipusedir
 mkdir %usedir%
 mkdir "%usedir%"\bin
:skipusedir

if exist %altanosdir% goto skipaltanosdir
%powshcmd% 'cp -r %altanosdir% %HOMEDRIVE%\AltanOS'
:skipaltanosdir

:: set variables
IF "%PROCESSOR_ARCHITECTURE%"=="AMD64" (set niarchbit=-64)
IF "%PROCESSOR_ARCHITECTURE%"=="AMD64" (set nsarchbit=x64
) ELSE (set nsarchbit=Win32)

:: Not needed.
:: set "uacadmuser=%usedir%\bin\Nsudo\%nsarchbit%\NSudoLG.exe -Priority:AboveNormal -M:S -U:S -P:E --wait"

:: and so i read and learn that it could indeed have been done using something like this: 
:: %powshcmd% -Argument "-NoProfile -ExecutionPolicy Bypass"  ^
::    $userprofiles = @('C:\Users\');  ^
::   ForEach ($user in $userprofiles) {  ^
::      Set-Location -Path $user;  ^
::      Get-ChildItem -Filter '*.log~' ^| Where-Object { $_.Attributes -band [System.IO.FileAttributes]::Archive }  ^
::   };

:: NSudo Flagged by Defender, dotnet install script as user install noted.
:: if exist %usedir%\bin\Nsudo\%nsarchbit%\.. goto skipnsudo
:: %bitsadminget% https://dotnet.microsoft.com/download/dotnet/scripts/v1/dotnet-install.ps1 %usedir%\dotnet-install.ps1
:: %bitsadminget% https://github.com/... %usedir%\... 
:: %powshcmd% "Invoke-WebRequest -uri https://github.com/... -OutFile %usedir%\..."
:: %powshcmd% "Expand-Archive -Force '%usedir%\...' '%usedir%\bin\..."
:skipnsudo

:: %SystemRoot%\System32\choice.exe /C YNC /M "Press Y for Yes, N for No or C for Cancel."
setlocal EnableExtensions DisableDelayedExpansion
:: echo This is an example for prompting a user. - Thank you stack overflow, since this is the upteenth time i write this script and loose it i'm all out of patience.
echo(
if exist "%SystemRoot%\System32\choice.exe" goto UseChoice

setlocal EnableExtensions EnableDelayedExpansion
:UseSetPrompt
set "UserChoice="
set /P "UserChoice=Are you sure [Y/N]? "
set "UserChoice=!UserChoice: =!"
if /I "!UserChoice!" == "N" endlocal & exit /B
if /I not "!UserChoice!" == "Y" goto UseSetPrompt
endlocal
goto Continue

:UseChoice
%SystemRoot%\System32\choice.exe /C YN /N /M "This will remove all removable Windows packages on the system, for all users.. Are you sure you know what you are doing?  [Y/N]?"
if not errorlevel 1 goto UseChoice
if errorlevel 2 exit /B

:Continue
echo So you are sure. Okay, let's go ...

if exist %usedir%\network-indicator%niarchbit%.zip goto skipdl
:: %bitsadminget% https://github.com/PowerShell/PowerShell/releases/download/v7.3.2/PowerShell-7.3.2-win-x64.msi %usedir%\PowerShell-7.3.2-win-x64.msi 

:: %powshcmd% "Invoke-WebRequest -uri https://adwcleaner.malwarebytes.com/adwcleaner?channel=release -OutFile %usedir%\adwcleaner.exe"
 %powshcmd% "Invoke-WebRequest -uri https://downloads.malwarebytes.com/file/adwcleaner -OutFile %usedir%\bin\adwcleaner.exe"
 %usedir%\bin\adwcleaner.exe
 
 %powshcmd% "Invoke-WebRequest -uri https://tinywall.pados.hu/files/TinyWall-v3-Installer.msi -OutFile %usedir%\TinyWall-v3-Installer.msi" 
# %bitsadminget% https://tinywall.pados.hu/files/TinyWall-v3-Installer.msi %usedir%\TinyWall-v3-Installer.msi 

 %powshcmd% "Invoke-WebRequest -uri https://privazer.com/en/PrivaZer.exe -OutFile %usedir%\bin\PrivaZer.exe"
# %bitsadminget% https://privazer.com/en/PrivaZer.exe %usedir%\bin\PrivaZer.exe

 %powshcmd% "Invoke-WebRequest -uri http://www.itsamples.com/downloads/network-activity-indicator-setup%niarchbit%.zip -OutFile %usedir%\network-indicator%niarchbit%.zip"
# %bitsadminget% http://www.itsamples.com/downloads/network-activity-indicator-setup%niarchbit%.zip %usedir%\network-indicator%niarchbit%.zip
 %powshcmd% "Expand-Archive -Force '%usedir%\network-indicator%niarchbit%.zip' '%usedir%\bin\network-indicator%niarchbit%'"

:skipdl

:: The following operations can under some circumstances take a hellova lot of thime, i'm not really sure if this really is ideal.
 %powshadmcmd% '%powshcmd% "Set-ItemProperty -Path REGISTRY::HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System -Name ConsentPromptBehaviorAdmin -Value 0"'
 
 %powshadmcmd% '%powshcmd% "Set-ExecutionPolicy -ExecutionPolicy Bypass"'
 Echo There will be packages that fail to remove here because they are core components, some red text to follow.
 pause
 %powshadmcmd% %altanosdir%\pkgs-prep.ps1
 
echo git clone the latest AltanOS
 %gitget% clone -b main https://github.com/threader/AltanOS "%altanosdir%"
 
 %powshadmcmd% %altanosdir%\harden-AltanOS.cmd
 %powshadmcmd% reg load %altanosdir%\harden.reg
 %powshadmcmd% %altanosdir%\schedule-tasks.ps1
:: %uacadmuser% %powshcmd% "New-ItemProperty -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Run" -Name "Update Windows and Applications" -Value "%altanosdir%\autorun-update.cmd"  -PropertyType "String""




:: Ask to install - Tinywall, Network activity indicator, (auto)/run PrivaZer, with config?.

:: echo Remember to configure the TinyWall firewall, select autolearn from the menu for a while for instance to allo traffic
:: %msipkg% %usedir%\TinyWall-v3-Installer.msi

:: "%usedir%\bin\network-indicator%niarchbit%"\NetworkIndicatorSetup.exe

 %powshadmcmd% '%powshcmd% "Set-ExecutionPolicy -ExecutionPolicy Restricted"'
 
:: powershell Start-process powershell -Verb RunAS %cd%\dotnet-install.ps1
:: %admuser% dotnet add package Microsoft.UI.Xaml 



:: set the admin password prompt, a value of 1 on here and the admin account will require password to be entered. 2 is a prompt.
 %powshadmcmd% '%powshcmd% "Set-ItemProperty -Path REGISTRY::HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System -Name ConsentPromptBehaviorAdmin -Value 1"'
pause




endlocal
