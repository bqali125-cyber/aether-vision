@echo off
title Aether Vision Web Platform
cd /d "%~dp0"

set PYTHONUTF8=1
set PYTHONIOENCODING=utf-8

if not exist ".venv\Scripts\python.exe" (
    echo [ERROR] Virtual environment not found at .venv\Scripts\python.exe
    pause
    exit /b 1
)

echo ===================================================
echo   Aether Vision - AI Image Restoration Platform
echo ===================================================
echo [1/2] Opening browser at http://127.0.0.1:8000 ...
start http://127.0.0.1:8000

echo [2/2] Launching Web Server...
".venv\Scripts\python.exe" app\web_server.py

if errorlevel 1 (
    echo.
    echo Server stopped with error.
    pause
)
