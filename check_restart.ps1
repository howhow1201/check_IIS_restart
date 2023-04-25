

  $chech_log = "C:\opt\SysScripts\restart_welfare\restart\restart.txt"
  $shell_log = "C:\opt\SysScripts\restart_welfare\restart\log\check_restart_detail.log"

if (Test-Path -Path $chech_log) {
  Get-Date >> $shell_log

  $Apppool_old=(C:\Windows\System32\inetsrv\appcmd.exe list wp | findstr Welfare)
  Write-Output "檔案存在 , OLD ID : $Apppool_old" >> $shell_log

  Remove-Item $chech_log
  Stop-WebAppPool "Welfare"
  sleep 5
  Start-WebAppPool "Welfare"
  Stop-Website "Welfare"
  sleep 5
  Start-Website "Welfare"

  $Apppool_new = (C:\Windows\System32\inetsrv\appcmd.exe list wp | findstr Welfare)
  
@"
檔案移除 , NEW ID : $Apppool_new
restart done
= = = = =
"@  >> $shell_log
    
} else {
  "檔案不存在。"
  Write-Output "null" 
}
