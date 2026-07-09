# KitchenWebsite

A static website for a kitchen/restaurant business featuring home page, menu, services, about us, and contact pages.

## Quick Start

### Prerequisites

- **Python 3.x** is required to run the local development server
  - Check if Python is installed: `python3 --version` (Unix/Linux/macOS) or `python --version` (Windows)
  - Download from [python.org](https://www.python.org/downloads/) if needed

### Running the Application

#### Unix/Linux/macOS

```bash
./launch.sh
```

#### Windows

Double-click `launch.bat` or run from command prompt:

```cmd
launch.bat
```

### What the Launch Script Does

- Starts a local HTTP server on port 8000
- Automatically opens the application in your default web browser
- Displays server status and URL in the console
- Serves the application at `http://localhost:8000/templates/Kitchen.html`

### Stopping the Server

Press `Ctrl+C` in the terminal/command prompt where the server is running.

### Manual Setup (Alternative)

If you prefer to run the server manually:

```bash
# Unix/Linux/macOS
python3 -m http.server 8000

# Windows
python -m http.server 8000
```

Then open your browser and navigate to: `http://localhost:8000/templates/Kitchen.html`

## Project Structure

```
project-root/
├── launch.sh          # Launch script for Unix/Linux/macOS
├── launch.bat         # Launch script for Windows
├── README.md          # This file
├── css/               # Stylesheets
├── images/            # Image assets
└── templates/         # HTML pages
    ├── Kitchen.html   # Home page
    ├── menu.html      # Menu page
    ├── services.html  # Services page
    ├── aboutus.html   # About Us page
    └── contacts.html  # Contact page
```