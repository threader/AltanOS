 Read-Host -Prompt " yyy" 
$sysdrive =  $Env:SystemDrive
 Read-Host -Prompt "This will remove all removable Windows packages on the system"
cd $sysdrive
cd $Env:windir\system32
lodctr /r
cd $Env:windir\sysWOW64
lodctr /r 
winmgmt /resyncperf  
Get-Service -Name "pla" | Restart-Service -Verbose 
Get-Service -Name "winmgmt" | Restart-Service -Force -Verbose 
