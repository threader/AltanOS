$sysdrive =  $Env:SystemDrive
$altanosdir = "$sysdrive\AltanOS"
$altanosinstdir = "$sysdrive\AltanOS.inst"
# Put som paths and url's here eventually



if (-not (Test-Path -Path $altanosinstdir)) {
	mkdir -p $altanosinstdir\bin
}
Set-Location $altanosdir
# cd $altanosdir

function Get-Machine-Architecture() {
  #  Say-Invocation $MyInvocation

    # On PS x86, PROCESSOR_ARCHITECTURE reports x86 even on x64 systems.
    # To get the correct architecture, we need to use PROCESSOR_ARCHITEW6432.
    # PS x64 doesn't define this, so we fall back to PROCESSOR_ARCHITECTURE.
    # Possible values: amd64, x64, x86, arm64, arm
    if( $ENV:PROCESSOR_ARCHITEW6432 -ne $null ) {
        return $ENV:PROCESSOR_ARCHITEW6432
    }

    try {        
        if( ((Get-CimInstance -ClassName CIM_OperatingSystem).OSArchitecture) -like "ARM*") {
            if( [Environment]::Is64BitOperatingSystem )
            {
                return "arm64"
            }  
            return "arm"
        }
    }
    catch {
        # Machine doesn't support Get-CimInstance
    }

    return $ENV:PROCESSOR_ARCHITECTURE
}

 $ProgressPreference = 'SilentlyContinue'
 
	    if(-not ( Get-Machine-Architecture -eq "AMD64")) {
	    Write-Output "Assume x86"
	    	 Invoke-WebRequest -Uri "https://github.com/radareorg/radare2/releases/download/5.9.4/radare2-5.9.4-w32.zip" -OutFile "$altanosinstdir\radare2-5.9.4-w64.zip"
			
			 Expand-Archive -Force $altanosinstdir\adare2-5.9.4-w32.zip $altanosinstdir\bin\radare2-5.9.4-w32
		$niarchbit = ""
		 } else  {
		 $niarchbit = "-64"
		
			Invoke-WebRequest -Uri "https://malcat.fr/latest/malcat_win64_lite.zip" -OutFile "$altanosinstdir\malcat_win64_lite.zip"
			Invoke-WebRequest -Uri "https://github.com/radareorg/radare2/releases/download/5.9.4/radare2-5.9.4-w32.zip" -OutFile "$altanosinstdir\radare2-5.9.4-w64.zip"
			
			 Expand-Archive -Force "$altanosinstdir\alcat_win64_lite.zip" "$altanosinstdir\bin\malcat_win64_lite"
			 Expand-Archive -Force "$altanosinstdir\adare2-5.9.4-w64.zip" "$altanosinstdir\bin\radare2-5.9.4-w64"
		 }
	# get dev tools
 Invoke-WebRequest -uri "https://github.com/NationalSecurityAgency/ghidra/releases/download/Ghidra_11.1.2_build/ghidra_11.1.2_PUBLIC_20240709.zip" -OutFile "$altanosinstdir\ghidra_11.1.2_PUBLIC_20240709.zip"
 Expand-Archive -Force "$altanosinstdir\ghidra_11.1.2_PUBLIC_20240709.zip" "$altanosinstdir\bin\ghidra_11.1.2_PUBLIC_20240709"

function get_utils() {

s Invoke-WebRequest -uri "https://downloads.malwarebytes.com/file/adwcleaner" -OutFile "$altanosinstdir\bin\adwcleaner.exe"
 "$altanosinstdir"\bin\adwcleaner.exe

 Invoke-WebRequest -uri "https://tinywall.pados.hu/files/TinyWall-v3-Installer.msi" -OutFile "$altanosinstdir\TinyWall-v3-Installer.msi"

 Invoke-WebRequest -uri "http://www.itsamples.com/downloads/network-activity-indicator-setup$niarchbit.zip" -OutFile "$altanosinstdir\network-indicator$niarchbit.zip"

 Invoke-WebRequest -uri "https://privazer.com/en/PrivaZer.exe" -OutFile "$altanosinstdir\bin\PrivaZer.exe"

 cp $altanosdir\bin\PrivaZer.ini $altanosinstdir\bin\

 Expand-Archive -Force "$altanosinstdir\network-indicator$niarchbit.zip" "$altanosinstdir\bin\network-indicator$niarchbit"
}
get_utils

$ProgressPreference = 'Continue' 
