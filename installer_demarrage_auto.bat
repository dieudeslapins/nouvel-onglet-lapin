@echo off
rem Installe le demarrage automatique du serveur lapin a l'ouverture de session.
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0installer_demarrage_auto.ps1"
echo.
pause
