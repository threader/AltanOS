# Get-AppPackage -AllUsers | Remove-AppPackage -AllUsers # Try to be more spesific

 function disable_win_packages() {
 $GET_APPXPACKAGE = Get-AppxPackage -AllUsers | Where-Object { ($_.Name) -and ($_.Name -notlike "Microsoft.Winget.Source*") -and ($_.Name -notlike "Microsoft.WindoesAppRuntime*") -and ($_.Name -notlike "Microsoft.UI.Xaml*") -and ($_.Name -notlike "Microsoft.NET.Native.Runtime*") -and ($_.Name -notlike "Microsoft.NET.Native.Runtime*") -and ($_.Name -notlike "Microsoft.NET.Native.Framework.*") -and ($_.Name -notlike "Microsoft.NET.Native.Framework.1.7*") -and ($_.Name -notlike "Microsoft.NET.Native.Framework.2.2*") -and ($_.Name -notlike "Microsoft.UI.Xaml.2.8*")  -and ($_.Name -notlike "Microsoft.VCLibs.140.00.UWPDesktop*") -and ($_.Name -notlike "Microsoft.UI.Xaml.2.0*") -and ($_.Name -notlike "1527c705-839a-4832-9118-54dBd6a0c89") -and ($_.PackageName -notlike "c5e2524a-ea46-4f67-841f-6a9465d9d515") -and ($_.PackageName -notlike "E2A4F912-2574-4A75-9BB0-0D023378592B") -and ($_.PackageName -notlike "F46D4000-FD22-4DB4-AC8E-4E1DDDE828FE") -and ($_.PackageName -notlike "Microsoft.AccountsControl") -and ($_.PackageName -notlike "Microsoft.AsyncTextService") -and ($_.PackageName -notlike "Microsoft.CredDialogHost") -and ($_.PackageName -notlike "Microsoft.ECApp") -and ($_.PackageName -notlike "Microsoft.LockApp") -and ($_.PackageName -notlike "Microsoft.MicrosoftEdgeDevToolsClient") -and ($_.PackageName -notlike "Microsoft.Win32WebViewHos") -and ($_.PackageName -notlike "Microsoft.Windows.Apprep.ChxApp") -and ($_.PackageName -notlike "Microsoft.Windows.CallingShellApp") -and ($_.PackageName -notlike "Microsoft.Windows.CapturePicker") -and ($_.PackageName -notlike "Microsoft.Windows.PinningConfirmationDialog") -and ($_.PackageName -notlike "Microsoft.Windows.SecHealthUI") -and ($_.PackageName -notlike "Microsoft.Windows.XGpuEjectDialog") -and ($_.PackageName -notlike "NcsiUwpApp") -and ($_.PackageName -notlike "Windows.CBSPreview") -and ($_.PackageName -notlike "MicrosoftWindows.Client.CBS") -and ($_.PackageName -notlike "Microsoft.Windows.ContentDeliveryManager") -and ($_.PackageName -notlike "Microsoft.Windows.Search") -and ($_.PackageName -notlike "Microsoft.Windows.ShellExperienceHost") -and ($_.PackageName -notlike "Microsoft.Windows.StartMenuExperienceHost") -and ($_.PackageName -notlike "MicrosoftWindows.UndockedDevKit") -and ($_.PackageName -notlike "Microsoft.Windows.OOBENetworkCaptivePortal") -and ($_.PackageName -notlike "Microsoft.Windows.OOBENetworkConnectionFlow") -and ($_.PackageName -notlike "Microsoft.AAD.BrokerPlugin") -and ($_.PackageName -notlike "Microsoft.BioEnrollment") -and ($_.PackageName -notlike "Microsoft.Windows.CloudExperienceHost") -and ($_.PackageName -notlike "Windows.PrintDialog") -and ($_.PackageName -notlike "Microsoft.MicrosoftEdge.Stable") -and ($_.PackageName -notlike "windows.immersivecontrolpanel") -and ($_.PackageName -notlike "Microsoft.Windows.NarratorQuickStart") -and ($_.PackageName -notlike "Microsoft.Windows.ParentalControls")-and ($_.PackageName -notlike "Microsoft.Windows.PeopleExperienceHost")-and ($_.PackageName -notlike "Microsoft.Windows.OOBENetworkCaptivePortal") -and ($_.PackageName -notlike "Microsoft.Windows.Search") -and ($_.PackageName -notlike "Microsoft.Windows.CloudExperienceHost") -and ($_.PackageName -notlike "Microsoft.MicrosoftEdge") -and ($_.Name -notlike "Microsoft.DesktopAppInstaller*") -and ($_.Name -notlike "Microsoft.MicrosoftSolitaireCollection*") -and ($_.Name -notlike "Microsoft.MSPaint*") -and ($_.Name -notlike "Microsoft.Service.Store**") -and ($_.Name -notlike "Microsoft.MicrosoftStickyNotes") -and ($_.Name -notlike "Microsoft.Windows.Photos*") -and ($_.Name -notlike "Microsoft.MicrosoftEdge*") -and ($_.Name -notlike "Microsoft.StorePurchaseApp*") -and ($_.Name -notlike "Microsoft.VP9*") -and ($_.Name -notlike "Microsoft.VP9VideoExtensions*") -and ($_.Name -notlike "Microsoft.Web*Extension*") -and ($_.Name -notlike "Microsoft.Wallet*") -and ($_.Name -notlike "Microsoft.Windows.DevHome*") -and ($_.Name -notlike "Microsoft.WindowsStore*") -and ($_.Name -notlike "Microsoft.WindowsMaps*")  -and ($_.Name -notlike "Microsoft.WindowsSoundRecorder*") -and ($_.Name -notlike "Microsoft.VCLibs*") -and ($_.Name -notlike "Microsoft.VP9VideoEstension*") -and ($_.Name -notlike "Microsoft.Web*Extension*") -and ($_.Name -notlike "Microsoft.Wallet*") -and ($_.Name -notlike "Microsoft.Windows.DevHome*") -and ($_.Name -notlike "Microsoft.WindowsAlarms*") -and ($_.Name -notlike "Microsoft.WindowsCalculator*") }
 $GET_APPXPACKAGE_NAME = Write-Output $GET_APPXPACKAGE.Name

 ForEach ($_ in $GET_APPXPACKAGE_NAME) {
   Remove-AppPackage -AllUsers -Online -PackageName  $_ # $GET_APPXPACKAGE_NAME
   }

Read-Host -Prompt "Press any key to continue - this didnt solve the problem i solved then copied.. from harden.ps1" 

 Get-WindowsCapability -Online | Where-Object { ($_.Name) -and ($_.State -like 'Installed') -and ($_.Name -notlike "Language.Basic*") -and ($_.Name -notlike "Language.Handwriting*") -and ($_.Name -notlike "Windows.Client.ShellComponents*") -and ($_.Name -notlike "OpenSSH.Client*") -and ($_.Name -notlike "Microsoft.Windows.Powershell.ISE*") -and ($_.Name -notlike "Microsoft.Windows.Notepad*") -and ($_.Name -notlike "Microsoft.Windows.MSPaint") -and ($_.Name -notlike "MathRecognizer*") -and ($_.Name -notlike "Print.Fax.Scan") | Remove-WindowsCapability -online }

 $GET_APPXPPACKAGE = Get-AppXProvisionedPackage -online | Where-Object { ($_.PackageName)   -and ($_.PackageName -notlike "c5e2524a-ea46-4f67-841f-6a9465d9d515") -and ($_.PackageName -notlike "E2A4F912-2574-4A75-9BB0-0D023378592B") -and ($_.PackageName -notlike "F46D4000-FD22-4DB4-AC8E-4E1DDDE828FE") -and ($_.PackageName -notlike "Microsoft.AccountsControl") -and ($_.PackageName -notlike "Microsoft.AsyncTextService") -and ($_.PackageName -notlike "Microsoft.CredDialogHost") -and ($_.PackageName -notlike "Microsoft.ECApp") -and ($_.PackageName -notlike "Microsoft.LockApp") -and ($_.PackageName -notlike "Microsoft.MicrosoftEdgeDevToolsClient") -and ($_.PackageName -notlike "Microsoft.Win32WebViewHos") -and ($_.PackageName -notlike "Microsoft.Windows.Apprep.ChxApp") -and ($_.PackageName -notlike "Microsoft.Windows.CallingShellApp") -and ($_.PackageName -notlike "Microsoft.Windows.CapturePicker") -and ($_.PackageName -notlike "Microsoft.Windows.PinningConfirmationDialog") -and ($_.PackageName -notlike "Microsoft.Windows.SecHealthUI") -and ($_.PackageName -notlike "Microsoft.Windows.XGpuEjectDialog") -and ($_.PackageName -notlike "NcsiUwpApp") -and ($_.PackageName -notlike "Windows.CBSPreview") -and ($_.PackageName -notlike "MicrosoftWindows.Client.CBS") -and ($_.PackageName -notlike "Microsoft.Windows.ContentDeliveryManager") -and ($_.PackageName -notlike "Microsoft.Windows.Search") -and ($_.PackageName -notlike "Microsoft.Windows.ShellExperienceHost") -and ($_.PackageName -notlike "Microsoft.Windows.StartMenuExperienceHost") -and ($_.PackageName -notlike "MicrosoftWindows.UndockedDevKit") -and ($_.PackageName -notlike "Microsoft.Windows.OOBENetworkCaptivePortal") -and ($_.PackageName -notlike "Microsoft.Windows.OOBENetworkConnectionFlow") -and ($_.PackageName -notlike "Microsoft.AAD.BrokerPlugin") -and ($_.PackageName -notlike "Microsoft.BioEnrollment") -and ($_.PackageName -notlike "Microsoft.Windows.CloudExperienceHost") -and ($_.PackageName -notlike "Windows.PrintDialog") -and ($_.PackageName -notlike "Microsoft.MicrosoftEdge.Stable") -and ($_.PackageName -notlike "windows.immersivecontrolpanel") -and ($_.PackageName -notlike "Microsoft.Windows.NarratorQuickStart") -and ($_.PackageName -notlike "Microsoft.Windows.ParentalControls")-and ($_.PackageName -notlike "Microsoft.Windows.PeopleExperienceHost")-and ($_.PackageName -notlike "Microsoft.Windows.OOBENetworkCaptivePortal") -and ($_.PackageName -notlike "Microsoft.Windows.Search") -and ($_.PackageName -notlike "Microsoft.Windows.CloudExperienceHost") -and ($_.PackageName -notlike "Microsoft.MicrosoftEdge")  -and ($_.PackageName -notlike "c5e2524a-ea46-4f67-841f-6a9465d9d515") -and ($_.PackageName -notlike "E2A4F912-2574-4A75-9BB0-0D023378592B") -and ($_.PackageName -notlike "F46D4000-FD22-4DB4-AC8E-4E1DDDE828FE") -and ($_.PackageName -notlike "Microsoft.AccountsControl") -and ($_.PackageName -notlike "Microsoft.AsyncTextService") -and ($_.PackageName -notlike "Microsoft.CredDialogHost") -and ($_.PackageName -notlike "Microsoft.ECApp") -and ($_.PackageName -notlike "Microsoft.LockApp") -and ($_.PackageName -notlike "Microsoft.MicrosoftEdgeDevToolsClient") -and ($_.PackageName -notlike "Microsoft.Win32WebViewHos") -and ($_.PackageName -notlike "Microsoft.Windows.Apprep.ChxApp") -and ($_.PackageName -notlike "Microsoft.Windows.CallingShellApp") -and ($_.PackageName -notlike "Microsoft.Windows.CapturePicker") -and ($_.PackageName -notlike "Microsoft.Windows.PinningConfirmationDialog") -and ($_.PackageName -notlike "Microsoft.Windows.SecHealthUI") -and ($_.PackageName -notlike "Microsoft.Windows.XGpuEjectDialog") -and ($_.PackageName -notlike "NcsiUwpApp") -and ($_.PackageName -notlike "Windows.CBSPreview") -and ($_.PackageName -notlike "MicrosoftWindows.Client.CBS") -and ($_.PackageName -notlike "Microsoft.Windows.ContentDeliveryManager") -and ($_.PackageName -notlike "Microsoft.Windows.Search") -and ($_.PackageName -notlike "Microsoft.Windows.ShellExperienceHost") -and ($_.PackageName -notlike "Microsoft.Windows.StartMenuExperienceHost") -and ($_.PackageName -notlike "MicrosoftWindows.UndockedDevKit") -and ($_.PackageName -notlike "Microsoft.Windows.OOBENetworkCaptivePortal") -and ($_.PackageName -notlike "Microsoft.Windows.OOBENetworkConnectionFlow") -and ($_.PackageName -notlike "Microsoft.AAD.BrokerPlugin") -and ($_.PackageName -notlike "Microsoft.BioEnrollment") -and ($_.PackageName -notlike "Microsoft.Windows.CloudExperienceHost") -and ($_.PackageName -notlike "Windows.PrintDialog") -and ($_.PackageName -notlike "Microsoft.MicrosoftEdge.Stable") -and ($_.PackageName -notlike "windows.immersivecontrolpanel") -and ($_.PackageName -notlike "Microsoft.Windows.NarratorQuickStart") -and ($_.PackageName -notlike "Microsoft.Windows.ParentalControls")-and ($_.PackageName -notlike "Microsoft.Windows.PeopleExperienceHost")-and ($_.PackageName -notlike "Microsoft.Windows.OOBENetworkCaptivePortal") -and ($_.PackageName -notlike "Microsoft.Windows.Search") -and ($_.PackageName -notlike "Microsoft.Windows.CloudExperienceHost") -and ($_.PackageName -notlike "Microsoft.MicrosoftEdge") -and ($_.PackageName -notlike "Microsoft.DesktopAppInstaller*") -and ($_.PackageName -notlike "Microsoft.HEIFImageExtension*") -and ($_.PackageName -notlike "Microsoft.MicrosoftSolitaireCollection*") -and ($_.PackageName -notlike "Microsoft.MSPaint*") -and ($_.PackageName -notlike "Microsoft.MicrosoftStickyNotes") -and ($_.PackageName -notlike "Microsoft.Windows.Photos*") -and ($_.PackageName -notlike "Microsoft.MicrosoftEdge*") -and ($_.PackageName -notlike "Microsoft.StorePurchaseApp*") -and ($_.PackageName -notlike "Microsoft.VP9*") -and ($_.PackageName -notlike "Microsoft.VP9VideoExtensions*") -and ($_.PackageName -notlike "Microsoft.Web*Extension*") -and ($_.PackageName -notlike "Microsoft.Wallet*") -and ($_.PackageName -notlike "Microsoft.Windows.DevHome*") -and ($_.PackageName -notlike "Microsoft.WindowsStore*") -and ($_.PackageName -notlike "Microsoft.WindowsMaps*")  -and ($_.PackageName -notlike "Microsoft.WindowsSoundRecorder*") -and ($_.PackageName -notlike "Microsoft.VCLibs*") -and ($_.PackageName -notlike "Microsoft.VP9VideoEstension*") -and ($_.PackageName -notlike "Microsoft.Web*Extension*") -and ($_.PackageName -notlike "Microsoft.Wallet*") -and ($_.PackageName -notlike "Microsoft.Windows.DevHome*") -and ($_.PackageName -notlike "Microsoft.WindowsAlarms*") -and ($_.PackageName -notlike "Microsoft.WindowsCalculator*") }
 $GET_APPXPPACKAGE_NAME = Write-Output $GET_APPXPPACKAGE.PackageName

 ForEach ($_ in $GET_APPXPPACKAGE_NAME) {
   Remove-AppxProvisionedPackage -AllUsers -Online -PackageName $_ # $GET_APPXPPACKAGE_NAME
	}

Read-Host -Prompt "Press any key to continue - this didnt solve the problem i solved then copied.. from harden.ps1"

}
disable_win_packages

Read-Host -Prompt "Press any key to continue"
