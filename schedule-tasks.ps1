
# Scheduled Task new task 
$trigger0 = New-ScheduledTaskTrigger -Weekly -At 18pm -DaysOfWeek Tuesday 
$trigger1 = New-ScheduledTaskTrigger -AtLogon
$task_name = "Autorun update"

function shed_task_update() {	
$action = New-ScheduledTaskAction -Execute "PowerShell" -Argument "-NoProfile -ExecutionPolicy Bypass -File '$altanosdir\autorun-update.ps1"
$principal = "System\Administrator"
$settings = New-ScheduledTaskSettingsSet -WakeToRun
$task = New-ScheduledTask -Action $action -Trigger $trigger0 -Trigger $trigger1 -Settings $settings
Register-ScheduledTask $task_name -TaskPath 'AltanOS' -InputObject $task
}
shed_task_update


# Scheduled Task new task 
$trigger0 = New-ScheduledTaskTrigger -Weekly -WeeksInterval 3 -At 18pm -DaysOfWeek Wedensday 
$trigger1 = New-ScheduledTaskTrigger -AtLogon
$task_name = "Autorun maintainance"

function shed_task_maintain() {	
$action = New-ScheduledTaskAction -Execute "PowerShell" -Argument "-NoProfile -ExecutionPolicy Bypass -File '$altanosdir\autorun-maintain.ps1"
$principal = "System\Administrator"
$settings = New-ScheduledTaskSettingsSet -WakeToRun
$task = New-ScheduledTask -Action $action -Trigger $trigger0 -Trigger $trigger1 -Settings $settings
Register-ScheduledTask $task_name -TaskPath 'AltanOS' -InputObject $task
}
shed_task_maintian

# Scheduled Task new task 
$trigger0 = New-ScheduledTaskTrigger -Once
$trigger1 = New-ScheduledTaskTrigger -AtLogon
$task_name = "Autorun maintainance"

function shed_task_once() {	
$action = New-ScheduledTaskAction -Execute "PowerShell" -Argument "-NoProfile -ExecutionPolicy Bypass -File '$altanosdir\autorun-maintain.ps1"
$principal = "System\Administrator"
$settings = New-ScheduledTaskSettingsSet -WakeToRun
$task = New-ScheduledTask -Action $action -Trigger $trigger0 -Trigger $trigger1 -Settings $settings
Register-ScheduledTask $task_name -TaskPath 'AltanOS' -InputObject $task
}
shed_task_once

# i had a script to do this. Steal this example i guess 
#$taskTriggers = @(
# Any better suggestions for -At? - Ask?
#New-ScheduledTaskTrigger -Weekly -DaysOfWeek Thuesday -At 17pm 
#New-ScheduledTaskTrigger -AtLogon
#)
# The following will probably not work and include cd% in the path instead of the actual path
#$taskAction = New-ScheduledTaskAction -Execute "PowerShell" -Argument "-NoProfile -ExecutionPolicy Bypass -File '$altanosdir\autorun-update.cmd' -Output 'HTML'" -WorkingDirectory '$altanosdir'
# Register-ScheduledTask 'Update Windows and Applications' -TaskPath 'AltanOS' -Action $taskAction -Trigger $taskTrigger
# Get-ScheduledTask -TaskPath \AltanOS\

# Aaha, so thats where i put that
# Add to startup
# New-ItemProperty -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Run" -Name "Update Windows and Applications" -Value "$altanosdir\autorun-update.cmd"  -PropertyType "String"
