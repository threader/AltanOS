:: Altan means porch in Norwegian, so this is effectively PorchOS 
:: Credits to everyone who contributed to https://github.com/Atlas-OS/Atlas/blob/9e675157f1a62aa7687a5f0a5d3fbf59cb281f1f/src/AtlasModules/atlas-config.cmd
:: and https://github.com/amitxv/PC-Tuning
@echo on
cls
echo Setting up and hardening Windows.

:: set variables
IF "%PROCESSOR_ARCHITECTURE%"=="AMD64" (set niarchbit=-64)
IF "%PROCESSOR_ARCHITECTURE%"=="AMD64" (set nsarchbit=x64
) ELSE (set nsarchbit=Win32)

set "usedir=%HOMEDRIVE%\AltanOS.inst" 
set "currentuser=%usedir%\bin\Nsudo\%nsarchbit%\NSudoLC.exe -Priority:AboveNormal -U:C -P:E --wait"
set "admuser=%usedir%\bin\Nsudo\%nsarchbit%\NSudoLC.exe -Priority:AboveNormal -M:S -U:S -P:E --wait"
set "uacuser=%usedir%\bin\Nsudo\%nsarchbit%\NSudoLG.exe -Priority:AboveNormal -U:C -P:E --wait"
set "uacadmuser=%usedir%\bin\Nsudo\%nsarchbit%\NSudoLG.exe -Priority:AboveNormal -M:S -U:S -P:E --wait"
set "wingetinstdcmd=winget install --disable-interactivity --accept-source-agreements"
set "powshcmd=PowerShell -WindowStyle Normal -Command"
set "powshadmcmd=Start-process powershell -Verb RunAS" 
set "bitsadminget=bitsadmin /transfer /Download /priority HIGH"
set "webgetps=%powshcmd% Invoke-WebRequest -uri "%geturl%" -OutFile %geturlout% -v"
set "dismpkg=DISM /online /add-package"
set "msipkg=msiexec.exe /quiet /norestart /passive /package"
set "gitget=%ProgramFiles%\Git\bin\git.exe"

echo Will need net for this 

:: display details about the connection
:: ping -n 6 8.8.8.8

:: Flushdns Fixed winget InternetOpenUrl() failed.
 ipconfig /flushdns

:: if 'someone' is testing and just runs this file...
if exist %usedir% goto skipusedir
 mkdir %usedir%
:skipusedir

:: Flagged bt Defender
if exist %usedir%\bin\Nsudo\%nsarchbit%\NSudoLG.exe goto skipnsudo
:: %bitsadminget% https://github.com/M2Team/NSudo/releases/download/9.0-Preview1/NSudo_9.0_Preview1_9.0.2676.0.zip %usedir%\Nsudo.zip 
:: %powscmd% "Invoke-WebRequest -uri  https://github.com/M2Team/NSudo/releases/download/9.0-Preview1/NSudo_9.0_Preview1_9.0.2676.0.zip --OutFile %usedir%\Nsudo.zip"
:: %powshcmd% "Expand-Archive -Force '%usedir%\Nsudo.zip' '%usedir%\bin\Nsudo'"
:skipnsudo

if exist %usedir%\network-indicator%niarchbit%.zip goto skipdl
:: %bitsadminget% https://github.com/PowerShell/PowerShell/releases/download/v7.3.2/PowerShell-7.3.2-win-x64.msi %usedir%\PowerShell-7.3.2-win-x64.msi 
 %powshcmd% "Invoke-WebRequest -uri https://tinywall.pados.hu/files/TinyWall-v3-Installer.msi -OutFile %usedir%\TinyWall-v3-Installer.msi" 
# %bitsadminget% https://tinywall.pados.hu/files/TinyWall-v3-Installer.msi %usedir%\TinyWall-v3-Installer.msi 
 %powshcmd% "Invoke-WebRequest -uri https://privazer.com/en/PrivaZer.exe -OutFile %usedir%\bin\PrivaZer.exe"
