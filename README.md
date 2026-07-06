# KitchenWebsite

A simple, elegant website for showcasing kitchen services and menus.

## Prerequisites

- **Python 3.x** - Required to run the local development server
  - Check if Python is installed: `python3 --version` or `python --version`
  - Download from: [https://www.python.org/downloads/](https://www.python.org/downloads/)

## Running the Application

### Quick Start

The easiest way to run the application is using the provided launch scripts:

#### Unix/Linux/macOS

```bash
./launch.sh
```

#### Windows

```cmd
launch.bat
```

Or simply double-click the `launch.bat` file in Windows Explorer.

### What the Launch Script Does

1. Checks for Python installation
2. Verifies that port 8000 is available
3. Starts a local HTTP server on `http://localhost:8000`
4. Automatically opens your default browser to the Kitchen Website
5. Displays server logs in the console
6. Allows graceful shutdown with `Ctrl+C`

### Manual Launch (Alternative)

If you prefer to start the server manually:

```bash
# Using Python 3
python3 -m http.server 8000

# Or using Python 2
python -m SimpleHTTPServer 8000
```

Then open your browser to: [http://localhost:8000/templates/Kitchen.html](http://localhost:8000/templates/Kitchen.html)

## Troubleshooting

### Port Already in Use

If you see an error that port 8000 is already in use:

1. **Find and stop the process using the port:**
   - **Unix/Linux/macOS**: `lsof -ti:8000 | xargs kill -9`
   - **Windows**: `netstat -ano | findstr :8000` (note the PID, then use Task Manager to end it)

2. **Or use a different port:**
   - Edit `launch.sh` or `launch.bat` and change the `PORT` variable
   - Example: `PORT=8080`

### Python Not Found

If the launch script reports that Python is not installed:

1. Download and install Python from [python.org](https://www.python.org/downloads/)
2. During installation, make sure to check "Add Python to PATH"
3. Restart your terminal/command prompt after installation
4. Verify installation: `python3 --version` or `python --version`

### Permission Denied (Unix/Linux/macOS)

If you get a "Permission denied" error when running `./launch.sh`:

```bash
chmod +x launch.sh
./launch.sh
```

### Browser Doesn't Open Automatically

If the browser doesn't open automatically, manually navigate to:
- [http://localhost:8000/templates/Kitchen.html](http://localhost:8000/templates/Kitchen.html)

## Project Structure

```
KitchenWebsite/
├── launch.sh          # Launch script for Unix/Linux/macOS
├── launch.bat         # Launch script for Windows
├── README.md          # This file
├── templates/         # HTML pages
│   ├── Kitchen.html   # Homepage
│   ├── aboutus.html   # About Us page
│   ├── menu.html      # Menu page
│   ├── services.html  # Services page
│   └── contacts.html  # Contact page
├── css/               # Stylesheets
│   └── style.css
└── images/            # Image assets
    └── background.png
```

## Navigation

- **Home**: Kitchen.html - Main landing page
- **About Us**: aboutus.html - Learn about our kitchen
- **Menu**: menu.html - View our menu offerings
- **Services**: services.html - Explore our services
- **Contact**: contacts.html - Get in touch with us

## Development

The application is a static website with no build process. Simply edit the HTML, CSS, or image files and refresh your browser to see changes.

To stop the development server, press `Ctrl+C` in the terminal where the server is running.