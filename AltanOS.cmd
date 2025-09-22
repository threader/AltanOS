@echo on
cls
set "altanosdir=%cd%"
set "shcmd="
set "msipkpath="

set "powsh=PowerShell"
set "powshcmd=PowerShell -command"
set "powshadmcmd=%powshcmd% "start-process "%powsh% -Wait -Verb RunAS" %shcmd% ""
:: set "powshadmcmd=%powshcmd% "start-process "powershell -ArgumentList ' ' -Verb RunAS" %shcmd% ""
:: set "cmdshadmcmd=%powshcmd% "start-process "cmd -Wait -Verb RunAS" ""

set "altanosinstdir=%SystemDrive%\AltanOS.inst"
set "bitsadminget=bitsadmin /transfer /Download /priority HIGH"
set "webgetps=%powshcmd% Invoke-WebRequest -uri "%geturl%" -OutFile %geturlout% -v"

set "msipkg=msiexec.exe /a %msipkpath% /quiet /norestart /passive /package"
set "gitget=%ProgramFiles%\Git\bin\git.exe"
 :: [Environment]::CurrentDirectory = $ExecutionContext.SessionState.Path.CurrentFileSystemLocation.ProviderPath

set "altanlog=%altanosinstdir%\logs\"

if exist %altanosinstdir% goto skipaltanosinstdir
 mkdir %altanosinstdir%
 mkdir %altanosinstdir%\bin
 mkdir %altanosinstdir%\logs
:skipaltanosinstdir

if exist %altanosdir% goto skipaltanosdir
:: Will clone git repo anyway 
:: %powshcmd% 'cp -r %altanosdir% %HOMEDRIVE%\AltanOS'
:skipaltanosdir

:: set variables
IF "%PROCESSOR_ARCHITECTURE%"=="AMD64" (set niarchbit=-64)
IF "%PROCESSOR_ARCHITECTURE%"=="AMD64" (set nsarchbit=x64
set "programfiles_arch=%PROGRAMFILES(x86)%"
) ELSE (set nsarchbit=Win32
set "programfiles_arch=%PROGRAMFILES%")

:: NSudo Flagged by Defender, dotnet install script as user install noted.
:: if exist %altanosinstdir%\bin\Nsudo\%nsarchbit%\.. goto skipnsudo
:: %bitsadminget% https://dotnet.microsoft.com/download/dotnet/scripts/v1/dotnet-install.ps1 %altanosinstdir%\dotnet-install.ps1
:: %bitsadminget% https://github.com/... %altanosinstdir%\... 
:: %powshcmd% "Invoke-WebRequest -uri https://github.com/... -OutFile %altanosinstdir%\..."
:: %powshcmd% "Expand-Archive -Force '%altanosinstdir%\...' '%altanosinstdir%\bin\..."
:: skipnsudo

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



:: %bitsadminget% https://github.com/PowerShell/PowerShell/releases/download/v7.3.2/PowerShell-7.3.2-win-x64.msi %altanosinstdir%\PowerShell-7.3.2-win-x64.msi 
:: %bitsadminget% https://tinywall.pados.hu/files/TinyWall-v3-Installer.msi %altanosinstdir%\TinyWall-v3-Installer.msi
:: %bitsadminget% https://privazer.com/en/PrivaZer.exe %altanosinstdir%\bin\PrivaZer.exe
 
 
 %powshadmcmd% '%powshcmd% "Set-ItemProperty -Path REGISTRY::HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System -Name ConsentPromptBehaviorAdmin -Value 0"'
 %powshadmcmd% '%powshcmd% "Set-ExecutionPolicy -ExecutionPolicy Bypass"'

if exist "%altanosinstdir%\network-indicator%niarchbit%.zip" goto skipdl
:: %powshcmd% "Invoke-WebRequest -uri https://adwcleaner.malwarebytes.com/adwcleaner?channel=release -OutFile %altanosinstdir%\adwcleaner.exe"
echo "No progress bar as there is a bug in PowerShell making the download increadibly slow... ( https://github.com/PowerShell/PowerShell/issues/2138 )"

