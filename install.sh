#!/bin/bash

set -e

MIN_VERSION=11
WINEPREFIX="$HOME/.wine-serato"
WINEARCH="win64"
DOWNLOAD_URL="https://serato.com/dj/pro/downloads"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Checking Wine installation..."

# Check Wine availability
if ! command -v wine &> /dev/null; then
    echo "Wine is not installed."
    echo "Install it using your package manager (example: sudo pacman -S wine winetricks)."
    exit 1
fi

# Extract Wine version
WINE_VERSION_RAW=$(wine --version)
WINE_VERSION=$(echo "$WINE_VERSION_RAW" | grep -oE '[0-9]+' | head -n1)

echo "Detected Wine version: $WINE_VERSION_RAW"

if [[ "$WINE_VERSION" -lt "$MIN_VERSION" ]]; then
    echo "Wine version $MIN_VERSION or higher is required."
    exit 1
fi

echo "Wine version requirement satisfied."

# Create prefix if it does not exist
if [[ ! -d "$WINEPREFIX" ]]; then
    echo "Creating Wine prefix at $WINEPREFIX"
    WINEPREFIX="$WINEPREFIX" WINEARCH="$WINEARCH" wineboot --init
fi

# If no installer provided
if [[ -z "$1" ]]; then
    echo "No installer provided."
    echo "Download Serato DJ Pro from:"
    echo "$DOWNLOAD_URL"
    echo "Then run:"
    echo "./install.sh /path/to/SeratoDJPro.exe"
    exit 0
fi

# Validate installer path
if [[ ! -f "$1" ]]; then
    echo "Installer not found: $1"
    exit 1
fi

echo "Starting Serato installation..."
WINEPREFIX="$WINEPREFIX" wine "$1"

echo "Installation completed."

echo "Launching configuration script..."
bash "$SCRIPT_DIR/configure.sh"

echo "Setup completed."
