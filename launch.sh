#!/usr/bin/env bash

# KitchenWebsite Launch Script
# Starts a local HTTP server and opens the app in your default browser

# Change to script directory to ensure correct paths
cd "$(dirname "$0")"

# Color codes for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Check if Python is available
if ! command -v python3 &> /dev/null && ! command -v python &> /dev/null; then
    echo -e "${RED}Error: Python is not installed or not in PATH${NC}"
    echo "Please install Python 3.x from https://www.python.org/downloads/"
    exit 1
fi

# Use python3 if available, otherwise python
PYTHON_CMD="python3"
if ! command -v python3 &> /dev/null; then
    PYTHON_CMD="python"
fi

# Function to check if a port is available
check_port() {
    local port=$1
    if command -v nc &> /dev/null; then
        ! nc -z localhost "$port" 2>/dev/null
    elif command -v lsof &> /dev/null; then
        ! lsof -i :"$port" &> /dev/null
    else
        # Fallback: try to bind to the port using Python
        $PYTHON_CMD -c "import socket; s = socket.socket(); s.bind(('', $port)); s.close()" 2>/dev/null
    fi
}

# Find an available port starting from 8000
PORT=8000
set +e  # Disable exit on error for port checking
while ! check_port $PORT; do
    echo -e "${YELLOW}Port $PORT is already in use, trying next port...${NC}"
    PORT=$((PORT + 1))
    if [ $PORT -gt 8100 ]; then
        echo -e "${RED}Error: Could not find an available port between 8000-8100${NC}"
        exit 1
    fi
done
set -e  # Re-enable exit on error

# Display welcome message
echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}   KitchenWebsite Local Server${NC}"
echo -e "${GREEN}========================================${NC}"
echo ""
echo -e "Server starting on port ${GREEN}$PORT${NC}..."
echo -e "URL: ${GREEN}http://localhost:$PORT/templates/Kitchen.html${NC}"
echo ""
echo -e "${YELLOW}Press Ctrl+C to stop the server${NC}"
echo ""

# Function to open browser
open_browser() {
    local url=$1
    sleep 2  # Give server a moment to start

    if command -v xdg-open &> /dev/null; then
        xdg-open "$url" &> /dev/null &
    elif command -v open &> /dev/null; then
        open "$url" &> /dev/null &
    elif command -v start &> /dev/null; then
        start "$url" &> /dev/null &
    else
        echo -e "${YELLOW}Could not automatically open browser. Please navigate to:${NC}"
        echo -e "${GREEN}$url${NC}"
    fi
}

# Start the server in background
$PYTHON_CMD -m http.server $PORT &
SERVER_PID=$!

# Trap Ctrl+C for graceful shutdown
trap 'echo -e "\n${YELLOW}Shutting down server...${NC}"; kill $SERVER_PID 2>/dev/null; exit 0' INT TERM

# Open browser after server starts
open_browser "http://localhost:$PORT/templates/Kitchen.html"

# Wait for server process
wait $SERVER_PID