# %bitsadminget% https://privazer.com/en/PrivaZer.exe %usedir%\bin\PrivaZer.exe
 %powshcmd% "Invoke-WebRequest -uri http://www.itsamples.com/downloads/network-activity-indicator-setup%niarchbit%.zip -OutFile %usedir%\network-indicator%niarchbit%.zip"
# %bitsadminget% http://www.itsamples.com/downloads/network-activity-indicator-setup%niarchbit%.zip %usedir%\network-indicator%niarchbit%.zip
 %powshcmd% "Expand-Archive -Force '%usedir%\network-indicator%niarchbit%.zip' '%usedir%\bin\network-indicator%niarchbit%'"
:skipdl
 %powshcmd% "Set-ItemProperty -Path REGISTRY::HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System -Name ConsentPromptBehaviorAdmin -Value 0"

:: %msipkg% %usedir%\PowerShell-7.3.2-win-x64.msi
:: pause
:: make certain applications in request UAC
:: although these applications may already request UAC, setting this compatibility flag ensures they are ran as administrator
 reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers" /v "%usedir%\bin\Nsudo\x64\NSudoLC.exe" /t REG_SZ /d "~ RUNASADMIN" /f
 reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers" /v "%usedir%\bin\Nsudo\x64\NSudoLG.exe" /t REG_SZ /d "~ RUNASADMIN" /f
 reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers" /v "%usedir%\bin\Nsudo\x64\NSudoLC.exe" /t REG_SZ /d "~ RUNASADMIN" /f
 reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers" /v "%usedir%\bin\Nsudo\x64\NSudoLG.exe" /t REG_SZ /d "~ RUNASADMIN" /f

:: enable ASLR
 reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "MoveImages" /t REG_DWORD /d 1 /f

:: disable autoplay and autorun
 reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\AutoplayHandlers" /v "DisableAutoplay" /t REG_DWORD /d "1" /f
 reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoDriveTypeAutoRun" /t REG_DWORD /d "255" /f 
 reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoAutorun" /t REG_DWORD /d "1" /f
 reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Explorer" /v "NoAutoplayfornomVolume" /t REG_DWORD /d "1" /f

:: disable USB autorun/play
 reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoAutorun" /t REG_DWORD /d "1" /f

:: change ntp server from windows server to pool.ntp.org
w32tm /config /syncfromflags:manual /manualpeerlist:"0.pool.ntp.org 1.pool.ntp.org 2.pool.ntp.org 3.pool.ntp.org"
sc queryex "w32time" | find "STATE" | find /v "RUNNING" || (
    net stop w32time
    net start w32time
)

:: disable netbios over tcp/ip
:: works only when services are enabled
for /f "delims=" %%b in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\NetBT\Parameters\Interfaces" /s /f "NetbiosOptions" ^| findstr "HKEY"') do (
     reg add "%%b" /v "NetbiosOptions" /t REG_DWORD /d "2" /f
)

:: netbios hardening
:: netbios is disabled. if it manages to become enabled, protect against NBT-NS poisoning attacks
 reg add "HKLM\SYSTEM\CurrentControlSet\Services\NetBT\Parameters" /v "NodeType" /t REG_DWORD /d "2" /f

:: restrict anonymous access to named pipes and shares
:: https://www.stigviewer.com/stig/windows_10/2021-03-10/finding/V-220932
 reg add "HKLM\SYSTEM\CurrentControlSet\Services\LanManServer\Parameters" /v "RestrictNullSessAccess" /t REG_DWORD /d "1" /f

:: block anonymous enumeration of sam accounts
:: https://www.stigviewer.com/stig/windows_10/2021-03-10/finding/V-220929
 reg add "HKLM\SYSTEM\CurrentControlSet\Control\Lsa" /v "RestrictAnonymousSAM" /t REG_DWORD /d "1" /f

:: restrict anonymous enumeration of shares
:: https://www.stigviewer.com/stig/windows_10/2021-03-10/finding/V-220930
 reg add "HKLM\SYSTEM\CurrentControlSet\Control\Lsa" /v "RestrictAnonymous" /t REG_DWORD /d "1" /f

