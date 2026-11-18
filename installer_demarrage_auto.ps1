# Installe le demarrage automatique du serveur lapin (au login Windows).
# Python est detecte automatiquement : aucun chemin personnel n'est code en dur.
$ErrorActionPreference = "Stop"

$root = Split-Path -Parent $MyInvocation.MyCommand.Path

# --- Trouve pythonw.exe automatiquement ---
$pyw = $null
$candidats = @()

$py = Get-Command py -ErrorAction SilentlyContinue
if ($py) { $candidats += (Join-Path (Split-Path $py.Source) "pyw.exe") }

$python = Get-Command python -ErrorAction SilentlyContinue
if ($python) { $candidats += (Join-Path (Split-Path $python.Source) "pythonw.exe") }

$candidats += @(
    (Get-ChildItem "$env:LOCALAPPDATA\Programs\Python*\pythonw.exe" -ErrorAction SilentlyContinue | ForEach-Object FullName)
    (Get-ChildItem "$env:ProgramFiles\Python*\pythonw.exe" -ErrorAction SilentlyContinue | ForEach-Object FullName)
    (Get-ChildItem "$env:LOCALAPPDATA\Programs\*\python\pythonw.exe" -ErrorAction SilentlyContinue | ForEach-Object FullName)
)

foreach ($c in $candidats) {
    if ($c -and (Test-Path $c)) { $pyw = $c; break }
}

if (-not $pyw) {
    $pyw = "pythonw.exe"   # laisse Windows le chercher dans le PATH
}

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
