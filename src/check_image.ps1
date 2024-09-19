
Write-Output "MD5 compare W:\EFI\*.efi" 

$hashfile = "W:\hash.output.txt"
$hashfilenew = "W:\hash.output.new.txt"

if (-not (Test-Path -Path $hashfilenew)) {
$hashfileout = $hashfile
$hashfilenew = $null
        } else {
$hashfileout = $hashfilenew
        }

Write-Output "Writing file hashes to: $hashfileout"

function MD5HashEfi() {
$md5 = New-Object -TypeName System.Security.Cryptography.MD5CryptoServiceProvider

	$hash = [System.BitConverter]::ToString($md5.ComputeHash([System.IO.File]::ReadAllBytes($msefi))).Replace("-","")
	Write-Output "$msefi MD5: $hash"
	Out-File -FilePath $hashfileout -InputObject $hash 

	$hash = [System.BitConverter]::ToString($md5.ComputeHash([System.IO.File]::ReadAllBytes($MsRepEfiFile))).Replace("-","")
	Write-Output "$MsRepEfiFile MD5: $hash"
	Out-File -FilePath $hashfileout -InputObject $hash -Append

	$hash = [System.BitConverter]::ToString($md5.ComputeHash([System.IO.File]::ReadAllBytes($GrubForMsEfiLoc))).Replace("-","")
	Write-Output "$GrubForMsEfiLoc MD5: $hash"
	Out-File -FilePath $hashfileout -InputObject $hash -Append

}
MD5HashEfi

function CompareHashFiles() {
# if((Get-FileHash $hashfile).hash  -ne (Get-FileHash $hashfilenew).hash) {
# write-output "EFI file hashes are different replacing changed EFI files"

	if((Get-FileHash $msefi).hash  -ne (Get-FileHash $GrubForMsEfiLoc).hash) {
	 Write-Output "$GrubForMsEfiLoc differs from $msefi"
     write-output "Copying $GrubEfiFileLoc to $msefi and $GrubPwd to W:\EFI\Microsoft\Boot\."
	 cp $GrubForMsEfiLoc $msefi
	 Copy-Item -Recurse -Force $GrubPwd\* W:\EFI\Microsoft\Boot\
	} else { 
	 Write-Output "$GrubForMsEfiLoc is equal to $msefi" 
    }

  cp $hashfileout $hashfile

	} else {
	    Write-output  "$hashfile and $hashfilenew are the same file. Assume all is well."
    Write-output  "You should not be here"
		$ask = Read-Host -Prompt "Copy $GrubForMsEfiLoc to $msefi etc. anyway?[y/n]"
		if ( $ask -eq 'y' ) {
		 cp $GrubForMsEfiLoc $msefi
		 Copy-Item -Recurse -Force $GrubPwd\* W:\EFI\Microsoft\Boot\
		}
	}
}
CompareHashFiles
