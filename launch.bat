@echo off
REM Launch script for Mom's Kitchen Website
REM Starts a local HTTP server and opens the application in the default browser

SET PORT=8000
SET MAX_PORT=8010

echo ======================================
echo   Mom's Kitchen - Launch Script
echo ======================================
echo.

REM Check if Python is installed
python --version >nul 2>&1
IF ERRORLEVEL 1 (
    echo ERROR: Python is not installed.
    echo Please install Python 3 from https://www.python.org/downloads/
    echo.
    pause
    exit /b 1
)

:FIND_PORT
REM Check if port is available before trying
netstat -an | findstr /C:":%PORT% " | findstr "LISTENING" >nul
IF NOT ERRORLEVEL 1 (
    echo Port %PORT% is already in use, trying next port...
    SET /A PORT+=1
    IF %PORT% LEQ %MAX_PORT% (
        goto FIND_PORT
    ) ELSE (
        echo ERROR: Could not find an available port between 8000 and %MAX_PORT%
        echo Please close some applications and try again.
        echo.
        pause
        exit /b 1
    )
)

SET URL=http://localhost:%PORT%

echo.
echo ======================================
echo Server started successfully!
echo Server URL: %URL%
echo.
echo Press Ctrl+C to stop the server
echo ======================================
echo.

REM Open the browser in background
start "" "%URL%"

REM Give the browser a moment to start before server output floods console
timeout /t 1 /nobreak >nul

REM Start the Python HTTP server in foreground (blocks until Ctrl+C)
python -m http.server %PORT%
