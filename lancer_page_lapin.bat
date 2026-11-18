@echo off
rem Demarre le serveur local de la page lapin (en arriere-plan, sans fenetre)
rem puis ouvre la page dans le navigateur par defaut.
rem Python est detecte automatiquement : aucun chemin personnel n'est code en dur.
setlocal EnableDelayedExpansion
cd /d "%~dp0"

set "PY="
set "PYW="

rem 1) lanceur officiel "py"
for /f "delims=" %%p in ('where py 2^>nul') do if not defined PY set "PY=%%p"

rem 2) python du PATH (on ignore l'alias Microsoft Store qui ne lance rien)
if not defined PY (
  for /f "delims=" %%p in ('where python 2^>nul') do (
    if not defined PY (
      "%%p" -c "import sys" >nul 2>nul
      if not errorlevel 1 set "PY=%%p"
    )
  )
)

rem 3) installations classiques (dossier utilisateur, Program Files)
if not defined PY (
  for /d %%d in ("%LOCALAPPDATA%\Programs\Python*" "%ProgramFiles%\Python*") do (
    if not defined PY if exist "%%~d\python.exe" set "PY=%%~d\python.exe"
  )
)

rem 4) installations portables sous %LOCALAPPDATA%\Programs\*\python
if not defined PY (
  for /d %%d in ("%LOCALAPPDATA%\Programs\*") do (
    if not defined PY if exist "%%~d\python\python.exe" set "PY=%%~d\python\python.exe"
  )
)

if not defined PY (
  echo.
  echo Python 3 est introuvable sur cet ordinateur.
  echo Installe-le depuis https://www.python.org/downloads/
  echo ^(coche "Add python.exe to PATH" pendant l'installation^), puis relance ce fichier.
  echo.
  pause
  exit /b 1
)

rem version sans fenetre noire (pythonw / pyw)
set "PYW=!PY:python.exe=pythonw.exe!"
if /i "!PYW!"=="!PY!" set "PYW=!PY:py.exe=pyw.exe!"
if not exist "!PYW!" set "PYW=!PY!"

"!PY!" "%~dp0serveur_lapin.py" --check
if not errorlevel 1 (
  echo Le serveur lapin tourne deja : http://127.0.0.1:8765/
  start "" "http://127.0.0.1:8765/"
  exit /b 0
)

start "" "!PYW!" "%~dp0serveur_lapin.py"

for /l %%i in (1,1,25) do (
  "!PY!" "%~dp0serveur_lapin.py" --check
  if not errorlevel 1 goto ouvre
)

echo Le serveur lapin n'a pas pu demarrer.
pause
exit /b 1

:ouvre
start "" "http://127.0.0.1:8765/"
exit /b 0
