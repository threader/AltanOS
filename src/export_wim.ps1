$sysdrive =  $Env:SystemDrive
$altanosinstdir = "$sysdrive\AltanOS\"
$awimacfg = "$altanosinstdir\bin\WimScript.ini"

$awimadir = "$sysdrive\AltanOS.wim"

function awimawhe() {

$get_date = Get-Date -Format "HHmm-MM-dd-yyyy"

$awimprefix = Write-Output "altanos-$get_date"
Write-Output $awimprefix

$hashfile = "$awimadir\hash.output.old.txt"
$hashfilenew = "$awimadir\hash.output.$awimprefix.new.txt"
$hashfileold = "$awimadir\hash.output.$awimprefix.old.txt"

if (-not (Test-Path -Path $hashfilenew)) {
$hashfileout = $hashfile
$hashfilenew = $null
        } else {
$hashfileout = $hashfilenew
        }
        

$awim = "$awimadir\$awimprefix.wim"

$rsapriv = "$awimadir\$awimprefix.priv.txt"
$rsapub = "$awimadir\$awimprefix.pub.txt"

# Add local admin/user/online for .wim

# $local_usr = write-output $Env:UserName
# if (-not (Test-Path -Path $local_usr-usr)) {
# net user /ADD $local_usr-adm
# net user /ADD $local_usr-usr
# net user /ADD $local_usr-online

# Aaaand this depends on the language of the system. run 'net localgroup'
# net localgroup Administartors user /ADD $local_usr-adm
# }

# Only include new users in exported WIM
# write-output $Env:HomePath >> ../bin/WimScript.ini
 
# huh - https://learn.microsoft.com/en-us/dotnet/api/system.security.cryptography.rsa.exportrsaprivatekeypem?view=net-9.0#system-security-cryptography-rsa-exportrsaprivatekeypem 
# https://learn.microsoft.com/en-us/dotnet/api/system.security.cryptography.rsacryptoserviceprovider?view=net-9.0
#
# $rsa = New-Object -TypeName System.Security.Cryptography.RSACryptoServiceProvider(2048)
# $rsa.ExportRSAPrivateKeyPem() | Out-File -FilePath '$rsapriv'
# $rsa.ExportRSAPublicKeyPem() | Out-File -FilePath '$rsapub'

	$sha256 = New-Object -TypeName System.Security.Cryptography.SHA256CryptoServiceProvider
	#$hash = [System.BitConverter]::ToString($sha256.ComputeHash([System.IO.File]::ReadAllBytes("$awimadir\$awimprefix*.pub.txt"))).Replace("-","")
	Write-Output "$altanoswimloc $algo $hash"
	#Out-File -FilePath $hashfileout -InputObject $hash
	

# New-WindowsImage -ImagePath "$awim" -CapturePath "$sysdrive" -CompressionType "None" -ConfigFilePath $awimacfg -Name "$awimprefix"  -SupportEa -Setbootable -WIMBoot -Verify
	Write-Output   "$awim  $sysdrive  $awimacfg  $awimprefix"
	New-WindowsImage -ImagePath $awim -CapturePath $sysdrive -ConfigFilePath $awimacfg -Name $awimprefix -SupportEa -WIMBoot -Verify

	$sha256 = New-Object -TypeName System.Security.Cryptography.SHA256CryptoServiceProvider

    	$Stream = [System.IO.FileStream]::new($awim, [System.IO.FileMode]::Open, [System.IO.FileAccess]::Read, 
        [System.IO.FileShare]::Read, 1MB, [System.IO.FileOptions]::SequentialScan)
	$hash = [System.BitConverter]::ToString($sha256.ComputeHash($Stream)).Replace("-","").ToLower()
	Write-Output "$altanoswimloc $algo $hash"
	Out-File -FilePath $hashfileout -InputObject $hash -Append

#New-WindowsImage -ImagePath "$awim" -CapturePath "$sysdrive" -CompressionType "None" -ConfigFilePath $awimusracfg -Name "$awimprefix_$sysdrive_user_wim" -SupportEa -Setbootable -WIMBoot -Verify

pause 
break
if (-not (Test-Path $hashfile)) {
  cp $hashfileout $hashfile
	} else {
  cp $hashfileout $hashfileold
  }

}
awimawhe

Read-Host -Prompt "Press any key to continue"
