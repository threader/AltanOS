Write-Output "Basic maintainance of Windows."

 DISM /Online /Cleanup-Image /StartComponentCleanup /ResetBase /RestoreHealth
 sfc /SCANNOW
 
 Set-ExecutionPolicy -ExecutionPolicy Restricted
 
 Read-Host -Prompt "Press any key to continue."
