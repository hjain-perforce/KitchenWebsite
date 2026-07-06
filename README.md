# KitchenWebsite

A simple static website for showcasing kitchen designs and information.

## Prerequisites

- **Python 3.x** - Required to run the local development server
  - Check if Python is installed: `python --version` or `python3 --version`
  - Download from [python.org](https://www.python.org/downloads/) if needed

## Quick Start

### Unix/Linux/macOS

1. Make the launch script executable (first time only):
   ```bash
   chmod +x launch.sh
   ```

2. Run the launch script:
   ```bash
   ./launch.sh
   ```

### Windows

Double-click `launch.bat` or run from command prompt:
```cmd
launch.bat
```

The script will:
- Start a local HTTP server on port 8000 (or next available port)
- Automatically open your default browser to the application
- Display the server URL in the console

To stop the server, press `Ctrl+C` in the terminal.

## Usage Instructions

### Running the Application

The launch scripts automatically:
1. Check for Python availability
2. Find an available port (starting from 8000)
3. Start the HTTP server from the project root
4. Open http://localhost:8000/templates/Kitchen.html in your browser
5. Log all requests to the console

### Manual Server Start

If you prefer to start the server manually:

```bash
python3 -m http.server 8000
```

Then navigate to: http://localhost:8000/templates/Kitchen.html

## Project Structure

```
project-root/
├── launch.sh          # Launch script for Unix/Linux/macOS
├── launch.bat         # Launch script for Windows
├── README.md          # This file
├── css/               # Stylesheets
│   └── kitchen_styles.css
├── images/            # Image assets
│   └── kitchen_background.jpg
└── templates/         # HTML pages
    └── Kitchen.html   # Main entry point
```

## Troubleshooting

### Python Not Found

**Error**: `Python is not installed or not in PATH`

**Solution**: 
- Install Python 3.x from [python.org](https://www.python.org/downloads/)
- On Windows, ensure "Add Python to PATH" is checked during installation
- On Unix/Linux, Python is usually pre-installed; try `python3` instead of `python`

### Port Already in Use

**Error**: `Port 8000 is already in use`

**Solution**: The launch script automatically finds the next available port. If you see this message, the script will try ports 8001, 8002, etc. The actual URL will be displayed in the console output.

### Permission Denied (Unix/Linux/macOS)

**Error**: `Permission denied` when running `./launch.sh`

**Solution**: Make the script executable:
```bash
chmod +x launch.sh
```

### Browser Doesn't Open Automatically

The script will display the URL in the console. Manually copy and paste it into your browser:
```
http://localhost:8000/templates/Kitchen.html
```

## Contributing

Feel free to submit issues and enhancement requests!