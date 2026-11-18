@echo off
rem Arrete le serveur local de la page lapin.
setlocal
cd /d "%~dp0"

set "PY=C:\Users\Eleve\AppData\Local\Programs\mydevoirs\python\python.exe"
if not exist "%PY%" set "PY=python"

"%PY%" "%~dp0serveur_lapin.py" --stop
pause
