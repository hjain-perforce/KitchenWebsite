#!/bin/bash

# KitchenWebsite Launch Script
# Starts a local HTTP server and opens the application in the default browser

set -e

# Check if Python 3 is available
if ! command -v python3 &> /dev/null; then
    echo "Error: Python 3 is required but not installed."
    echo "Please install Python 3 and try again."
    exit 1
fi

# Configuration
PORT=8000
URL="http://localhost:$PORT/templates/Kitchen.html"

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
    kill $SERVER_PID 2>/dev/null || true
    wait $SERVER_PID 2>/dev/null || true
    echo "Server stopped."
    exit 0
}

# Trap SIGINT (Ctrl+C) for graceful shutdown
trap cleanup SIGINT SIGTERM

# Wait a moment for server to start
sleep 2

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

# Wait for server process
wait $SERVER_PID
