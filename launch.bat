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

echo Starting HTTP server on port %PORT%...
echo Server URL: http://localhost:%PORT%
echo.
echo Press Ctrl+C to stop the server
echo ========================================
echo.

REM Start the HTTP server in background
start /B python -m http.server %PORT%

REM Wait for server to start
timeout /t 2 /nobreak >nul

REM Check if server is running by testing the connection using PowerShell
powershell -Command "(Invoke-WebRequest -Uri http://localhost:%PORT% -UseBasicParsing).StatusCode" >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo Error: Failed to start server on port %PORT%
    echo The port may already be in use. Try a different port or stop the conflicting service.
    pause
    exit /b 1
)

echo Server started successfully!
echo Opening browser to: %URL%
echo.

REM Open browser
start "" "%URL%"

REM Wait indefinitely (server runs in background)
echo Server is running. Press Ctrl+C to stop.
pause >nul
