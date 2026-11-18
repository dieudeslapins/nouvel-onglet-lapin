@echo off
rem Arrete le serveur local de la page lapin.
rem Python est detecte automatiquement : aucun chemin personnel n'est code en dur.
setlocal EnableDelayedExpansion
cd /d "%~dp0"

set "PY="

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

rem 3) installations classiques
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
  echo Python 3 est introuvable : impossible d'arreter le serveur.
  pause
  exit /b 1
)

"!PY!" "%~dp0serveur_lapin.py" --stop
pause
