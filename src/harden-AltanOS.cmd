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

set "altanosdir=%cd%"
set "altanosinstdir=%SystemDrive%\AltanOS.inst" 
set "wingetinstdcmd=winget install --disable-interactivity --accept-source-agreements"
set "powshcmd=PowerShell -Command"
set "powshadmcmd=%powshcmd% "Start-process "powershell -Wait -Verb RunAS"""
set "bitsadminget=bitsadmin /transfer /Download /priority HIGH"
set "webgetps=%powshcmd% Invoke-WebRequest -uri "%geturl%" -OutFile %geturlout% -v"
set "dismpkg=DISM /online /add-package"
set "msipkg=msiexec.exe /quiet /norestart /passive /package"
set "gitget=%ProgramFiles%\Git\bin\git.exe"
set "altanlog=%altanosinstdir%\logs"

reg import "%altanosdir%\src\harden.reg"

:: if 'someone' is testing and just runs this file...
if exist %altanosinstdir% goto skipaltanosinstdir
 mkdir %altanosinstdir%
 mkdir %altanosinstdir%\logs
:skipaltanosinstdir

:: Flagged by Defender - not really needed
:: if exist %altanosinstdir%\bin\Nsudo\%nsarchbit%\NSudoLG.exe goto skipnsudo
:: %bitsadminget% https://github.com/... %altanosinstdir%\...
:: %powscmd% "Invoke-WebRequest -uri  https://github.com/...--OutFile %altanosinstdir%\.."
:: %powshcmd% "Expand-Archive -Force '%altanosinstdir%\...' '%altanosinstdir%\bin\...'"
:: :skipnsudo


:: %powshcmd% "Set-ItemProperty -Path REGISTRY::HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System -Name ConsentPromptBehaviorAdmin -Value 0"

:: pause


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

:: problems here
:: unhide power scheme attributes
:: source: https://gist.github.com/Velocet/7ded4cd2f7e8c5fa475b8043b76561b5#file-unlock-powercfg-ps1
:: %powshcmd% "$PowerCfg = (Get-ChildItem 'HKLM:\SYSTEM\CurrentControlSet\Control\Power\PowerSettings' -Recurse).Name -notmatch '\bDefaultPowerSchemeValues|(\\[0-9]|\b255)$';foreach ($item in $PowerCfg) { Set-ItemProperty -Path $item.Replace('HKEY_LOCAL_MACHINE','HKLM:') -Name 'Attributes' -Value 0 -Force}"
:: if %ERRORLEVEL%==0 (echo %date% - %time% Enabled hidden power scheme attributes...
:: ) ELSE (echo %date% - %time% Failed to enable hidden power scheme attributes! ):: disable smart multi-homed name resolution

reg add "HKLM\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters" /v "DisableParallelAandAAAA " /t REG_DWORD /d "1" /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\DNSClient" /v "DisableSmartNameResolution" /t REG_DWORD /d "1" /f

:: disable startup delay of running apps %currentuser% 
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Serialize" /v "StartupDelayInMSec" /t REG_DWORD /d "0" /f

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

:: disable speech model updates
reg add "HKLM\SOFTWARE\Policies\Microsoft\Speech" /v "AllowSpeechModelUpdate" /t REG_DWORD /d "0" /f


:: disable website access to language list %currentuser% 
reg add "HKCU\Control Panel\International\User Profile" /v "HttpAcceptLanguageOptOut" /t REG_DWORD /d "1" /f



:: disable online speech recognition
reg add "HKLM\SOFTWARE\Policies\Microsoft\InputPersonalization" /v "AllowInputPersonalization" /t REG_DWORD /d "0" /f

:: disable windows insider and build previews
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\PreviewBuilds" /v "EnableConfigFlighting" /t REG_DWORD /d "0" /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\PreviewBuilds" /v "AllowBuildPreview" /t REG_DWORD /d "0" /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\PreviewBuilds" /v "EnableExperimentation" /t REG_DWORD /d "0" /f
reg add "HKLM\SOFTWARE\Microsoft\WindowsSelfHost\UI\Visibility" /v "HideInsiderPage" /t REG_DWORD /d "1" /f
:: damn i really thought EnableExperimentation was disabled...

