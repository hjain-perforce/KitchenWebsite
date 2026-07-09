@echo off
REM KitchenWebsite Launch Script for Windows
REM Starts a local HTTP server and opens the application in the default browser

echo ========================================
echo   KitchenWebsite Launch Script
echo ========================================
echo.

REM Check if Python is available
python --version >nul 2>&1
if errorlevel 1 (
    echo Error: Python is required but not installed.
    echo Please install Python 3 and try again.
    pause
    exit /b 1
)

REM Configuration
set PORT=8000
set URL=http://localhost:%PORT%/templates/Kitchen.html

echo Starting local HTTP server...
echo Server URL: http://localhost:%PORT%
echo Application URL: %URL%
echo.
echo Press Ctrl+C to stop the server
echo ========================================
echo.

REM Start HTTP server in a new window
start "KitchenWebsite Server" python -m http.server %PORT%

REM Wait for server to start
timeout /t 2 /nobreak >nul

REM Open browser
start "" "%URL%"

echo.
echo Server is running. Close the server window or press Ctrl+C to stop.
echo.
pause
