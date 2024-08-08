Write-Output "Running AwdCleaner"

$sysdrive =  ((Get-Location).Path.Split("\")).Get(0)
$altanosdir = "$sysdrive\AltanOS"
$altanosinstdir = "$sysdrive\AltanOS.inst"

Invoke-WebRequest -uri https://downloads.malwarebytes.com/file/adwcleaner -OutFile $altanosinstdir\bin\adwcleaner.exe

$altanosinstdir\bin\AwdCleaner.exe


Set-ExecutionPolicy -ExecutionPolicy Restricted
