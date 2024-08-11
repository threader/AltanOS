
# Scheduled Task new task 
$trigger0 = New-ScheduledTaskTrigger -Weekly -At 17pm -DaysOfWeek Tuesday 
$trigger1 = New-ScheduledTaskTrigger -AtLogon
$task_name = "Autorun update"

function shed_task_update() {	
$action = New-ScheduledTaskAction -Execute "PowerShell" -Argument "-NoProfile -ExecutionPolicy Bypass -File '$altanosdir\src\autorun-update.ps1"
$principal = "System\Administrator"
$settings = New-ScheduledTaskSettingsSet -WakeToRun
$task = New-ScheduledTask -Action $action -Trigger $trigger0 -Trigger $trigger1 -Settings $settings
Register-ScheduledTask $task_name -TaskPath '\AltanOS\' -InputObject $task
}
shed_task_update

# Scheduled Task new task
$trigger2 = New-ScheduledTaskTrigger -Weekly -At 16pm -DaysOfWeek Wednesday
$trigger3 = New-ScheduledTaskTrigger -AtLogon
$task_name = "Autorun AwdCleaner.."

function shed_task_maintain_awdcleaner() {	
$action = New-ScheduledTaskAction -Execute "PowerShell" -Argument "-NoProfile -ExecutionPolicy Bypass -File '$altanosdir\src\autorun-awdcleaner.ps1"
$principal = "System\Administrator"
$settings = New-ScheduledTaskSettingsSet -WakeToRun
$task = New-ScheduledTask -Action $action -Trigger $trigger0 -Trigger $trigger1 -Settings $settings
Register-ScheduledTask $task_name -TaskPath '\AltanOS\' -InputObject $task
}
shed_task_maintain_awdcleaner

# Scheduled Task new task
$trigger4 = New-ScheduledTaskTrigger -Weekly -WeeksInterval 3 -At 17pm -DaysOfWeek Wednesday 
$trigger5 = New-ScheduledTaskTrigger -AtLogon
$task_name = "Autorun maintainance"

function shed_task_maintain() {	
$action = New-ScheduledTaskAction -Execute "PowerShell" -Argument "-NoProfile -ExecutionPolicy Bypass -File '$altanosdir\src\autorun-maintain.ps1"
$principal = "System\Administrator"
$settings = New-ScheduledTaskSettingsSet -WakeToRun
$task = New-ScheduledTask -Action $action -Trigger $trigger0 -Trigger $trigger1 -Settings $settings
Register-ScheduledTask $task_name -TaskPath '\AltanOS\' -InputObject $task
}
shed_task_maintain

# Scheduled Task new task
$trigger5 = New-ScheduledTaskTrigger -Weekly -WeeksInterval 3 -At 04pm -DaysOfWeek Wednesday 
$trigger7 = New-ScheduledTaskTrigger -AtLogon
$task_name = "Autorun privacy and temporary file mesures."

function shed_task_maintain_privazy() {	
$action = New-ScheduledTaskAction -Execute "PowerShell" -Argument "-NoProfile -ExecutionPolicy Bypass -File '$altanosdir\src\autorun-privazer.ps1"
$principal = "System\Administrator"
$settings = New-ScheduledTaskSettingsSet -WakeToRun
$task = New-ScheduledTask -Action $action -Trigger $trigger0 -Trigger $trigger1 -Settings $settings
Register-ScheduledTask $task_name -TaskPath '\AltanOS\' -InputObject $task
}
shed_task_maintain_privazy

# Scheduled Task new task 
$trigger8 = New-ScheduledTaskTrigger -Once
$trigger9 = New-ScheduledTaskTrigger -AtLogon
$task_name = "Autorun maintainance first boot"

function shed_task_once_maintain() {	
$action = New-ScheduledTaskAction -Execute "PowerShell" -Argument "-NoProfile -ExecutionPolicy Bypass -File '$altanosdir\src\autorun-maintain.ps1"
$principal = "System\Administrator"
$settings = New-ScheduledTaskSettingsSet -WakeToRun
$task = New-ScheduledTask -Action $action -Trigger $trigger0 -Trigger $trigger1 -Settings $settings
Register-ScheduledTask $task_name -TaskPath '\AltanOS\' -InputObject $task
}
shed_task_once_maintain


# Scheduled Task new task 
$trigger8 = New-ScheduledTaskTrigger -Once
$trigger9 = New-ScheduledTaskTrigger -AtLogon
$task_name = "Autorun update first boot"

function shed_task_once_update() {	
$action = New-ScheduledTaskAction -Execute "PowerShell" -Argument "-NoProfile -ExecutionPolicy Bypass -File '$altanosdir\src\autorun-update.ps1"
$principal = "System\Administrator"
$settings = New-ScheduledTaskSettingsSet -WakeToRun
$task = New-ScheduledTask -Action $action -Trigger $trigger0 -Trigger $trigger1 -Settings $settings
Register-ScheduledTask $task_name -TaskPath '\AltanOS\' -InputObject $task
}
shed_task_once_update

 Read-Host -Prompt "Press any key to continue."

# i had a script to do this. Steal this example i guess 
#$taskTriggers = @(
# Any better suggestions for -At? - Ask?
#New-ScheduledTaskTrigger -Weekly -DaysOfWeek Thuesday -At 17pm 
#New-ScheduledTaskTrigger -AtLogon
#)
# The following will probably not work and include cd% in the path instead of the actual path
#$taskAction = New-ScheduledTaskAction -Execute "PowerShell" -Argument "-NoProfile -ExecutionPolicy Bypass -File '$altanosdir\src\autorun-update.cmd' -Output 'HTML'" -WorkingDirectory '$altanosdir'
# Register-ScheduledTask 'Update Windows and Applications' -TaskPath '\AltanOS\' -Action $taskAction -Trigger $taskTrigger
# Get-ScheduledTask -TaskPath \AltanOS\

# Add to startup
# New-ItemProperty -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Run" -Name "Update Windows and Applications" -Value "$altanosdir\autorun-update.cmd"  -PropertyType "String"
