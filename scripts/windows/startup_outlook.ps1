# Param?tres ? personnaliser
$Recipient = "votre.email@exemple.com"
$Subject = "D?marrage de l?ordinateur"
$Body = "Cet ordinateur a d?marr? ? $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')."

# Ouvrir Outlook (tente plusieurs chemins, sinon via PATH)
$possiblePaths = @(
  "$env:ProgramFiles\Microsoft Office\root\Office16\OUTLOOK.EXE",
  "$env:ProgramFiles(x86)\Microsoft Office\root\Office16\OUTLOOK.EXE"
)
foreach ($p in $possiblePaths) {
  if (Test-Path $p) { Start-Process -FilePath $p -ErrorAction SilentlyContinue; break }
}
Start-Process -FilePath "outlook.exe" -ErrorAction SilentlyContinue

Start-Sleep -Seconds 10

# Envoyer un email via COM Outlook (profil local requis)
try {
  $olApp = [Runtime.InteropServices.Marshal]::GetActiveObject("Outlook.Application")
} catch {
  $olApp = New-Object -ComObject Outlook.Application
}
$mail = $olApp.CreateItem(0)
$mail.To = $Recipient
$mail.Subject = $Subject
$mail.Body = $Body
$mail.Send()
