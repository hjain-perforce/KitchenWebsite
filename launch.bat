@echo off
REM KitchenWebsite Launch Script for Windows
REM Starts a local HTTP server and opens the application in the default browser

REM Change to script directory to ensure correct serving path
cd /d "%~dp0"

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

REM Check if Python 3.x is installed
python -c "import sys; sys.exit(0 if sys.version_info[0] >= 3 else 1)" 2>nul
if errorlevel 1 (
    echo Error: Python 3.x is required. Python 2 is not supported.
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
echo ========================================
echo.

REM Start HTTP server in a new window
start "KitchenWebsite Server" python -m http.server %PORT%

REM Wait for server to start and verify it's listening
echo Waiting for server to be ready...
set /a ATTEMPTS=0
:wait_loop
if %ATTEMPTS% GEQ 20 goto server_timeout
timeout /t 1 /nobreak >nul
netstat -an | findstr ":%PORT% " >nul 2>&1
if errorlevel 1 (
    set /a ATTEMPTS+=1
    goto wait_loop
)

echo Server is ready!
echo.

REM Open browser
start "" "%URL%"

echo.
echo Server is running in a separate window.
echo To stop the server: close the "KitchenWebsite Server" window or press Ctrl+C in that window.
echo.
echo Press any key to exit this launcher script (the server will continue running).
pause >nul
exit /b 0

:server_timeout
echo.
echo Warning: Could not verify server started successfully.
echo Please check the "KitchenWebsite Server" window for errors.
echo If port %PORT% is already in use, close the application using it and try again.
echo.
pause
exit /b 1
