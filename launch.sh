#!/bin/bash

# Kitchen Website Launch Script
# Starts a local HTTP server and opens the application in the default browser

set -e

PORT=8000
URL="http://localhost:$PORT/templates/Kitchen.html"

echo "========================================"
echo "  Kitchen Website - Launch Script"
echo "========================================"
echo ""

# Check if Python is available
if command -v python3 &> /dev/null; then
    PYTHON_CMD="python3"
elif command -v python &> /dev/null; then
    PYTHON_CMD="python"
else
    echo "Error: Python is not installed or not in PATH"
    echo "Please install Python 3.x to run this application"
    exit 1
fi

echo "Using: $PYTHON_CMD"

# Check if port is already in use
if lsof -Pi :$PORT -sTCP:LISTEN -t >/dev/null 2>&1 ; then
    echo "Error: Port $PORT is already in use"
    echo "Please stop the service using port $PORT or modify the PORT variable in this script"
    exit 1
fi

echo "Starting HTTP server on port $PORT..."
echo "Server URL: http://localhost:$PORT"
echo "Opening browser to: $URL"
echo ""
echo "Press Ctrl+C to stop the server"
echo "========================================"
echo ""

# Function to handle cleanup on exit
cleanup() {
    echo ""
    echo "Shutting down server..."
    exit 0
}

trap cleanup SIGINT SIGTERM

# Open browser (cross-platform approach)
if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS
    open "$URL" 2>/dev/null || true
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    # Linux
    xdg-open "$URL" 2>/dev/null || true
elif [[ "$OSTYPE" == "cygwin" ]] || [[ "$OSTYPE" == "msys" ]]; then
    # Windows (Git Bash, Cygwin, or MSYS)
    start "$URL" 2>/dev/null || true
fi

# Start the HTTP server
$PYTHON_CMD -m http.server $PORT