:: %powshcmd% $ProgressPreference = 'SilentlyContinue'
:: %powshcmd% Invoke-WebRequest -uri https://downloads.malwarebytes.com/file/adwcleaner -OutFile %altanosinstdir%\bin\adwcleaner.exe 
::  %altanosinstdir%\bin\adwcleaner.exe"

:: %powshcmd% Invoke-WebRequest -uri https://tinywall.pados.hu/files/TinyWall-v3-Installer.msi -OutFile %altanosinstdir%\TinyWall-v3-Installer.msi 

::  %powshcmd% Invoke-WebRequest -uri http://www.itsamples.com/downloads/network-activity-indicator-setup%niarchbit%.zip %altanosinstdir%\network-indicator%niarchbit%.zip 

:: %powshcmd% Invoke-WebRequest -uri https://privazer.com/en/PrivaZer.exe  %altanosinstdir%\bin\PrivaZer.exe  

:: xcopy %altanosdir%\bin\PrivaZer.ini %altanosinstdir%/bin/ 

:: %powshcmd%  Invoke-WebRequest -uri http://www.itsamples.com/downloads/network-activity-indicator-setup%niarchbit%.zip -OutFile %altanosinstdir%\network-indicator%niarchbit%.zip  

 :: %powshcmd% Expand-Archive -Force '%altanosinstdir%\network-indicator%niarchbit%.zip' '%altanosinstdir%\bin\network-indicator%niarchbit%'


:skipdl 
pause 

