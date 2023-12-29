@echo off
set "current_path=%~dp0"
PowerShell -NoProfile -ExecutionPolicy Bypass -File "%current_path%download_script.ps1"


@REM pause 