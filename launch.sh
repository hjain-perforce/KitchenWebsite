#!/bin/bash

# Kitchen Website Launch Script
# Starts a local HTTP server and opens the application in the default browser

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

echo "Starting HTTP server on port $PORT..."
echo "Server URL: http://localhost:$PORT"
echo ""
echo "Press Ctrl+C to stop the server"
echo "========================================"
echo ""

# Function to handle cleanup on exit
cleanup() {
    echo ""
    echo "Shutting down server..."
    kill $SERVER_PID 2>/dev/null
    exit 0
}

trap cleanup SIGINT SIGTERM

# Start the HTTP server in background
$PYTHON_CMD -m http.server $PORT &
SERVER_PID=$!

# Wait for server to start
sleep 2

# Check if server started successfully
if ! kill -0 $SERVER_PID 2>/dev/null; then
    echo "Error: Failed to start server on port $PORT"
    echo "The port may already be in use. Try a different port or stop the conflicting service."
    exit 1
fi

echo "Server started successfully!"
echo "Opening browser to: $URL"
echo ""

# Open browser (cross-platform approach) - optional, don't fail if it doesn't work
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

# Wait for server process
wait $SERVER_PID
