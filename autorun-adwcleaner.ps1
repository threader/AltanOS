Write-Output "Running AwdCleaner"

$sysdrive =  ((Get-Location).Path.Split("\")).Get(0)
$altanosdir = "$sysdrive\AltanOS"
$altanosinstdir = "$sysdrive\AltanOS.inst"

$altanosinstdir\bin\AwdCleaner.exe


 Set-ExecutionPolicy -ExecutionPolicy Restricted