:: set strong cryptography on 64 bit and 32 bit .net framework (version 4 and above) to fix a scoop installation issue
:: https://github.com/ScoopInstaller/Scoop/issues/2040#issuecomment-369686748
 reg add "HKLM\SOFTWARE\Microsoft\.NetFramework\v4.0.30319" /v "SchUseStrongCrypto" /t REG_DWORD /d "1" /f
 reg add "HKLM\SOFTWARE\WOW6432Node\Microsoft\.NETFramework\v4.0.30319" /v "SchUseStrongCrypto" /t REG_DWORD /d "1" /f

:: mitigate against hivenightmare/serious sam
 icacls %WinDir%\system32\config\*.* /inheritance:e

:: disable nagle's algorithm
:: https://en.wikipedia.org/wiki/Nagle%27s_algorithm
for /f %%i in ('wmic path win32_networkadapter get GUID ^| findstr "{"') do (
     reg add "HKLM\SYSTEM\CurrentControlSet\services\Tcpip\Parameters\Interfaces\%%i" /v "TcpAckFrequency" /t REG_DWORD /d "1" /f
     reg add "HKLM\SYSTEM\CurrentControlSet\services\Tcpip\Parameters\Interfaces\%%i" /v "TcpDelAckTicks" /t REG_DWORD /d "0" /f
     reg add "HKLM\SYSTEM\CurrentControlSet\services\Tcpip\Parameters\Interfaces\%%i" /v "TCPNoDelay" /t REG_DWORD /d "1" /f
)

:: configure search settings
 reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "ConnectedSearchUseWeb" /t REG_DWORD /d "0" /f
 reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "DisableWebSearch" /t REG_DWORD /d "1" /f
 reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowCloudSearch" /t REG_DWORD /d "0" /f
 reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "BingSearchEnabled" /t REG_DWORD /d "0" /f
 reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SearchSettings" /v "IsAADCloudSearchEnabled" /t REG_DWORD /d "0" /f
 reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SearchSettings" /v "IsMSACloudSearchEnabled" /t REG_DWORD /d "0" /f
 reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SearchSettings" /v "IsDeviceSearchHistoryEnabled" /t REG_DWORD /d "0" /f
 reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SearchSettings" /v "SafeSearchMode" /t REG_DWORD /d "0" /f

:: disable search suggestions
 reg add "HKCU\SOFTWARE\Policies\Microsoft\Windows\Explorer" /v "DisableSearchBoxSuggestions" /t REG_DWORD /d "1" /f

:: configure file explorer settings
 reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoResolveSearch" /t REG_DWORD /d "1" /f
 reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoResolveTrack" /t REG_DWORD /d "1" /f
 reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "HideFileExt" /t REG_DWORD /d "0" /f

:: disable lock screen camera
 reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Personalization" /v "NoLockScreenCamera" /t REG_DWORD /d "1" /f

:: disable remote assistance
 reg add "HKLM\SYSTEM\CurrentControlSet\Control\Remote Assistance" /v "fAllowFullControl" /t REG_DWORD /d "0" /f
 reg add "HKLM\SYSTEM\CurrentControlSet\Control\Remote Assistance" /v "fAllowToGetHelp" /t REG_DWORD /d "0" /f
 reg add "HKLM\SYSTEM\CurrentControlSet\Control\Remote Assistance" /v "fEnableChatControl" /t REG_DWORD /d "0" /f

:: enable legacy photo viewer
for %%i in (tif tiff bmp dib gif jfif jpe jpeg jpg jxr png) do (
      reg add "HKLM\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations" /v ".%%~i" /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f
)

:: set legacy photo viewer as default
for %%i in (tif tiff bmp dib gif jfif jpe jpeg jpg jxr png) do (
     reg add "HKCU\SOFTWARE\Classes\.%%~i" /ve /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f
     reg add "HKCU\SOFTWARE\Classes\.wdp" /ve /t REG_SZ /d "PhotoViewer.FileAssoc.Wdp" /f
)