:: disable activity feed
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v "EnableActivityFeed" /t REG_DWORD /d "0" /f

:: disable windows media DRM internet access
reg add "HKLM\SOFTWARE\Policies\Microsoft\WMDRM" /v "DisableOnline" /t REG_DWORD /d "1" /f

:: disable windows media player wizard on first run
%currentuser% reg add "HKCU\SOFTWARE\Microsoft\MediaPlayer\Preferences" /v "AcceptedPrivacyStatement" /t REG_DWORD /d "1" /f


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

:: show hidden files, folders and drives in file epxlorer%currentuser%
 reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Hidden" /t REG_DWORD /d "1" /f

:: show command prompt on win+x menu %currentuser%
 reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "DontUsePowerShellOnWinX" /t REG_DWORD /d "1" /f


:: disable lock screen camera
 reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Personalization" /v "NoLockScreenCamera" /t REG_DWORD /d "1" /f

:: disable remote assistance
 reg add "HKLM\SYSTEM\CurrentControlSet\Control\Remote Assistance" /v "fAllowFullControl" /t REG_DWORD /d "0" /f
 reg add "HKLM\SYSTEM\CurrentControlSet\Control\Remote Assistance" /v "fAllowToGetHelp" /t REG_DWORD /d "0" /f
 reg add "HKLM\SYSTEM\CurrentControlSet\Control\Remote Assistance" /v "fEnableChatControl" /t REG_DWORD /d "0" /f

:: Good one on old intel i7 from 1008 or sso.
:: enable legacy photo viewer
for %%i in (tif tiff bmp dib gif jfif jpe jpeg jpg jxr png) do (
      reg add "HKLM\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations" /v ".%%~i" /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f
)

:: set legacy photo viewer as default
for %%i in (tif tiff bmp dib gif jfif jpe jpeg jpg jxr png) do (
     reg add "HKCU\SOFTWARE\Classes\.%%~i" /ve /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f
     reg add "HKCU\SOFTWARE\Classes\.wdp" /ve /t REG_SZ /d "PhotoViewer.FileAssoc.Wdp" /f
)

:: add about:blank as start page in internet explorer
 reg add "HKCU\SOFTWARE\Policies\Microsoft\Internet Explorer\Main" /v "Start Page" /t REG_SZ /d "about:blank" /f

:: disable PowerShell telemetry
:: https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_telemetry?view=powershell-7.3
 setx POWERSHELL_TELEMETRY_OPTOUT 1

:: Disable fastboot... Properly unmounts the filesystem and all...
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v "HiberbootEnabled" /t REG_DWORD /d "0" /f

:: disable sleep study
wevtutil set-log "Microsoft-Windows-SleepStudy/Diagnostic" /e:false
wevtutil set-log "Microsoft-Windows-Kernel-Processor-Power/Diagnostic" /e:false
wevtutil set-log "Microsoft-Windows-UserModePowerService/Diagnostic" /e:false

:: do not allow pinning microsoft store app to taskbar
:: reg add "HKCU\SOFTWARE\Policies\Microsoft\Windows\Explorer" /v "NoPinningStoreToTaskbar" /t REG_DWORD /d "1" /f


:: show more details in file transfer dialog currentuser
 reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\OperationStatusManager" /v "EnthusiastMode" /t REG_DWORD /d "1" /f

:: Extend icon cache size to 4 MB
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "Max Cached Icons" /t REG_SZ /d "4096" /f

:: restrict windows' access to internet resources
:: enables various other GPOs that limit access on specific windows services
 reg add "HKLM\SOFTWARE\Policies\Microsoft\InternetManagement" /v "RestrictCommunication" /t REG_DWORD /d "1" /f

:: disable devicecensus.exe telemetry process
 reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\'DeviceCensus.exe'" /v "Debugger" /t REG_SZ /d "%WinDir%\System32\taskkill.exe" /f

:: disable use sign-in info to auto finish setting up device after update or restart
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "DisableAutomaticRestartSignOn" /t REG_DWORD /d "1" /f

:: do not preserve zone information in file attachments %currentuser%
 reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Attachments" /v "SaveZoneInformation" /t REG_DWORD /d "1" /f


