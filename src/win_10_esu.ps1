
# vb scripts are utterly turned off in my configuration...
# .\wscript.exe slmgr.vbs /ipk f520e45e-7413-4a34-a497-d2765967d094

reg.exe add "HKLM\SYSTEM\CurrentControlSet\Policies\Microsoft\FeatureManagement\Overrides" /v 4011992206 /t REG_DWORD /d 2 /f

$TN = "ReconcileFeatures"; $TP = "\Microsoft\Windows\Flighting\FeatureConfig\"; $null = Enable-ScheduledTask $TN $TP
Start-ScheduledTask $TN $TP; while ((Get-ScheduledTask $TN $TP).State.value__ -eq 4) {start-sleep -sec 1}; "Task Completed"
#
$TN = "UsageDataFlushing"; $TP = "\Microsoft\Windows\Flighting\FeatureConfig\"; $null = Enable-ScheduledTask $TN $TP
Start-ScheduledTask $TN $TP; while ((Get-ScheduledTask $TN $TP).State.value__ -eq 4) {start-sleep -sec 1}; "Task Completed"

# 'ClipESUConsumer' Doesnt seem to do anything in the configuration i am running but running it trough regular windows update in settings enrolls the device. wheee....
cmd /c ClipESUConsumer.exe -evaluateEligibility

reg.exe query "HKCU\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Windows\ConsumerESU"

Read-Host -Prompt "Press any key to continue"
