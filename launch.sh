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

# Function to check if a port is listening
check_port_listening() {
    local port=$1
    if command -v lsof &> /dev/null; then
        lsof -i:$port -sTCP:LISTEN &> /dev/null
        return $?
    elif command -v ss &> /dev/null; then
        ss -ln | grep -q ":$port "
        return $?
    elif command -v netstat &> /dev/null; then
        # Use word boundaries to match exact port number
        netstat -an | awk '{print $4}' | grep -q ":$port$"
        return $?
    else
        # Fallback: try to connect to the port
        (echo > /dev/tcp/localhost/$port) &> /dev/null
        return $?
    fi
}

# Function to try starting server on a port
try_start_server() {
    local port=$1
    local error_file=$(mktemp)

    # Try to start the server and capture stderr
    python3 -m http.server $port > /dev/null 2>$error_file &
    local server_pid=$!

    # Give it a moment to bind to the port or fail
    sleep 1

    # Check if the process is still running AND the port is actually listening
    if kill -0 $server_pid 2>/dev/null; then
        # Process exists, but is it actually serving?
        if check_port_listening $port; then
            rm -f $error_file
            echo $server_pid
            return 0
        else
            # Process exists but port not listening - check for error
            if grep -q "Address already in use" $error_file 2>/dev/null; then
                kill $server_pid 2>/dev/null
                rm -f $error_file
                return 1
            fi
            # Give it a bit more time
            sleep 0.5
            if check_port_listening $port; then
                rm -f $error_file
                echo $server_pid
                return 0
            else
                kill $server_pid 2>/dev/null
                rm -f $error_file
                return 1
            fi
        fi
    else
        # Process already died
        rm -f $error_file
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