:: and so i read and learn that it could indeed have been done using something like this: 
:: %powshcmd% -Argument "-NoProfile -ExecutionPolicy Bypass"  ^
::    $userprofiles = @('C:\Users\');  ^
::   ForEach ($user in $userprofiles) {  ^
::      Set-Location -Path $user;  ^
::      Get-ChildItem -Filter '*.log~' ^| Where-Object { $_.Attributes -band [System.IO.FileAttributes]::Archive }  ^
::   };

:: rebuild performance counters
:: https://learn.microsoft.com/en-us/troubleshoot/windows-server/performance/manually-rebuild-performance-counters
echo Rebuild performance counters
%powshadmcmd% "%altanosdir%\src\pref-cnt.ps1"

echo Forces the clock to be backed by a platform source, no synthetic timers are allowed. Have not been able to prove the benifits of this, feel free to skip or test yourself:
 bcdedit /set useplatformtick yes

:: cd %altanosdir%

:: I think strip windows here
 %powshadmcmd% "%altanosdir%\src\strip_windows.ps1 

:: The following operations can under some circumstances take a hellova lot of thime, i'm not really sure if this really is ideal.
  Echo There will be packages that fail to remove here because they are core components, some red text to follow.
 %powshadmcmd% "%altanosdir%\src\pkgs-prep.ps1"

:: - open scripts in notepad++ to preview instead of executing when clicking
if exist "%ProgramFiles%\Notepad++\Notepad++.exe" (
:: move this here for now 
for %%a in (
    "batfile"
    "chmfile"
    "cmdfile"
    "htafile"
    "jsefile"
    "jsfile"
	"jsonfile"
    "regfile"
    "sctfile"
    "shfile"
    "inifile"
    "pyfile"
    "urlfile"
    "vbefile"
    "vbsfile"
    "wscfile"
    "wsffile"
    "wsfile"
    "wshfile"
    "xmlfile"
) do (
   ftype %%a="%ProgramFiles%\Notepad++\Notepad++.exe" "%1"
) ) 
 
 :: I BLOODY DID THIS YESTERDAY! AND FIXED THE README! F U WINDOWS
 :: echo git clone the latest AltanOS
 :: if exist %altanoinstsdir%
 :: "%gitget%" pull -b main https://github.com/threader/AltanOS "%altanosinstdir%"
 :: else
 :: "%gitget%" clone -b main https://github.com/threader/AltanOS "%altanosinstdir%"
 :: cd %altanosdir%\AltanOS
 
  :: After first git clone: 
 :: git submodule update --init --recursive 
 :: pull latest submodules changes:
:: git submodule update --recursive
 
:: cd %altanosdir%

:: im sure this happened elsewhere 
 xcopy %altanosdir%\bin\PrivaZer.ini %altanosinstdir%\bin\ 

:: Hardening scripts
 %powshadmcmd% "%altanosdir%\src\harden-AltanOS.cmd"
:: a new arrival with additional great hardening finds
 %powshadmcmd% "%altanosdir%\whs\windows-hardening-script.cmd"

 %powshadmcmd% "%altanosdir%\src\mouse-config.ps1"

:: And i bow in respect to Yamato-Security - however this should be made configurable, so - ask
 %powshadmcmd% "%altanosdir%\ewl\YamatoSecurityConfigureWinEventLogs.bat"
:: https://github.com/trustedsec/SysmonCommunityGuide/blob/master/chapters/install_windows.md#install
:: install/accept the eula
sysmon.exe -i -accepteula "%altanosdir%\sysmon-config\sysmonconfig-export-block-loldrivers.xml"
:: Renamed Driver ... The driver file and registry entry are renamed. Name has an 8-character lim
sysmon.exe -i -d sumonmon
:: Renamed service
::sysmon.exe -i -d sumonmon

 %altanosinstdir%\bin\PrivaZer.exe
:: Backup to bootable .wim 
 %powshadmcmd% "%altanosdir%\src\export-wim.ps1"

:: Schedule checkdisk next reboot 
chkdsk %SystemDrive% /F /R /X 

:: Disable this untill i fix it
:: %powshadmcmd% "%altanosdir%\src\schedule-tasks.ps1"

:: %uacadmuser% %powshcmd% "New-ItemProperty -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Run" -Name "Update Windows and Applications" -Value "%altanosdir%\autorun-update.cmd"  -PropertyType "String""

:: powershell Start-process powershell -Verb RunAS %cd%\dotnet-install.ps1
:: %admuser% dotnet add package Microsoft.UI.Xaml 

:: Ask to install - Tinywall, Network activity indicator, (auto)/run PrivaZer, with config?.
:: echo Remember to configure the TinyWall firewall, select 'Autolearn' if you have problems and use the 'Manage' dialog to tune the selection.
:: if exist "%programfiles_arch%"\TinyWall\TinyWall.exe goto skipptw
:: pause 

:: Unless i can run the TW.exe against a preset rules that allow... stuff, this will need to be very optional to not block all connections. 
:: msiexec.exe /a %altanosinstdir%\TinyWall-v3-Installer.msi /quiet /passive
:: "%altanosinstdir%"\bin\network-indicator"%niarchbit%"\NetworkIndicatorSetup.exe
:: :skiptw

:: powershell -command "&{$var = 'Set-ExecutionPolicy -ExecutionPolicy Restricted'+\" Set-ItemProperty -Path REGISTRY::HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System -Name ConsentPromptBehaviorAdmin -Value 1' \"; echo $var}"

:: %powshadmcmd% '%powshcmd% "Get-ProcessMitigation -RegistryConfigFilePath %altanosinstdir%\settings.xml ^

:: set the admin password prompt, a value of 1 on here and the admin account will require password to be entered. 2 is a prompt.
%powshadmcmd% '%powshcmd% "Set-ItemProperty -Path REGISTRY::HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System -Name ConsentPromptBehaviorAdmin -Value 1"'
%powshadmcmd% '%powshcmd% "Set-ExecutionPolicy -ExecutionPolicy Restricted"'

:: Import Settings on a test or base machine
:: Set-ProcessMitigation -PolicyFilePath settings.xml 

endlocal
pause