:: set .ps1 file types to open with PowerShell by default
 reg add "HKCR\Microsoft.PowerShellScript.1\Shell\Open\Command" /ve /t REG_SZ /d "\"C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe\" -NoLogo -File \"%1\"" /f

:: add about:blank as start page in internet explorer
 reg add "HKCU\SOFTWARE\Policies\Microsoft\Internet Explorer\Main" /v "Start Page" /t REG_SZ /d "about:blank" /f

:: disable PowerShell telemetry
:: https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_telemetry?view=powershell-7.3
 setx POWERSHELL_TELEMETRY_OPTOUT 1

:: do not allow pinning microsoft store app to taskbar
:: reg add "HKCU\SOFTWARE\Policies\Microsoft\Windows\Explorer" /v "NoPinningStoreToTaskbar" /t REG_DWORD /d "1" /f

:: restrict windows' access to internet resources
:: enables various other GPOs that limit access on specific windows services
 reg add "HKLM\SOFTWARE\Policies\Microsoft\InternetManagement" /v "RestrictCommunication" /t REG_DWORD /d "1" /f

:: disable devicecensus.exe telemetry process
 reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\'DeviceCensus.exe'" /v "Debugger" /t REG_SZ /d "%WinDir%\System32\taskkill.exe" /f

:: disable text/ink/handwriting telemetry
 reg add "HKCU\SOFTWARE\Microsoft\InputPersonalization" /v "RestrictImplicitInkCollection" /t REG_DWORD /d "1" /f
 reg add "HKCU\SOFTWARE\Microsoft\InputPersonalization" /v "RestrictImplicitTextCollection" /t REG_DWORD /d "1" /f
 reg add "HKCU\SOFTWARE\Microsoft\InputPersonalization\TrainedDataStore" /v "HarvestContacts" /t REG_DWORD /d "0" /f
 reg add "HKCU\SOFTWARE\Microsoft\Personalization\Settings" /v "AcceptedPrivacyPolicy" /t REG_DWORD /d "0" /f
 reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\TabletPC" /v "PreventHandwritingDataSharing" /t REG_DWORD /d "1" /f
 reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\HandwritingErrorReports" /v "PreventHandwritingErrorReports" /t REG_DWORD /d "1" /f 

:: disable data collection
 reg add "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d "0" /f
 reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d "0" /f
 reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v "MaxTelemetryAllowed" /t REG_DWORD /d "0" /f
 reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v "AllowDeviceNameInTelemetry" /t REG_DWORD /d "0" /f
 reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d "0" /f
 reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "LimitEnhancedDiagnosticDataWindowsAnalytics" /t REG_DWORD /d "0" /f

:: miscellaneous
 reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Privacy" /v "TailoredExperiencesWithDiagnosticDataEnabled" /t REG_DWORD /d "0" /f
 reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WDI\{9c5a40da-b965-4fc3-8781-88dd50a6299d}" /v "ScenarioExecutionEnabled" /t REG_DWORD /d "0" /f
 reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v "UploadUserActivities" /t REG_DWORD /d "0" /f
 reg add "HKLM\SOFTWARE\Policies\.\Windows\System" /v "PublishUserActivities" /t REG_DWORD /d "0" /f

:: disable experimentation
 reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\System\AllowExperimentation" /v "Value" /t REG_DWORD /d "0" /f

:: configure voice activation settings
 reg add "HKCU\SOFTWARE\Microsoft\Speech_OneCore\Settings\VoiceActivation\UserPreferenceForAllApps" /v "AgentActivationOnLockScreenEnabled" /t REG_DWORD /d "0" /f
 reg add "HKCU\SOFTWARE\Microsoft\Speech_OneCore\Settings\VoiceActivation\UserPreferenceForAllApps" /v "AgentActivationEnabled" /t REG_DWORD /d "0" /f
 reg add "HKCU\SOFTWARE\Microsoft\Speech_OneCore\Settings\VoiceActivation\UserPreferenceForAllApps" /v "AgentActivationLastUsed" /t REG_DWORD /d "0" /f

