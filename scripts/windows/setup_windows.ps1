# Ex?cuter en PowerShell (admin recommand?). Cr?e une t?che planifi?e ? la connexion.
$ErrorActionPreference = 'Stop'

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$startupScript = Join-Path $scriptDir 'startup_outlook.ps1'
if (!(Test-Path $startupScript)) {
  Write-Error "Introuvable: $startupScript"
}

$taskName = 'OpenOutlookAndEmailOnLogin'
try { Unregister-ScheduledTask -TaskName $taskName -Confirm:$false -ErrorAction SilentlyContinue } catch {}

$action = New-ScheduledTaskAction -Execute 'powershell.exe' -Argument "-ExecutionPolicy Bypass -File `"$startupScript`""
$trigger = New-ScheduledTaskTrigger -AtLogOn
$principal = New-ScheduledTaskPrincipal -UserId $env:USERNAME -LogonType InteractiveToken
Register-ScheduledTask -TaskName $taskName -Action $action -Trigger $trigger -Principal $principal -Description 'Ouvre Outlook et envoie un email ? la connexion'

Write-Host "T?che planifi?e cr??e: $taskName" -ForegroundColor Green
