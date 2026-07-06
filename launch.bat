@echo off
REM Kitchen Website Launch Script for Windows
REM Starts a local HTTP server and opens the application in the default browser

setlocal

set PORT=8000
set URL=http://localhost:%PORT%/templates/Kitchen.html

echo ========================================
echo   Kitchen Website - Launch Script
echo ========================================
echo.

REM Check if Python is available
python --version >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo Error: Python is not installed or not in PATH
    echo Please install Python 3.x to run this application
    echo Download from: https://www.python.org/downloads/
    pause
    exit /b 1
)

echo Using: Python
python --version

REM Check if port is already in use
netstat -ano | findstr ":%PORT%" | findstr "LISTENING" >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    echo Error: Port %PORT% is already in use
    echo Please stop the service using port %PORT% or modify the PORT variable in this script
    pause
    exit /b 1
)

echo Starting HTTP server on port %PORT%...
echo Server URL: http://localhost:%PORT%
echo Opening browser to: %URL%
echo.
echo Press Ctrl+C to stop the server
echo ========================================
echo.

REM Open browser
start "" "%URL%"

REM Start the HTTP server
python -m http.server %PORT%
