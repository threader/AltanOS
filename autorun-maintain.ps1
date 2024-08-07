Write-Output "Basic maintainance of Windows."

 sfc /SCANNOW
 DISM /Online /Cleanup-Image /StartComponentCleanup /ResetBase /RestoreHealth
 
 Set-ExecutionPolicy -ExecutionPolicy Restricted
 
 Read-Host -Prompt "Press any key to continue."
