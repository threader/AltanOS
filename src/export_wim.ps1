$sysdrive =  $Env:SystemDrive
$altanosinstdir = $sysdrive\AltanOS\
$awimacfg = $altanosinstdir\bin\WimScript.ini

$awimadir = $sysdrive\AltanOS.wim

function awimawhe() {

$awimprefix = altanos-$get_date

$get_date = Get-Date -Format "dddd-MM-dd-yyyy-HH-mm"
$hashfile = "$awimadir\hash.output.$awimprefix.txt"
$hashfilenew = "$awimadir\hash.output.new.$awimprefix.txt"

if (-not (Test-Path -Path $hashfilenew)) {
$hashfileout = $hashfile
$hashfilenew = $null
        } else {
$hashfileout = $hashfilenew
        }
        

$awim = $awimadir\$awimprefix.wim

$rsapriv = $awimadir\$awimprefix.priv.txt
$rsapub = $awimadir\$awimprefix.pub.txt


$rsa = New-Object System.Security.Cryptography.RSACryptoServiceProvider(2048)
$rsa.ExportRSAPrivateKeyPem() | Out-File -FilePath '$rsapriv'
$rsa.ExportRSAPublicKeyPem() | Out-File -FilePath '$rsapub'

	$sha256 = New-Object -TypeName System.Security.Cryptography.SHA256CryptoServiceProvider
	$hash = [System.BitConverter]::ToString($sha256.ComputeHash([System.IO.File]::ReadAllBytes($awimadir\$awimprefix*.pub.txt))).Replace("-","")
	Write-Output "$altanoswimloc $algo: $hash"
	Out-File -FilePath $hashfileout -InputObject $hash
	

New-WindowsImage -ImagePath "$awim" -CapturePath "$sysdrive" -CompressionType "None" -ConfigFilePath $awimacfg -Name "$awimprefix_$sysdrive_wim" -SupportEa -Setbootable -WIMBoot -Verify

	$sha256 = New-Object -TypeName System.Security.Cryptography.SHA256CryptoServiceProvider
	$hash = [System.BitConverter]::ToString($sha256.ComputeHash([System.IO.File]::ReadAllBytes($awim))).Replace("-","")
	Write-Output "$altanoswimloc $algo: $hash"
	Out-File -FilePath $hashfileout -InputObject $hash -Append

#New-WindowsImage -ImagePath "$awim" -CapturePath "$sysdrive" -CompressionType "None" -ConfigFilePath $awimusracfg -Name "$awimprefix_$sysdrive_user_wim" -SupportEa -Setbootable -WIMBoot -Verify


}
awimawhe

Read-Host -Prompt "Press any key to continue"
