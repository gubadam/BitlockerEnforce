
# Copy the BitlockerEnable.ps1 script to the local machine
Copy-Item "\\homelab.local\SYSVOL\homelab.local\scripts\BitLockerEnable.ps1" "C:\Windows\Temp\BitLockerEnable.ps1"

# Retrieve password from the script argument
$password = $args[0]

# Set the scheduled task trigger to be any user logon
$trigger = New-ScheduledTaskTrigger -AtLogOn

<# Set the scheduled task running user to System account
# This is because the script has to have administrative rights and if we were to use a servise account 
# then the credentials would have to be specified in a cleartext stored in a place when every user have read rights #>
$User= "NT AUTHORITY\SYSTEM"

# Set the scheduled task action to run the BitlockerEnable.ps1 script
$action = New-ScheduledTaskAction -Execute 'Powershell.exe' -Argument "-ExecutionPolicy Bypass C:\Windows\Temp\BitLockerEnable.ps1 $password"

# Schedule the task on local machine
Register-ScheduledTask -taskName "BitlockerEnable" -Trigger $Trigger -User $User -Action $Action -RunLevel Highest –Force