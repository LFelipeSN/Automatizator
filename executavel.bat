@echo off

tasklist /V /FI "IMAGENAME eq powershell.exe" | findstr /I "Otimizador" >nul
if %ERRORLEVEL% equ 0 (
    powershell -Command "Add-Type -AssemblyName PresentationFramework; [System.Windows.MessageBox]::Show('[Erro]: O otimizador já está aberto.', 'Atenção', [System.Windows.MessageBoxButton]::OK, [System.Windows.MessageBoxImage]::Error)"
    exit
)

set SCRIPT_PATH=%~dp0otimizador.ps1

powershell -command "start-process powershell -argumentList '-ExecutionPolicy','Bypass','-File','\"%SCRIPT_PATH%\"' -Verb RunAs"

