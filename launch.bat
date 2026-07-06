@echo off
REM KitchenWebsite Launch Script for Windows
REM Starts a local HTTP server and opens the app in your default browser

setlocal enabledelayedexpansion

REM Check if Python is available
where python >nul 2>nul
if %errorlevel% neq 0 (
    echo Error: Python is not installed or not in PATH
    echo Please install Python 3.x from https://www.python.org/downloads/
    pause
    exit /b 1
)

REM Function to check if a port is available
set PORT=8000
:check_port
netstat -an | find ":%PORT%" | find "LISTENING" >nul
if %errorlevel% equ 0 (
    echo Port %PORT% is already in use, trying next port...
    set /a PORT+=1
    if !PORT! gtr 8100 (
        echo Error: Could not find an available port between 8000-8100
        pause
        exit /b 1
    )
    goto check_port
)

REM Display welcome message
echo ========================================
echo    KitchenWebsite Local Server
echo ========================================
echo.
echo Server starting on port %PORT%...
echo URL: http://localhost:%PORT%/templates/Kitchen.html
echo.
echo Press Ctrl+C to stop the server
echo.

REM Start the server in background and open browser
start "" http://localhost:%PORT%/templates/Kitchen.html

REM Start Python HTTP server
python -m http.server %PORT%