:: disable advertising info
 reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v "Enabled" /t REG_DWORD /d "0" /f

:: disable nvidia telemetry
 reg add "HKLM\SOFTWARE\NVIDIA Corporation\NvControlPanel2\Client" /v "OptInOrOutPreference" /t REG_DWORD /d "0" /f

:: disable typing insights
 reg add "HKCU\SOFTWARE\Microsoft\Input\Settings" /v "InsightsEnabled" /t REG_DWORD /d "0" /f

:: disable cloud optimized taskbars
 reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v "DisableCloudOptimizedContent" /t REG_DWORD /d "1" /f

:: disable annoying keyboard features
 reg add "HKCU\Control Panel\Accessibility\StickyKeys" /v "Flags" /t REG_DWORD /d "0" /f
 reg add "HKCU\Control Panel\Accessibility\Keyboard Response" /v "Flags" /t REG_DWORD /d "0" /f
 reg add "HKCU\C ontrol Panel\Accessibility\MouseKeys" /v "Flags" /t REG_DWORD /d "0" /f

:: hide meet now button on taskbar
 reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "HideSCAMeetNow" /t REG_DWORD /d "1" /f

:: disable shared experiences
 reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v "EnableCdp" /t REG_DWORD /d "0" /f

:: disable news and interests
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Feeds" /v "EnableFeeds" /t REG_DWORD /d "0" /f
 reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Feeds" /v "ShellFeedsTaskbarViewMode" /t REG_DWORD /d "2" /f

:: location tracking
 reg add "HKLM\SOFTWARE\Policies\Microsoft\FindMyDevice" /v "AllowFindMyDevice" /t REG_DWORD /d "0" /f
 reg add "HKLM\SOFTWARE\Policies\Microsoft\FindMyDevice" /v "LocationSyncEnabled" /t REG_DWORD /d "0" /f

:: do not show hidden/disconnected devices in sound settings
 reg add "HKCU\SOFTWARE\Microsoft\Multimedia\Audio\DeviceCpl" /v "ShowHiddenDevices" /t REG_DWORD /d "0" /f

echo The spooler will not accept client connections nor allow users to share printers.
 reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\Printers" /v "RegisterSpoolerRemoteRpcEndPoint" /t REG_DWORD /d "2" /f
 reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\Printers\PointAndPrint" /v "RestrictDriverInstallationToAdministrators" /t REG_DWORD /d "1" /f
 reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\Printers\PointAndPrint" /v "Restricted" /t REG_DWORD /d "1" /f

:: merge as trusted installer for registry files
 reg add "HKCR\regfile\Shell\RunAs" /ve /t REG_SZ /d "Merge As TrustedInstaller" /f
 reg add "HKCR\regfile\Shell\RunAs" /v "HasLUAShield" /t REG_SZ /d "1" /f
 reg add "HKCR\regfile\Shell\RunAs\Command" /ve /t REG_SZ /d "NSudoLC.exe -U:T -P:E reg import "%%1"" /f
 reg add "HKCR\regfile\Shell\RunAs\Command" /ve /t REG_SZ /d "NSudoLG.exe -U:T -P:E reg import "%%1"" /f

:: install cab context menu
 reg delete "HKCR\CABFolder\Shell\RunAs" /f > nul 2>nul
 reg add "HKCR\CABFolder\Shell\RunAs" /ve /t REG_SZ /d "Install" /f
 reg add "HKCR\CABFolder\Shell\RunAs" /v "HasLUAShield" /t REG_SZ /d "" /f       
 reg add "HKCR\CABFolder\Shell\RunAs\Command" /ve /t REG_SZ /d "cmd /k DISM /online /add-package /packagepath:\"%%1\"" /f

