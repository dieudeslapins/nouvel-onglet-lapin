@echo off
rem Demarre le serveur local de la page lapin (en arriere-plan, sans fenetre)
rem puis ouvre la page dans le navigateur par defaut.
setlocal
cd /d "%~dp0"

set "PY=C:\Users\Eleve\AppData\Local\Programs\mydevoirs\python\python.exe"
set "PYW=C:\Users\Eleve\AppData\Local\Programs\mydevoirs\python\pythonw.exe"
if not exist "%PY%" set "PY=python"
if not exist "%PYW%" set "PYW=pythonw"

"%PY%" "%~dp0serveur_lapin.py" --check
if not errorlevel 1 (
  echo Le serveur lapin tourne deja : http://127.0.0.1:8765/
  start "" "http://127.0.0.1:8765/"
  exit /b 0
)

start "" "%PYW%" "%~dp0serveur_lapin.py"

for /l %%i in (1,1,25) do (
  "%PY%" "%~dp0serveur_lapin.py" --check
  if not errorlevel 1 goto ouvre
)

echo Le serveur lapin n'a pas pu demarrer.
pause
exit /b 1

:ouvre
start "" "http://127.0.0.1:8765/"
exit /b 0