:: disable annoying keyboard and mouse features %currentuser%
 reg add "HKCU\Control Panel\Accessibility\HighContrast" /v "Flags" /t REG_DWORD /d "0" /f
 reg add "HKCU\Control Panel\Accessibility\Keyboard Response" /v "Flags" /t REG_DWORD /d "0" /f
 reg add "HKCU\Control Panel\Accessibility\MouseKeys" /v "Flags" /t REG_DWORD /d "0" /f
 reg add "HKCU\Control Panel\Accessibility\StickyKeys" /v "Flags" /t REG_DWORD /d "0" /f
 reg add "HKCU\Control Panel\Accessibility\ToggleKeys" /v "Flags" /t REG_DWORD /d "0" /f

:: disable touch visual feedback
 reg add "HKCU\Control Panel\Cursors" /v "GestureVisualization" /t REG_DWORD /d "0" /f
 reg add "HKCU\Control Panel\Cursors" /v "ContactVisualization" /t REG_DWORD /d "0" /f


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

:: disable typing insights - %currentuser%
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

:: reg add "HKCR\regfile\Shell\RunAs\Command" /ve /t REG_SZ /d "NSudoLC.exe -U:T -P:E reg import "%%1"" /f
:: reg add "HKCR\regfile\Shell\RunAs\Command" /ve /t REG_SZ /d "NSudoLG.exe -U:T -P:E reg import "%%1"" /f

:: install cab context menu
 reg delete "HKCR\CABFolder\Shell\RunAs" /f >
 reg add "HKCR\CABFolder\Shell\RunAs" /ve /t REG_SZ /d "Install" /f
 reg add "HKCR\CABFolder\Shell\RunAs" /v "HasLUAShield" /t REG_SZ /d "" /f       
 reg add "HKCR\CABFolder\Shell\RunAs\Command" /ve /t REG_SZ /d "cmd /k DISM /online /add-package /packagepath:\"%%1\"" /f

:: enable dark mode and disable transparency
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "SystemUsesLightTheme" /t REG_DWORD /d "0" /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "AppsUseLightTheme" /t REG_DWORD /d "0" /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "EnableTransparency" /t REG_DWORD /d "1" /f

:: disable desktop wallpaper import quality reduction
reg add "HKCU\Control Panel\Desktop" /v "JPEGImportQuality" /t REG_DWORD /d "100" /f

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

:: hide news and interests on taskbar - sorting out shat of these regs should to the user/user not adm/user will be a pain
:: %currentuser% 
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Feeds" /v "ShellFeedsTaskbarViewMode" /t REG_DWORD /d "2" /f


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
 reg add "HKLM\SOFTWARE\Classes\.cmd\ShellNew" /v "NullFile" /t REG_SZ /d "" /f
 reg add "HKLM\SOFTWARE\Classes\.cmd\ShellNew" /v "ItemName" /t REG_EXPAND_SZ /d "@C:\Windows\System32\acppage.dll,-6003" /f
 reg add "HKLM\SOFTWARE\Classes\.ps1\ShellNew" /v "NullFile" /t REG_SZ /d "" /f
 reg add "HKLM\SOFTWARE\Classes\.ps1\ShellNew" /v "ItemName" /t REG_EXPAND_SZ /d "New file" /f
:: reg add "HKLM\SOFTWARE\Classes\.reg\ShellNew" /v "NullFile" /t REG_SZ /d "" /f
:: reg add "HKLM\SOFTWARE\Classes\.reg\ShellNew" /v "ItemName" /t REG_EXPAND_SZ /d "@C:\Windows\regedit.exe,-309" /f

:: enable security functions
 reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DeviceGuard" /t REG_DWORD /v "EnableVirtualizationBasedSecurity" /d "1" /f
 reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DeviceGuard" /t REG_DWORD /v "HypervisorEnforcedCodeIntegrity" /d "1" /f
 
 :: Uuuh. Reading https://learn.microsoft.com/en-us/windows/security/hardware-security/enable-virtualization-based-protection-of-code-integrity 
 :: there are two ways to enable this, without efi, the command done above and with locked efi.. bellow ... 
 ::reg add "HKLM\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity" /v "Locked" /t REG_DWORD /d 1 /f 
 
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
 for /f "delims=" %%a in ('reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\MMDevices\Audio\Capture"') do (
    reg add "%%a\Properties" /v "{b3f8fa53-0004-438e-9003-51a46e139bfc},3" /t REG_DWORD /d "0" /f
    reg add "%%a\Properties" /v "{b3f8fa53-0004-438e-9003-51a46e139bfc},4" /t REG_DWORD /d "0" /f
)

