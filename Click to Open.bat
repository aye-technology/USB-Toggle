@echo off
:: USB Protector Launcher
:: Runs the PowerShell script with admin privileges and hidden window

:: Get the directory where this batch file is located
set "SCRIPT_DIR=%~dp0"

:: Run the PowerShell script with admin privileges and hidden window
powershell.exe -WindowStyle Hidden -ExecutionPolicy Bypass -NoProfile -Command "Start-Process powershell.exe -ArgumentList '-WindowStyle Hidden -ExecutionPolicy Bypass -NoProfile -File \"%SCRIPT_DIR%Read.Only.[NTFS].ps1\"' -Verb RunAs"

exit