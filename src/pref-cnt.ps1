$sysdrive =  $Env:SystemDrive
cd $sysdrive
cd $Env:windir\system32
lodctr /r
cd $Env:windir\sysWOW64
lodctr /r 
winmgmt /resyncperf  
Get-Service -Name "pla" | Restart-Service -Verbose 
Get-Service -Name "winmgmt" | Restart-Service -Force -Verbose 