:: enable dark mode and disable transparency
 reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "SystemUsesLightTheme" /t REG_DWORD /d "0" /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "AppsUseLightTheme" /t REG_DWORD /d "0" /f

:: disable speech model updates
reg add "HKLM\SOFTWARE\Policies\Microsoft\Speech" /v "AllowSpeechModelUpdate" /t REG_DWORD /d "0" /f

:: disable online speech recognition
reg add "HKLM\SOFTWARE\Policies\Microsoft\InputPersonalization" /v "AllowInputPersonalization" /t REG_DWORD /d "0" /f

:: show hidden files, folders and drives in file epxlorer
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Hidden" /t REG_DWORD /d "1" /f

:: do not track shell shortcuts during roaming
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "LinkResolveIgnoreLinkInfo" /t REG_DWORD /d "1" /f

:: disable user tracking
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoInstrumentation" /t REG_DWORD /d "1" /f

:: disable internet file association service
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoInternetOpenWith" /t REG_DWORD /d "1" /f

:: do not use the search-based method when resolving shell shortcuts
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoResolveSearch" /t REG_DWORD /d "1" /f

:: do not use the tracking-based method when resolving shell shortcuts
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoResolveTrack" /t REG_DWORD /d "1" /f

:: do not display or track items in jump lists from remote locations
reg add "HKCU\SOFTWARE\Policies\Microsoft\Windows\Explorer" /v "NoRemoteDestinations" /t REG_DWORD /d "1" /f

:: never use tablet mode
::  reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ImmersiveShell" /v "SignInMode" /t REG_DWORD /d "1" /f

:: configure voice activation settings
 reg add "HKCU\SOFTWARE\Microsoft\Speech_OneCore\Settings\VoiceActivation\UserPreferenceForAllApps" /v "AgentActivationOnLockScreenEnabled" /t REG_DWORD /d "0" /f
 reg add "HKCU\SOFTWARE\Microsoft\Speech_OneCore\Settings\VoiceActivation\UserPreferenceForAllApps" /v "AgentActivationEnabled" /t REG_DWORD /d "0" /f
 reg add "HKCU\SOFTWARE\Microsoft\Speech_OneCore\Settings\VoiceActivation\UserPreferenceForAllApps" /v "AgentActivationLastUsed" /t REG_DWORD /d "0" /f

:: configure miscellaneous settings
 reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Privacy" /v "TailoredExperiencesWithDiagnosticDataEnabled" /t REG_DWORD /d "0" /f
 reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Diagnostics\DiagTrack" /v "ShowedToastAtLevel" /t REG_DWORD /d "1" /f
 reg add "HKCU\SOFTWARE\Microsoft\Input\TIPC" /v "Enabled" /t REG_DWORD /d "0" /f
 reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v "UploadUserActivities" /t REG_DWORD /d "0" /f
 reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v "PublishUserActivities" /t REG_DWORD /d "0" /f
 reg add "HKLM\SYSTEM\CurrentControlSet\Control\Diagnostics\Performance" /v "DisableDiagnosticTracing" /t REG_DWORD /d "1" /f
 reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WDI\{9c5a40da-b965-4fc3-8781-88dd50a6299d}" /v "ScenarioExecutionEnabled" /t REG_DWORD /d "0" /f

:: disable shared experiences
 reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v "EnableCdp" /t REG_DWORD /d "0" /f

