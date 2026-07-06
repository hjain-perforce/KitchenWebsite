#!/bin/bash

# Launch script for Mom's Kitchen Website
# Starts a local HTTP server and opens the application in the default browser

PORT=8000
MAX_PORT=8010

echo "======================================"
echo "  Mom's Kitchen - Launch Script"
echo "======================================"
echo ""

# Check if Python 3 is installed
if ! command -v python3 &> /dev/null; then
    echo "ERROR: Python 3 is not installed."
    echo "Please install Python 3 to run this script."
    echo ""
    exit 1
fi

# Function to handle cleanup on exit
cleanup() {
    echo ""
    echo ""
    echo "======================================"
    echo "Shutting down server..."
    echo "Thank you for using Mom's Kitchen!"
    echo "======================================"
    exit 0
}

trap cleanup SIGINT SIGTERM

# Function to try starting server on a port
try_start_server() {
    local port=$1
    # Try to start the server and capture any error
    python3 -m http.server $port 2>&1 &
    local server_pid=$!

    # Give it a moment to fail if port is in use
    sleep 0.5

    # Check if the process is still running
    if kill -0 $server_pid 2>/dev/null; then
        echo $server_pid
        return 0
    else
        return 1
    fi
}

# Find an available port and start the server
ORIGINAL_PORT=$PORT
SERVER_PID=""

while [ $PORT -le $MAX_PORT ]; do
    echo "Attempting to start server on port $PORT..."

    if SERVER_PID=$(try_start_server $PORT); then
        # Server started successfully
        URL="http://localhost:$PORT"
        echo ""
        echo "======================================"
        echo "Server started successfully!"
        echo "Server URL: $URL"
        echo ""
        echo "Press Ctrl+C to stop the server"
        echo "======================================"
        echo ""

        # Give the server a moment to be ready
        sleep 1

        # Open the browser (cross-platform approach)
        if command -v xdg-open &> /dev/null; then
            xdg-open "$URL" &> /dev/null &
        elif command -v open &> /dev/null; then
            open "$URL" &> /dev/null &
        elif command -v start &> /dev/null; then
            start "$URL" &> /dev/null &
        else
            echo "Could not auto-open browser. Please navigate to: $URL"
        fi

        # Wait for the server process
        wait $SERVER_PID
        exit 0
    else
        echo "Port $PORT is already in use, trying next port..."
        PORT=$((PORT + 1))
    fi
done

echo ""
echo "ERROR: Could not find an available port between $ORIGINAL_PORT and $MAX_PORT"
echo "Please close some applications and try again."
echo ""
exit 1
