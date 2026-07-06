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
echo Attempting to start server on port %PORT%...

REM Try to start the server
start /B python -m http.server %PORT% >nul 2>&1

REM Give it a moment to fail if port is in use
timeout /t 1 /nobreak >nul

REM Check if python server is running on this port
netstat -an | findstr /C:":%PORT% " | findstr "LISTENING" >nul
IF ERRORLEVEL 1 (
    REM Port is not listening, which means server failed to start
    echo Port %PORT% is already in use, trying next port...
    REM Kill any python process we just started
    taskkill /F /FI "IMAGENAME eq python.exe" /FI "COMMANDLINE eq *http.server %PORT%*" >nul 2>&1
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

REM Give the server a moment to be fully ready
timeout /t 1 /nobreak >nul

REM Open the browser
start "" "%URL%"

REM The server is already running in background, wait for user to press Ctrl+C
echo Server is running. Close this window or press Ctrl+C to stop.
pause >nul
