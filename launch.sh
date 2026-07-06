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

# Find an available port
check_port() {
    # Try multiple methods to check if port is in use
    if command -v nc &> /dev/null; then
        nc -z localhost $1 2>/dev/null
        return $?
    elif command -v lsof &> /dev/null; then
        lsof -i:$1 &> /dev/null
        return $?
    elif command -v netstat &> /dev/null; then
        netstat -an | grep -q ":$1.*LISTEN"
        return $?
    else
        # If no port-checking tool is available, assume port is free
        return 1
    fi
}

ORIGINAL_PORT=$PORT
while [ $PORT -le $MAX_PORT ]; do
    if ! check_port $PORT; then
        break
    fi
    echo "Port $PORT is already in use, trying $((PORT + 1))..."
    PORT=$((PORT + 1))
done

if [ $PORT -gt $MAX_PORT ]; then
    echo "ERROR: Could not find an available port between $ORIGINAL_PORT and $MAX_PORT"
    echo "Please close some applications and try again."
    echo ""
    exit 1
fi

URL="http://localhost:$PORT"

echo "Starting local HTTP server..."
echo "Server URL: $URL"
echo ""
echo "Press Ctrl+C to stop the server"
echo "======================================"
echo ""

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

# Start the Python HTTP server
python3 -m http.server $PORT
