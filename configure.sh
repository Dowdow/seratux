#!/bin/bash

set -e

WINEPREFIX="$HOME/.wine-serato"
WINEARCH="win64"
SERATO_PATH="C:\\Program Files\\Serato\\Serato DJ Pro\\Serato DJ Pro.exe"

echo "Starting Serato configuration..."

export WINEPREFIX
export WINEARCH

# Ensure winetricks exists
if ! command -v winetricks &> /dev/null; then
    echo "winetricks is not installed."
    echo "Install it using your package manager."
    exit 1
fi

# echo "Installing required Winetricks components..."

# winetricks -q corefonts
# winetricks -q wininet
# winetricks -q winhttp
# winetricks -q gdiplus
# winetricks -q webview2

# echo "Setting Windows version to Windows 10..."
# winetricks -q win10

echo "Registering seratodjpro protocol inside Wine..."

wine regedit serato-protocol.reg

echo "Creating Linux protocol handler..."

mkdir -p "$HOME/.local/bin"
mkdir -p "$HOME/.local/share/applications"

cat > "$HOME/.local/bin/seratodjpro-handler" <<EOF
#!/bin/bash
export WINEPREFIX="$WINEPREFIX"
export WINEARCH="$WINEARCH"
wine start "\$1"
EOF

chmod +x "$HOME/.local/bin/seratodjpro-handler"

cat > "$HOME/.local/share/applications/seratodjpro-handler.desktop" <<EOF
[Desktop Entry]
Name=Serato DJ Pro Protocol
Exec=$HOME/.local/bin/seratodjpro-handler %u
Type=Application
NoDisplay=true
MimeType=x-scheme-handler/seratodjpro;
EOF

xdg-mime default seratodjpro-handler.desktop x-scheme-handler/seratodjpro
update-desktop-database "$HOME/.local/share/applications"

echo "Configuration complete."
