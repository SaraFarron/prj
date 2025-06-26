#!/bin/bash

# Global uninstaller (run with sudo)

INSTALL_DIR="/usr/local/bin/prj"
PRJ_DIR="/usr/local/share/prj"

# User-local uninstaller (run without sudo)
LOCAL_BIN="$HOME/.local/bin/prj"
LOCAL_SHARE="$HOME/.local/share/prj"

echo "Uninstalling prj..."

# Remove global installation
if [ -f "$INSTALL_DIR" ] || [ -d "$PRJ_DIR" ]; then
    if [ "$(id -u)" -ne 0 ]; then
        echo "Found system-wide installation. Please run with sudo to remove."
        exit 1
    fi
    
    echo "Removing system-wide installation:"
    [ -f "$INSTALL_DIR" ] && rm -v "$INSTALL_DIR"
    [ -d "$PRJ_DIR" ] && rm -rfv "$PRJ_DIR"
fi

# Remove user-local installation
if [ -f "$LOCAL_BIN" ] || [ -d "$LOCAL_SHARE" ]; then
    echo "Removing user-local installation:"
    [ -f "$LOCAL_BIN" ] && rm -v "$LOCAL_BIN"
    [ -d "$LOCAL_SHARE" ] && rm -rfv "$LOCAL_SHARE"
fi

# Verify removal
if ! command -v prj &> /dev/null; then
    echo "Uninstall complete! prj has been removed."
else
    echo "Warning: prj might still be available in your PATH."
fi
