$sysdrive =  $Env:SystemDrive
$get_date = Get-Date -Format "dddd-MM-dd-yyyy-HH-mm"
New-WindowsImage -ImagePath "$sysdrive\AltanOS.wim\altanos-$get_date.wim" -CapturePath "$sysdrive" -Name "$sysdrive_wim" -SupportEa -Setbootable -WIMBoot -Verify

Read-Host -Prompt "Press any key to continue"
