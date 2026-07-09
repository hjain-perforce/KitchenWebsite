#!/bin/bash

# KitchenWebsite Launch Script
# Starts a local HTTP server and opens the application in the default browser

# Change to script directory to ensure correct serving path
cd "$(dirname "$0")"

# Check if Python 3 is available
if ! command -v python3 &> /dev/null; then
    echo "Error: Python 3 is required but not installed."
    echo "Please install Python 3 and try again."
    exit 1
fi

# Configuration
PORT=8000
URL="http://localhost:$PORT/templates/Kitchen.html"

# Check if port is already in use
if command -v lsof &> /dev/null; then
    if lsof -i :$PORT &> /dev/null; then
        echo "Error: Port $PORT is already in use."
        echo "Please stop the process using port $PORT and try again."
        exit 1
    fi
elif command -v netstat &> /dev/null; then
    if netstat -an | grep -q ":$PORT "; then
        echo "Error: Port $PORT is already in use."
        echo "Please stop the process using port $PORT and try again."
        exit 1
    fi
fi

# Display welcome message
echo "========================================"
echo "  KitchenWebsite Launch Script"
echo "========================================"
echo ""
echo "Starting local HTTP server..."
echo "Server URL: http://localhost:$PORT"
echo "Application URL: $URL"
echo ""
echo "Press Ctrl+C to stop the server"
echo "========================================"
echo ""

# Start HTTP server in the background
python3 -m http.server $PORT &
SERVER_PID=$!

# Function to cleanup on exit
cleanup() {
    echo ""
    echo "Shutting down server..."
    # Kill process group to ensure all child processes are terminated
    kill -TERM -$SERVER_PID 2>/dev/null || true
    wait $SERVER_PID 2>/dev/null || true
    echo "Server stopped."
    exit 0
}

# Trap SIGINT (Ctrl+C) for graceful shutdown
trap cleanup SIGINT SIGTERM

# Wait for server to be ready with retry loop
echo "Waiting for server to be ready..."
MAX_ATTEMPTS=10
ATTEMPT=0
while [ $ATTEMPT -lt $MAX_ATTEMPTS ]; do
    if command -v curl &> /dev/null; then
        if curl -s http://localhost:$PORT >/dev/null 2>&1; then
            break
        fi
    elif command -v wget &> /dev/null; then
        if wget -q --spider http://localhost:$PORT 2>/dev/null; then
            break
        fi
    else
        # Fallback to sleep if neither curl nor wget available
        sleep 2
        break
    fi
    ATTEMPT=$((ATTEMPT + 1))
    sleep 0.5
done

if [ $ATTEMPT -eq $MAX_ATTEMPTS ]; then
    echo "Warning: Server may not have started successfully. Check for errors above."
fi

# Open browser based on OS
if command -v xdg-open &> /dev/null; then
    # Linux
    xdg-open "$URL" &> /dev/null &
elif command -v open &> /dev/null; then
    # macOS
    open "$URL" &> /dev/null &
else
    echo "Could not detect browser opener. Please manually open: $URL"
fi

# Monitor server process and wait for it to exit
while kill -0 $SERVER_PID 2>/dev/null; do
    sleep 1
done

# If we reach here, server has exited (possibly due to error)
echo "Server process has terminated."
cleanup
