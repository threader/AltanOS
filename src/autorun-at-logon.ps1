$sysdrive =  $Env:SystemDrive
$altanosdir = "$sysdrive\AltanOS\"

sysmon.exe -i -accepteula "$altanosdir\sysmon-config\sysmonconfig-export-block-loldrivers.xml"
:: Renamed Driver ... The driver file and registry entry are renamed. Name has an 8-character lim
sysmon.exe -i -d sumonmon
:: Renamed service
::sysmon.exe -i -d sumonmon

Set-ExecutionPolicy -ExecutionPolicy Restricted
