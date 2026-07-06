#!/bin/bash
# Simple test to verify launch scripts are valid and project structure is correct

echo "Running KitchenWebsite launch script tests..."
echo ""

# Determine which Python command to use
if command -v python3 &> /dev/null; then
    PYTHON_CMD="python3"
elif command -v python &> /dev/null; then
    PYTHON_CMD="python"
else
    echo "Test 1: Checking Python availability..."
    echo "✗ Python not found"
    exit 1
fi

# Test 1: Check Python availability
echo "Test 1: Checking Python availability..."
echo "✓ Python is available ($PYTHON_CMD)"

# Test 2: Check launch.sh syntax
echo "Test 2: Validating launch.sh syntax..."
bash -n launch.sh
echo "✓ launch.sh syntax is valid"

# Test 3: Check launch.sh is executable
echo "Test 3: Checking launch.sh permissions..."
if [ -x launch.sh ]; then
    echo "✓ launch.sh is executable"
else
    echo "✗ launch.sh is not executable"
    exit 1
fi

# Test 4: Check launch.bat exists
echo "Test 4: Checking launch.bat exists..."
if [ -f launch.bat ]; then
    echo "✓ launch.bat exists"
else
    echo "✗ launch.bat not found"
    exit 1
fi

# Test 5: Check required directories exist
echo "Test 5: Checking project structure..."
for dir in templates css images; do
    if [ -d "$dir" ]; then
        echo "✓ $dir/ directory exists"
    else
        echo "✗ $dir/ directory not found"
        exit 1
    fi
done

# Test 6: Check main HTML file exists
echo "Test 6: Checking main HTML file..."
if [ -f templates/Kitchen.html ]; then
    echo "✓ templates/Kitchen.html exists"
else
    echo "✗ templates/Kitchen.html not found"
    exit 1
fi

# Test 7: Verify CSS file exists
echo "Test 7: Checking CSS file..."
if [ -f css/kitchen_styles.css ]; then
    echo "✓ css/kitchen_styles.css exists"
else
    echo "✗ css/kitchen_styles.css not found"
    exit 1
fi

# Test 8: Test HTTP server can start briefly
echo "Test 8: Testing HTTP server functionality..."
$PYTHON_CMD -m http.server 8765 > /dev/null 2>&1 &
SERVER_PID=$!
sleep 2

if kill -0 $SERVER_PID 2>/dev/null; then
    echo "✓ HTTP server can start successfully"
    kill $SERVER_PID 2>/dev/null
else
    echo "✗ HTTP server failed to start"
    exit 1
fi

# Test 9: Verify README.md exists and has content
echo "Test 9: Checking README.md..."
if [ -f README.md ] && [ -s README.md ]; then
    echo "✓ README.md exists and has content"
else
    echo "✗ README.md is missing or empty"
    exit 1
fi

echo ""
echo "========================================"
echo "All tests passed! ✓"
echo "========================================"
exit 0
