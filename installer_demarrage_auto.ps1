# Installe le demarrage automatique du serveur lapin (au login Windows).
$ErrorActionPreference = "Stop"

$root = Split-Path -Parent $MyInvocation.MyCommand.Path
$pyw  = Join-Path $env:LOCALAPPDATA "Programs\mydevoirs\python\pythonw.exe"
if (-not (Test-Path $pyw)) { $pyw = "pythonw.exe" }

$startup = [Environment]::GetFolderPath("Startup")
$lnkPath = Join-Path $startup "Lapin - Nouvel onglet.lnk"

$shell = New-Object -ComObject WScript.Shell
$lnk = $shell.CreateShortcut($lnkPath)
$lnk.TargetPath       = $pyw
$lnk.Arguments        = '"' + (Join-Path $root "serveur_lapin.py") + '"'
$lnk.WorkingDirectory = $root
$lnk.WindowStyle      = 7   # fenetre minimisee (invisible avec pythonw)
$lnk.Description      = "Sert la page lapin du nouvel onglet Firefox"
$lnk.Save()

Write-Host ""
Write-Host "Demarrage automatique installe." -ForegroundColor Green
Write-Host "Raccourci : $lnkPath"
Write-Host "Le serveur demarrera tout seul a chaque ouverture de session."
