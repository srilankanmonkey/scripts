# Script OSSEC Restart
<# .SYNOPSIS
     Restarts OSSEC HIDS service on a local computer. 
.DESCRIPTION
     Intended to restart the OSSEC HIDS service on a local computer. Written as they can lock up, and asking users to restart is annoying. 
     This is written with the intent to run as an account with the appropriate permissions - this will not work with a regular user account with no privileges.
.NOTES
     Author     : Sahan Fernando (@srilankanmonkey)
.LINK
     https://github.com/srilankanmonkey
#>



#Read OSSEC Log File 
$FilePath = "C:\Program Files (x86)\ossec-agent\ossec.log"
$LastRow = (Get-Content $FilePath)[-2]

#Initiates While Loop to Keep Attempting Restart if last line is "More than 120 seconds without server response...sending win32info"
#Sleep line is to allow agent to connect, start monitoring, etc
#Then update LastRow variable, advance iteration
$i=0
While (($lastRow -like '*More than 120 seconds without server response...sending win32info*') -and ($i -le 3))
{
    Restart-Service -Name OssecSvc
    Start-Sleep -Seconds 360
    $LastRow = (Get-Content $FilePath)[-2]
    ++$i
}

Exit