for /f "delims=" %%a in ('reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\MMDevices\Audio\Render"') do (
    reg add "%%a\Properties" /v "{b3f8fa53-0004-438e-9003-51a46e139bfc},3" /t REG_DWORD /d "0" /f
    reg add "%%a\Properties" /v "{b3f8fa53-0004-438e-9003-51a46e139bfc},4" /t REG_DWORD /d "0" /f
)

:: lsass hardening
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\lsass.exe" /v "AuditLevel" /t REG_DWORD /d "8" /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CredentialsDelegation" /v "AllowProtectedCreds" /t REG_DWORD /d "1" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Lsa" /v "DisableRestrictedAdminOutboundCreds" /t REG_DWORD /d "1" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Lsa" /v "DisableRestrictedAdmin" /t REG_DWORD /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Lsa" /v "RunAsPPL" /t REG_DWORD /d "1" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\WDigest" /v "Negotiate" /t REG_DWORD /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\WDigest" /v "UseLogonCredential" /t REG_DWORD /d "0" /f


:: enable hybrid sleep
powercfg -setacvalueindex 11111111-1111-1111-1111-111111111111 238c9fa8-0aad-41ed-83f4-97be242c8f20 94ac6d29-73ce-41a6-809f-6363ba21b47e 1
powercfg -setdcvalueindex 11111111-1111-1111-1111-111111111111 238c9fa8-0aad-41ed-83f4-97be242c8f20 94ac6d29-73ce-41a6-809f-6363ba21b47e 1
powercfg -setactive scheme_current

:: Hecky but ok , I've got a but in my menu now where items have appeared twice 
:: debloat 'Send To' context menu, hidden files do not show up in the 'Send To' context menu
attrib +h "C:\Users\%loggedinusername%\AppData\Roaming\Microsoft\Windows\SendTo\Bluetooth File Transfer.LNK"
attrib +h "C:\Users\%loggedinusername%\AppData\Roaming\Microsoft\Windows\SendTo\Mail Recipient.MAPIMail"
attrib +h "C:\Users\%loggedinusername%\AppData\Roaming\Microsoft\Windows\SendTo\Documents.mydocs"

:: remove share from context menu
reg delete "HKCR\*\shellex\ContextMenuHandlers\ModernSharing" /f >

:: Hmmm i feel i've gone hunting here before .... more (old) from atlas/src/AtlasModules/atlas-config.cm