:: show all tasks in control panel, credits to tenforums
 reg add "HKLM\SOFTWARE\Classes\CLSID\{D15ED2E1-C75B-443c-BD7C-FC03B2F08C17}" /ve /t REG_SZ /d "All Tasks" /f
 reg add "HKLM\SOFTWARE\Classes\CLSID\{D15ED2E1-C75B-443c-BD7C-FC03B2F08C17}" /v "InfoTip" /t REG_SZ /d "View list of all Control Panel tasks" /f
 reg add "HKLM\SOFTWARE\Classes\CLSID\{D15ED2E1-C75B-443c-BD7C-FC03B2F08C17}" /v "System.ControlPanel.Category" /t REG_SZ /d "5" /f
 reg add "HKLM\SOFTWARE\Classes\CLSID\{D15ED2E1-C75B-443c-BD7C-FC03B2F08C17}\DefaultIcon" /ve /t REG_SZ /d "C:\Windows\System32\imageres.dll,-27" /f
 reg add "HKLM\SOFTWARE\Classes\CLSID\{D15ED2E1-C75B-443c-BD7C-FC03B2F08C17}\Shell\Open\Command" /ve /t REG_SZ /d "explorer.exe shell:::{ED7BA470-8E54-465E-825C-99712043E01C}" /f
 reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\ControlPanel\NameSpace\{D15ED2E1-C75B-443c-BD7C-FC03B2F08C17}" /ve /t REG_SZ /d "All Tasks" /f


:: add .bat, .cmd, .reg and .ps1 to the 'New' context menu
:: reg add "HKLM\SOFTWARE\Classes\.bat\ShellNew" /v "ItemName" /t REG_EXPAND_SZ /d "@C:\Windows\System32\acppage.dll,-6002" /f
:: reg add "HKLM\SOFTWARE\Classes\.bat\ShellNew" /v "NullFile" /t REG_SZ /d "" /f
:: reg add "HKLM\SOFTWARE\Classes\.cmd\ShellNew" /v "NullFile" /t REG_SZ /d "" /f
:: reg add "HKLM\SOFTWARE\Classes\.cmd\ShellNew" /v "ItemName" /t REG_EXPAND_SZ /d "@C:\Windows\System32\acppage.dll,-6003" /f
 reg add "HKLM\SOFTWARE\Classes\.ps1\ShellNew" /v "NullFile" /t REG_SZ /d "" /f
 reg add "HKLM\SOFTWARE\Classes\.ps1\ShellNew" /v "ItemName" /t REG_EXPAND_SZ /d "New file" /f
:: reg add "HKLM\SOFTWARE\Classes\.reg\ShellNew" /v "NullFile" /t REG_SZ /d "" /f
:: reg add "HKLM\SOFTWARE\Classes\.reg\ShellNew" /v "ItemName" /t REG_EXPAND_SZ /d "@C:\Windows\regedit.exe,-309" /f

:: enable security functions
 reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DeviceGuard" /t REG_DWORD /v "EnableVirtualizationBasedSecurity" /d "1" /f
 reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DeviceGuard" /t REG_DWORD /v "HypervisorEnforcedCodeIntegrity" /d "1" /f
 reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DeviceGuard" /t REG_DWORD /v "HVCIMATRequired" /d "1" /f
 reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DeviceGuard" /t REG_DWORD /v "ConfigureSystemGuardLaunch" /d "1" /f
 reg add "HKLM\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity" /v "WasEnabledBy" /t REG_DWORD /d "1" /f
 reg add "HKLM\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity" /v "Enabled" /t REG_DWORD /d "1" /f

:: disable spectre and meltdown - make this optional? Albeit, not a good idea as there are javascript implimentations that exploit this...
:: reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "FeatureSettingsOverride" /t REG_DWORD /d "3" /f
:: reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "FeatureSettingsOverrideMask" /t REG_DWORD /d "3" /f

:: prevent print drivers over HTTP
 reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\Printers" /v "DisableWebPnPDownload" /t REG_DWORD /d "1" /f

:: disable printing over HTTP
 reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\Printers" /v "DisableHTTPPrinting" /t REG_DWORD /d "1" /f

:: remove '- Shortcut' text added onto shortcuts
 reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "link" /t REG_BINARY /d "00000000" /f

:: Figure out why these fail at some point 

:: disable audio excludive mode on all devices
:: for /f "delims=" %%a in ('reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\MMDevices\Audio\Capture"') do (
::    reg add "%%a\Properties" /v "{b3f8fa53-0004-438e-9003-51a46e139bfc},3" /t REG_DWORD /d "0" /f
::    reg add "%%a\Properties" /v "{b3f8fa53-0004-438e-9003-51a46e139bfc},4" /t REG_DWORD /d "0" /f
::)

