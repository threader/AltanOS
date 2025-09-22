$sysdrive =  $Env:SystemDrive
$current_user_dir = $env:UserProfile

$altanosinstdir = $sysdrive\AltaOS.inst

$GET_BITLOCKER_VOLUME = Get-BitLockerVolume  | Where-Object { ($_.MountPoint) }
ForEach ($_ in $GET_BITLOCKER_VOLUME) {
Get-BitLockerVolume -MountPoint $_.Replace(":", "").KeyProtector >> $altanosinstdir\BitLocker_Recovery_Key.txt
}
