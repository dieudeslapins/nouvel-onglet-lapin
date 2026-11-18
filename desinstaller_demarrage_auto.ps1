# Retire le demarrage automatique du serveur lapin.
$ErrorActionPreference = "Stop"

$startup = [Environment]::GetFolderPath("Startup")
$lnkPath = Join-Path $startup "Lapin - Nouvel onglet.lnk"

if (Test-Path $lnkPath) {
    Remove-Item $lnkPath -Force
    Write-Host "Demarrage automatique retire." -ForegroundColor Green
} else {
    Write-Host "Aucun demarrage automatique installe."
}