:: add music and videos folders to quick access
:: start /b %PowerShell% "$o = new-object -com shell.application; $o.Namespace("""$env:userprofile\Videos""").Self.InvokeVerb("""pintohome"""); $o.Namespace("""$env:userprofile\Music""").Self.InvokeVerb("""pintohome""")" > nul 2>&1


set setSvc=call :setSvc

:: Workstation disbled as Network Sharing dependency.
%setSvc% NlaSvc 4
%setSvc% lmhosts 4
%setSvc% netman 4
::EventLog enabled as Network Sharing dependency
%setSvc% NlaSvc 2
%setSvc% lmhosts 3
%setSvc% netman 3
::Workstation disabled
%setSvc% rdbss 4
%setSvc% KSecPkg 4
%setSvc% mrxsmb20 4
%setSvc% mrxsmb 4
%setSvc% srv2 4
%setSvc% LanmanWorkstation 4

:: disable fault tolerant heap
:: https://docs.microsoft.com/en-us/windows/win32/win7appqual/fault-tolerant-heap
:: doc listed as only affected in windows 7, is also in 7+
reg add "HKLM\SOFTWARE\Microsoft\FTH" /v "Enabled" /t REG_DWORD /d "0" /f

:: enable file system mitigations (default)
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager" /v "ProtectionMode" /t REG_DWORD /d "1" /f

:: unpin all quick access shortcuts by default
reg add "HKCU\Control Panel\Quick Actions\Control Center\Unpinned" /v "Microsoft.QuickAction.WiFi" /t REG_NONE /d "" /f
reg add "HKCU\Control Panel\Quick Actions\Control Center\Unpinned" /v "Microsoft.QuickAction.AllSettings" /t REG_NONE /d "" /f
reg add "HKCU\Control Panel\Quick Actions\Control Center\Unpinned" /v "Microsoft.QuickAction.BlueLightReduction" /t REG_NONE /d "" /f
reg add "HKCU\Control Panel\Quick Actions\Control Center\Unpinned" /v "Microsoft.QuickAction.AvailableNetworks" /t REG_NONE /d "" /f
reg add "HKCU\Control Panel\Quick Actions\Control Center\Unpinned" /v "Microsoft.QuickAction.Location" /t REG_NONE /d "" /f
reg add "HKCU\Control Panel\Quick Actions\Control Center\Unpinned" /v "Microsoft.QuickAction.Connect" /t REG_NONE /d "" /f
reg add "HKCU\Control Panel\Quick Actions\Control Center\Unpinned" /v "Microsoft.QuickAction.QuietHours" /t REG_NONE /d "" /f
reg add "HKCU\Control Panel\Quick Actions\Control Center\Unpinned" /v "Microsoft.QuickAction.ScreenClipping" /t REG_NONE /d "" /f
reg add "HKCU\Control Panel\Quick Actions\Control Center\Unpinned" /v "Microsoft.QuickAction.Vpn" /t REG_NONE /d "" /f
reg add "HKCU\Control Panel\Quick Actions\Control Center\Unpinned" /v "Microsoft.QuickAction.Project" /t REG_NONE /d "" /f


:: hmm interesting 
:: set Win32PrioritySeparation to short variable 1:1, no foreground boost
reg add "HKLM\SYSTEM\CurrentControlSet\Control\PriorityControl" /v "Win32PrioritySeparation" /t REG_DWORD /d "36" /f


:: Block new Outlook
reg delete \"HKEY_LOCAL_MACHINE\\SOFTWARE\\Microsoft\\WindowsUpdate\\Orchestrator\\UScheduler_Oobe\\OutlookUpdate\" /f


:: - harden process mitigations (lower compatibilty for legacy apps) 
:: This is way to strict.
:: %powshcmd% "Set-ProcessMitigation -System -Enable DEP, EmulateAtlThunks, RequireInfo, BottomUp, HighEntropy, StrictHandle, CFG, StrictCFG, SuppressExports, SEHOP, AuditSEHOP, SEHOPTelemetry, ForceRelocateImages"
:: Try maybe?
:: %powshcmd% "Set-ProcessMitigation -System -Enable DEP, EmulateAtlThunks, RequireInfo, BottomUp, HighEntropy, StrictHandle, SuppressExports, SEHOP, AuditSEHOP, SEHOPTelemetry, ForceRelocateImages, AuditMicrosoftSigned, AuditStoreSigned, EnforceModuleDependencySigning, DisableNonSystemFonts, AuditFont"
:: Set these tested settings for now
:: %powshcmd% "Set-ProcessMitigation -System -Enable DEP, EmulateAtlThunks"
:: The following might work without being too strict
:: %powshcmd% "Set-ProcessMitigation -System -Enable DEP, EmulateAtlThunks, RequireInfo, BottomUp, HighEntropy, StrictHandle, SuppressExports, SEHOP, AuditSEHOP, SEHOPTelemetry, AuditMicrosoftSigned, AuditStoreSigned, EnforceModuleDependencySigning, DisableNonSystemFonts, AuditFont"
:: After reading and learning that fonts can have executable code....
::						Data Execution Prevention (DEP)
::
:: notes - https://learn.microsoft.com/en-us/powershell/module/processmitigations/set-processmitigation?view=windowsserver2022-ps : 
:: Set-ProcessMitigation -System -Disable '...'
:: Set-ProcessMitigation -System -Reset
:: Reset Mitigation at the system level.

:: %powshcmd% "Set-ProcessMitigation -System -Enable DEP, BottomUp, EmulateAtlThunks, AuditMicrosoftSigned, AuditStoreSigned, DisableNonSystemFonts, AuditFont"
:: more notes - https://learn.microsoft.com/en-us/defender-endpoint/enable-exploit-protection :
:: The following might work without being too strict

:: Works, but not very user friendly... Make this optional .. are you set up for 'work' or 'modern' gaming?
:: %powshcmd% "Set-ProcessMitigation -System -Enable DEP, EmulateAtlThunks, RequireInfo, BottomUp, HighEntropy, StrictHandle, SuppressExports, SEHOP, AuditMicrosoftSigned, AuditStoreSigned, EnforceModuleDependencySigning, DisableNonSystemFonts, AuditFont, EnableRopStackPivot"
:: so land on this for now. 
 %powshcmd% "Set-ProcessMitigation -System -Enable DEP, EmulateAtlThunks, RequireInfo, BottomUp, HighEntropy, CFG, SEHOP,  AuditSEHOP, SEHOPTelemetry, DisableNonSystemFonts, AuditFontAuditMicrosoftSigned, AuditStoreSigned, EnableRopStackPivot"
:: disable data execution prevention (DEP) may need to enable for faceit, valorant and other anti-cheats


bcdedit /set nx Optin

:: Keep this in mind as i maanged to get in a sticky place with a windows account and these hardenings
:: detect if user is using a microsoft account
:: %PowerShell% "Get-LocalUser | Select-Object Name,PrincipalSource" | findstr /C:"MicrosoftAccount" > nul 2>&1 && set MSACCOUNT=YES || set MSACCOUNT=NO
:: if "%MSACCOUNT%"=="NO" ( %setSvc% wlidsvc 4 ) ELSE ( echo "Microsoft Account detected, not disabling wlidsvc..." )
:: choice /c yn /m "Last warning, continue? [Y/N]" /n
::sc stop TabletInputService
::%setSvc% TabletInputService 4


@echo on

echo Disablng WMP and IE, enable Hyper-V and WSL
 DISM /Online /Disable-Feature /FeatureName:WindowsMediaPlayer /norestart
 DISM /Online /Disable-Feature /FeatureName:Internet-Explorer-Optional-amd64 /norestart
 DISM /Online /Disable-Feature /FeatureName:Internet-Explorer-Optional-x86 /norestart
 
 DISM /Online /Enable-Feature /featurename:Microsoft-Hyper-V /Quiet /NoRestart
 DISM /online /enable-feature /featurename:HypervisorPlatform /all /norestart
 DISM /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
 DISM /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
:: %powshcmd% Enable-WindowsOptionalFeature applicaonalFeature -Online -FeatureName VirtualMachinePlatform -NoRestart
:: %powshcmd% wsl --set-default-version 2

 :: Enable full context menu - Windows 11
 reg add "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" /f /ve

%powshadmcmd% "%altanosdir%\src\harden.ps1"
:: https://learn.microsoft.com/en-us/defender-endpoint/attack-surface-reduction-rules-reference
%powshadmcmd% "%altanosdir%\wdegc\Enable-ExploitGuard-AttackSurfaceReduction.ps1"

 :: echo info: cleaning the winsxs folder - bah this needs to be done after a reboot 
 :: DISM /Online /Cleanup-Image /StartComponentCleanup /ResetBase /RestoreHealth

 sfc /SCANNOW
 :: ask and make user aware this will trash connectivity...
 :: echo Remember to configure the TinyWall firewall, select autolearn from the menu for a while for instance to allo traffic
 :: %msipkg% %altanosinstdir%\TinyWall-v3-Installer.msi

::

:: enable system devices
::  DevManView.exe /enable "Microsoft Hyper-V NT Kernel Integration VSP"
::  DevManView.exe /enable "Microsoft Hyper-V PCI Server"
::  DevManView.exe /enable "Microsoft Hyper-V Virtual Disk Server"
::  DevManView.exe /enable "Microsoft Hyper-V Virtual Machine Bus Provider"
::  DevManView.exe /enable "Microsoft Hyper-V Virtualization Infrastructure Driver"


:: reset the admin password prompt, a value of 1 on here on the admin account will require password to be entered. 2 is a prompt.
:: %powshcmd% Set-ItemProperty -Path REGISTRY::HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System -Name ConsentPromptBehaviorAdmin -Value 1
 echo All done, pausing to review what might have gone astray.

pause