:: - harden process mitigations (lower compatibilty for legacy apps) 
:: This is way to strict.
:: %uacadmuser% %powshcmd% "Set-ProcessMitigation -System -Enable DEP, EmulateAtlThunks, RequireInfo, BottomUp, HighEntropy, StrictHandle, CFG, StrictCFG, SuppressExports, SEHOP, AuditSEHOP, SEHOPTelemetry, ForceRelocateImages"
:: Try maybe?
:: %uacadmuser% %powshcmd% "Set-ProcessMitigation -System -Enable DEP, EmulateAtlThunks, RequireInfo, BottomUp, HighEntropy, StrictHandle, SuppressExports, SEHOP, AuditSEHOP, SEHOPTelemetry, ForceRelocateImages, AuditMiceosoftSigned, AuditStoreSigned, EnforceModuleDependencyString, DisableNonSystemFonts, AuditFont"
:: Set these tested settings for now
 %uacadmuser% %powshcmd% "Set-ProcessMitigation -System -Enable DEP, EmulateAtlThunks"
 
bcdedit /set nx Optin

@echo on

:: cls 
:: 
:: %uacadmuser% %powshcmd% Set-ExecutionPolicy -ExecutionPolicy Bypass
:: powershell Start-process powershell -Verb RunAS %cd%\winget-pkg.ps1
:: %uacadmuser% %powshcmd% Set-ExecutionPolicy -ExecutionPolicy Restricted
:: %uacadmuser% %powshcmd% add-appxpackage -Path "%usedir%\Microsoft.DesktopAppInstaller.msixbundle"

echo git clone the latest AltanOS
 %gitget% clone -b main https://github.com/threader/AltanOS "%HOMEDRIVE%\AltanOS"

echo Disablng WMP and IE, enable Hyper-V and WSL
 DISM /Online /Disable-Feature /FeatureName:WindowsMediaPlayer /norestart
 DISM /Online /Disable-Feature /FeatureName:Internet-Explorer-Optional-amd64 /norestart
 DISM /Online /Disable-Feature /FeatureName:Internet-Explorer-Optional-x86 /norestart
 
 DISM /Online /Enable-Feature /featurename:Microsoft-Hyper-V /Quiet /NoRestart
 DISM /online /enable-feature /featurename:HypervisorPlatform /all /norestart
 DISM /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
 DISM /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
:: %powshcmd% Enable-WindowsOptionalFeature applicaonalFeature -Online -FeatureName VirtualMachinePlatform -NoRestart
%powshcmd% wsl --set-default-version 2

:: enable system devices
::  DevManView.exe /enable "Microsoft Hyper-V NT Kernel Integration VSP"
::  DevManView.exe /enable "Microsoft Hyper-V PCI Server"
::  DevManView.exe /enable "Microsoft Hyper-V Virtual Disk Server"
::  DevManView.exe /enable "Microsoft Hyper-V Virtual Machine Bus Provider"
::  DevManView.exe /enable "Microsoft Hyper-V Virtualization Infrastructure Driver"

 echo info: cleaning the winsxs folder - bah this needs to be done after a reboot 
 sfc /SCANNOW
 DISM /Online /Cleanup-Image /StartComponentCleanup /ResetBase /RestoreHealth

 echo Remember to configure the TinyWall firewall, select autolearn from the menu for a while for instance to allo trafficw
  %msipkg% %usedir%\TinyWall-v3-Installer.msi

:: - open scripts in notepad++ to preview instead of executing when clicking
if exist %ProgramFiles%\Notepad++\Notepad++.exe (
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
:: reset the admin password prompt, a value of 1 on here on the admin account will require password to be entered. 2 is a prompt.
 %powshcmd% Set-ItemProperty -Path REGISTRY::HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System -Name ConsentPromptBehaviorAdmin -Value 1
 echo All done, pausing for you to review what might have gone astray.
 pause
