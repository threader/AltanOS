Write-Output "Running PrivaZer, this will delete residue in the NTFS journal, and write ZERO to the free disk space as well as remove temporary files everywhere."

$sysdrive =  ((Get-Location).Path.Split("\")).Get(0)
$altanosdir = "$sysdrive\AltanOS"
$altanosinstdir = "$sysdrive\AltanOS.inst"

$altanosinstdir\bin\PrivaZer.exe


 Set-ExecutionPolicy -ExecutionPolicy Restricted
