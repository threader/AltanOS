Get-AppPackage -AllUsers | Remove-AppPackage -AllUsers
 
function enable_win_packages() {
 Get-AppxPackage -allusers Microsoft.VCLibs* | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
 Get-AppxPackage -allusers Microsoft.NET.CoreRuntime* | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
 Get-AppxPackage -allusers Microsoft.NET.Native* | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
 Get-AppxPackage -allusers Microsoft.NET.Native.Runtime* | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
 Get-AppxPackage -allusers Microsoft.NET.Native.Framework.1.7* | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
 Get-AppxPackage -allusers Microsoft.NET.Native.Framework.2.2* | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
 Get-AppxPackage -allusers Microsoft.UI.Xaml* | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
 Get-AppxPackage -allusers Microsoft.PackageManagement.NuGetProvider* | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
 Get-AppxPackage -allusers Microsoft.UI.Xaml.2.7* | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
 Get-AppxPackage -allusers Microsoft.UI.Xaml.2.8* | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
 Get-AppxPackage -allusers Microsoft.WindowsStore* | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
 Get-AppxPackage -allusers Microsoft.StorePurchaseApp* | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
## Get-AppxPackage -allusers Microsoft.MicrosoftOfficeHub* | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
 Get-AppxPackage -allusers Microsoft.WindowsCalculator* | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
 Get-AppxPackage -allusers Microsoft.MSPaint* | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
 Get-AppxPackage -allusers Microsoft.MicrosoftSolitaireCollection* | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
}
enable_win_packages

 Get-AppXProvisionedPackage -online | Where-Object { ($_.PackageName) -and ($_.PackageName -notlike "Microsoft.DesktopAppInstaller*") -and ($_.PackageName -notlike "Microsoft.HEIFImageExtension*") -and ($_.PackageName -notlike "Microsoft.MicrosoftSolitaireCollection*") -and ($_.PackageName -notlike "Microsoft.MSPaint*") -and ($_.PackageName -notlike "Microsoft.MicrosoftStickyNotes") -and ($_.PackageName -notlike "Microsoft.Windows.Photos*") -and ($_.PackageName -notlike "Microsoft.MicrosoftEdge*") -and ($_.PackageName -notlike "Microsoft.StorePurchaseApp*") -and ($_.PackageName -notlike "Microsoft.VP9*") -and ($_.PackageName -notlike "Microsoft.VP9VideoExtensions*") -and ($_.PackageName -notlike "Microsoft.Web*Extension*") -and ($_.PackageName -notlike "Microsoft.Wallet*") -and ($_.PackageName -notlike "Microsoft.Windows.DevHome*") -and ($_.PackageName -notlike "Microsoft.WindowsStore*") -and ($_.PackageName -notlike "Microsoft.WindowsMaps*")  -and ($_.PackageName -notlike "Microsoft.WindowsSoundRecorder*") -and ($_.PackageName -notlike "Microsoft.VCLibs*") -and ($_.PackageName -notlike "Microsoft.VP9VideoEstension*") -and ($_.PackageName -notlike "Microsoft.Web*Extension*") -and ($_.PackageName -notlike "Microsoft.Wallet*") -and ($_.PackageName -notlike "Microsoft.Windows.DevHome*") -and ($_.PackageName -notlike "Microsoft.WindowsAlarms*") -and ($_.PackageName -notlike "Microsoft.WindowsCalculator*") | Remove-AppxProvisionedPackage -AllUsers -Online -PackageName  }

 $GET_APPXPPACKAGE = Get-AppXProvisionedPackage -online | Where-Object { ($_.PackageName) -and ($_.PackageName -notlike "Microsoft.DesktopAppInstaller*") -and ($_.PackageName -notlike "Microsoft.HEIFImageExtension*") -and ($_.PackageName -notlike "Microsoft.MicrosoftSolitaireCollection*") -and ($_.PackageName -notlike "Microsoft.MSPaint*") -and ($_.PackageName -notlike "Microsoft.MicrosoftStickyNotes") -and ($_.PackageName -notlike "Microsoft.Windows.Photos*") -and ($_.PackageName -notlike "Microsoft.MicrosoftEdge*") -and ($_.PackageName -notlike "Microsoft.StorePurchaseApp*") -and ($_.PackageName -notlike "Microsoft.VP9*") -and ($_.PackageName -notlike "Microsoft.VP9VideoExtensions*") -and ($_.PackageName -notlike "Microsoft.Web*Extension*") -and ($_.PackageName -notlike "Microsoft.Wallet*") -and ($_.PackageName -notlike "Microsoft.Windows.DevHome*") -and ($_.PackageName -notlike "Microsoft.WindowsStore*") -and ($_.PackageName -notlike "Microsoft.WindowsMaps*")  -and ($_.PackageName -notlike "Microsoft.WindowsSoundRecorder*") -and ($_.PackageName -notlike "Microsoft.VCLibs*") -and ($_.PackageName -notlike "Microsoft.VP9VideoEstension*") -and ($_.PackageName -notlike "Microsoft.Web*Extension*") -and ($_.PackageName -notlike "Microsoft.Wallet*") -and ($_.PackageName -notlike "Microsoft.Windows.DevHome*") -and ($_.PackageName -notlike "Microsoft.WindowsAlarms*") -and ($_.PackageName -notlike "Microsoft.WindowsCalculator*") }
 $GET_APPXPPACKAGE_NAME = Write-Output $GET_APPXPPACKAGE.PackageName

 ForEach ($_ in $GET_APPXPPACKAGE_NAME) {
   Remove-AppxProvisionedPackage -AllUsers -Online -PackageName $GET_APPXPPACKAGE_NAME
}
