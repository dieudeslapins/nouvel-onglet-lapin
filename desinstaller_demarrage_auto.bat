@echo off
rem Retire le demarrage automatique du serveur lapin.
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0desinstaller_demarrage_auto.ps1"
echo.
pause
