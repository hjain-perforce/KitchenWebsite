# KitchenWebsite

A static website for Mom's Kitchen - a delightful food court featuring snacks, South Indian cuisine, and more.

## Prerequisites

- **Python 3.x** - Required to run the local HTTP server
  - Check if Python is installed: `python3 --version` (Unix/Linux/macOS) or `python --version` (Windows)
  - Download from [python.org](https://www.python.org/downloads/) if needed

## Quick Start

### Unix/Linux/macOS

1. Open a terminal in the project directory
2. Run the launch script:
   ```bash
   ./launch.sh
   ```
3. The application will automatically open in your default browser at `http://localhost:8000`
4. Press `Ctrl+C` in the terminal to stop the server

### Windows

1. Open the project folder in File Explorer
2. Double-click `launch.bat` or run it from Command Prompt:
   ```cmd
   launch.bat
   ```
3. The application will automatically open in your default browser at `http://localhost:8000`
4. Press `Ctrl+C` in the command window to stop the server

## Manual Start (Alternative)

If you prefer to start the server manually:

```bash
# Unix/Linux/macOS
python3 -m http.server 8000

# Windows
python -m http.server 8000
```

Then open your browser and navigate to `http://localhost:8000`

## Project Structure

```
KitchenWebsite/
├── launch.sh          # Launch script for Unix/Linux/macOS
├── launch.bat         # Launch script for Windows
├── index.html         # Entry point (redirects to Kitchen.html)
├── templates/
│   ├── Kitchen.html   # Main home page
│   ├── aboutus.html   # About us page
│   ├── menu.html      # Menu page
│   ├── services.html  # Services page
│   └── contacts.html  # Contact page
├── css/
│   └── kitchen_styles.css
└── images/
    └── ... (site images)
```

## Troubleshooting

### Port Already in Use

If port 8000 is already in use, the launch scripts will automatically try ports 8001-8010. If all ports are busy:

- **Unix/Linux/macOS**: Close other applications using these ports or manually specify a different port:
  ```bash
  python3 -m http.server 9000
  ```

- **Windows**: Close other applications or manually specify a different port:
  ```cmd
  python -m http.server 9000
  ```

### Python Not Found

- **Unix/Linux/macOS**: Install Python 3 using your package manager:
  - Ubuntu/Debian: `sudo apt-get install python3`
  - macOS: `brew install python3` (requires Homebrew)

- **Windows**: Download and install from [python.org](https://www.python.org/downloads/). Make sure to check "Add Python to PATH" during installation.

### Browser Doesn't Open Automatically

If the browser doesn't open automatically, manually navigate to the URL shown in the console output (typically `http://localhost:8000`).

### Permission Denied (Unix/Linux/macOS)

If you get a permission error when running `./launch.sh`:

```bash
chmod +x launch.sh
./launch.sh
```

## Features

- Air Conditioned dining
- Free WiFi
- Parking available
- All cards accepted
- Elevator access
- Free home delivery
- Take away service
- Party bookings available