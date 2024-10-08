# Well, ofc, this too i added yesterday after fixing and testing went AWOL...
# the thought here is to use the '[System.BitConverter]::ToString($md5.ComputeHash([System.IO.File]::ReadAllBytes($_))).Replace("-","") '
# that works around the 4gb limit of (Get-FileHash $_).hash) etc. and is compatible with old? powershell versions too?
# this ofc needs to be changed to at least sha256, maybe depending on the config and needs... 
# But, build a list of *.wim *.iso *.img *.vhd *.whatever and store it somewhere is the point here, even if that means 
# booting some miniature .wim from un-encrypted. and storing the file hashes twice, or more ... before continuing to encrypted, or not. 

# If (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator))
# {
  # Relaunch as an elevated process:
#  Start-Process powershell.exe "-File",('"{0}"' -f $MyInvocation.MyCommand.Path) -Verb RunAs
#  exit
#}
# Now running elevated so launch the script:
#& "d:\long path name\script name.ps1" "Long Argument 1" "Long Argument 2"

Write-Output "Workaround read only NVRAM or in my case a hacked BIOS with hardcoded defaults and an early version EFI." 
pause

$msefi = 'W:\EFI\Microsoft\Boot\bootmgfw.efi'
$MsRepEfiFile = "W:\EFI\Microsoft\Boot\bootmgfww.efi"
$MsBakEfiFile = "W:\EFI\Microsoft\Boot\bootmgfw.efi.bak"

if (-not (Test-Path $msefi)) {
Write-Output "Mounting EFI to W:"
mountvol w: /S
}

$checkforstring = (Get-ChildItem -Path $msefi| Select-Object -First 1).fullname
if ($checkforstring) {
    $search = (Get-Content $checkforstring | Select-String -Pattern 'Microsoft Corporation').Matches.Success
    if($search) {
        Write-output "$msefi contians the string Microsoft Corporation proceeding."
        $ask = Read-Host -Prompt "Continue and copy $msefi to $MsRepEfiFile and .bak?[y/n]"
        if ( $ask -eq 'y' ) {
         cp $msefi $MsBakEfiFile
         cp $msefi $MsRepEfiFile
		}
    } else {
        Write-output "$msefi does not contian the string 'Microsoft Corporation'."
        $ask = Read-Host -Prompt "Continue to check/update GRUB?[y/n]"
         if ( $ask -eq 'n' ) {
			pause
			break
		}
    }
} else {
    "No file: $msefi"
	pause
    break
}

$GrubForMsEfiLoc = $null

write-output "Locate signed or unsigned Secure Boot shim*.efi* and grub*.efi* files and path:"
$GrubEfiSecFileLoc = Get-ChildItem –Path W:\EFI -include shim*.efi -Force -Recurse |
		? FullName -notLike 'W:\EFI\Microsoft\Boot\shim*.efi*' |
				Get-ChildItem -File -Force |
				select-object -Expand FullName
	# Write-output "Found: $GrubEfiSecFileLoc" 

	$GrubPwd = Split-Path -Path "$GrubEfiSecFileLoc" -Parent
	
	if (Test-Path "$GrubPwd\shim*.efi") {
        $ask = Read-Host -Prompt "Found unsigned Secure Boot GRUB $GrubEfiSecFileLoc, use this file?[y/n]"
			if ( $ask -eq 'y' ) {
				$GrubForMsEfiLoc = Resolve-Path -Path $GrubPwd\shim*.efi
				write-output "Using unsigned GRUB EFI: $GrubForMsEfiLoc"
			}
	}
				
	if (Test-Path "$GrubPwd\shim*.efi.*") { 
		$ask = Read-Host -Prompt "Found Microsoft signed Secure Boot GRUB $GrubEfiSecFileLoc, use this file?[y/n]"
			if ( $ask -eq 'y' ) {
				$GrubForMsEfiLoc = Resolve-Path -Path $GrubPwd\shim*.efi.*
				write-output "Using signed GRUB EFI : $GrubForMsEfiLoc"
			}
	}

$GrubEfiFileLoc = Get-ChildItem –Path W:\EFI -include grub*.efi -Force -Recurse |
		? FullName -notLike 'W:\EFI\Microsoft\Boot\grub*.efi*' |
				Get-ChildItem -File -Force |
				select-object -Expand FullName
	# Write-output "Found: $GrubEfiFileLoc"

	$GrubPwd = Split-Path -Path "$GrubEfiFileLoc" -Parent


	if (Test-Path "$GrubPwd\grub*.efi") {
		$ask = Read-Host -Prompt "Found unsigned GRUB boot $GrubEfiFileLoc, use this file?[y/n]"
		if ( $ask -eq 'y' ) {
			$GrubForMsEfiLoc = Resolve-Path -Path $GrubPwd\grub*.efi
			write-output "Using unsigned GRUB EFI: $GrubForMsEfiLoc"
		}
	}

	if (Test-Path "$GrubPwd\grub*.efi.*") {
		$ask = Read-Host -Prompt "Found your Linux distributions signed GRUB $GrubEfiFileLoc, use this file?[y/n]"
		if ( $ask -eq 'y' ) {
			$GrubForMsEfiLoc = Resolve-Path -Path $GrubPwd\grub*.efi.*
			write-output "Using signed GRUB EFI: $GrubForMsEfiLoc"
		} 
	}

# add a choice for multiple distros 

	if ($null -eq $GrubForMsEfiLoc) {
		Write-Output "No GRUB EFI file found or selected. Aborting"
		pause
		break
	}
	write-output "GRUB location: $GrubPwd"

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
 if((Get-FileHash $hashfile).hash  -ne (Get-FileHash $hashfilenew).hash) {
 write-output "EFI file hashes are different replacing changed EFI files"

	if((Get-FileHash $msefi).hash  -ne (Get-FileHash $GrubForMsEfiLoc).hash) {
	 Write-Output "$GrubForMsEfiLoc differs from $msefi"
     write-output "Copying $GrubEfiFileLoc to $msefi and $GrubPwd to W:\EFI\Microsoft\Boot\."
   #  cp $msefi W:\EFI\Microsoft\Boot\
	 cp $GrubForMsEfiLoc $msefi
	 Copy-Item -Recurse -Force $GrubPwd\* W:\EFI\Microsoft\Boot\
	} else { 
	 Write-Output "$GrubForMsEfiLoc is equal to $msefi" 
    }

  cp $hashfileout $hashfile

	} else {
	    Write-output  "$hashfile and $hashfilenew are the same file. Assume all is well."
    Write-output  "You should not be here"
		# $ask = Read-Host -Prompt "Copy $GrubForMsEfiLoc to $msefi etc. anyway?[y/n]"
		# if ( $ask -eq 'y' ) {
		# cp $GrubForMsEfiLoc $msefi
		# Copy-Item -Recurse -Force $GrubPwd\* W:\EFI\Microsoft\Boot\
		# }
	}
}
CompareHashFiles


Write-Output "All should be well"
pause
