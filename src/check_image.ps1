# Well, ofc, this too i added yesterday after fixing and testing went AWOL...
# the thought here is to use the '[System.BitConverter]::ToString($sha256.ComputeHash([System.IO.File]::ReadAllBytes($_))).Replace("-","") '
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


$sysdrive =  $Env:SystemDrive
$altanoswimdir = $sysdrive\AltanOS.wim


Write-Output "This script will search $altanoswimdir for .wim files and put their SHA256 hases in a file." 
pause

if (-not (Test-Path $altanoswimdir)) {
Write-output "No directory $altanoswimdir"
pause
break
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



Write-Output "SHA256 compare $altanoswimloc" 

$get_date = Get-Date -Format "dddd-MM-dd-yyyy-HH-mm"

$hashfile = "$altanoswimdir\hash.output.txt"
$hashfilenew = "$altanoswimdir\hash.output.new.$get_date.txt"

if (-not (Test-Path -Path $hashfilenew)) {
$hashfileout = $hashfile
$hashfilenew = $null
        } else {
$hashfileout = $hashfilenew
        }

$altansearchwim = $null

write-output "Locate AltanOS-*.wim:"
$altansearchwim = Get-ChildItem -Path $altanoswimdir -include altanos-*.wim -Force -Recurse |
				Get-ChildItem -File -Force |
				select-object -Expand FullName
	Write-output "Found: $altanwimloc" 

	$altanoswimloc = Split-Path -Path "$altansearchwim" -Parent

	if (Test-Path "$altanoswimloc\altan-*.wim") {
	ForEach ($_ in $altanoswimloc) {
	$sha256 = New-Object -TypeName System.Security.Cryptography.SHA256CryptoServiceProvider
	$hash = [System.BitConverter]::ToString($sha256.ComputeHash([System.IO.File]::ReadAllBytes($_))).Replace("-","")
	Write-Output "$altanoswimloc $algo: $hash"
	Out-File -FilePath $hashfileout -InputObject $hash -Append
	}

#        $ask = Read-Host -Prompt "Found $altanoswimloc , use this file?[y/n]"
#			if ( $ask -eq 'y' ) {
#				$altansearchwim = Resolve-Path -Path $altanoswimloc\altanos-*.wim
#				write-output "Using: $altansearchwim"
#			}

	}

	if ($null -eq $altansearchwim) {
		Write-Output "No WIM file found or selected. Aborting"
		pause
		break
	}
	write-output "WIM location: $altanoswimloc"


function CompareHashFiles() {
$algo = "-Algorithm SHA512"
$file_path = $null
$litteral_path = $null

 if((Get-FileHash $hashfile).hash  -ne (Get-FileHash $hashfilenew).hash) {
 write-output "WIM file hashes have changed"

#	if((Get-FileHash $msefi).hash  -ne (Get-FileHash $GrubForMsEfiLoc).hash) {
#	 Write-Output "$GrubForMsEfiLoc differs from $msefi"
#     write-output "Copying $GrubEfiFileLoc to $msefi and $GrubPwd to W:\EFI\Microsoft\Boot\."
   #  cp $msefi W:\EFI\Microsoft\Boot\
	 cp $GrubForMsEfiLoc $msefi
#	 Copy-Item -Recurse -Force $GrubPwd\* W:\EFI\Microsoft\Boot\
	} else { 
#	 Write-Output "$GrubForMsEfiLoc is equal to $msefi" 
 #   }

  cp $hashfileout $hashfile

#	} else {
#	    Write-output  "$hashfile and $hashfilenew are the same file. Assume all is well."
#    Write-output  "You should not be here"
		# $ask = Read-Host -Prompt "Copy $GrubForMsEfiLoc to $msefi etc. anyway?[y/n]"
		# if ( $ask -eq 'y' ) {
		# cp $GrubForMsEfiLoc $msefi
		# Copy-Item -Recurse -Force $GrubPwd\* W:\EFI\Microsoft\Boot\
		# }
#	}
}
CompareHashFiles


Write-Output "All should be well"

Read-Host -Prompt "Press any key to continue"
pause
