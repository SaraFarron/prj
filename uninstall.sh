#!/bin/bash

# Universal uninstaller for both local and global installations

# Global paths (require root)
GLOBAL_BIN="/usr/local/bin/prj"
GLOBAL_BIN_LINKS=("/usr/local/bin/prj-"*)  # All prj-* commands
GLOBAL_SHARE="/usr/local/share/prj"

# Local paths (user install)
LOCAL_BIN="$HOME/.local/bin/prj"
LOCAL_BIN_LINKS=("$HOME/.local/bin/prj-"*)  # All prj-* commands
LOCAL_SHARE="$HOME/.local/share/prj"

# Config path (common)
CONFIG_DIR="$HOME/.config/prj"

echo "Uninstalling prj project manager..."

# Detect installation type
if [ -f "$GLOBAL_BIN" ] || [ -d "$GLOBAL_SHARE" ]; then
    if [ "$(id -u)" -ne 0 ]; then
        echo "Found system-wide installation. Please run with sudo."
        exit 1
    fi
    INSTALL_TYPE="global"
else
    INSTALL_TYPE="local"
fi

# Remove appropriate files
case "$INSTALL_TYPE" in
    global)
        echo "Removing system-wide installation..."
        # Binaries
        [ -f "$GLOBAL_BIN" ] && rm -v "$GLOBAL_BIN"
        for link in ${GLOBAL_BIN_LINKS[@]}; do
            [ -L "$link" ] && rm -v "$link"
        done
        # Share dir
        [ -d "$GLOBAL_SHARE" ] && rm -rfv "$GLOBAL_SHARE"
        ;;
    local)
        echo "Removing user-local installation..."
        # Binaries
        [ -f "$LOCAL_BIN" ] && rm -v "$LOCAL_BIN"
        for link in ${LOCAL_BIN_LINKS[@]}; do
            [ -L "$link" ] && rm -v "$link"
        done
        # Share dir
        [ -d "$LOCAL_SHARE" ] && rm -rfv "$LOCAL_SHARE"
        ;;
esac

# Handle config files (common to both)
if [ -d "$CONFIG_DIR" ]; then
    echo "Remove configuration files? [y/N]"
    read answer
    if [[ "$answer" =~ ^[Yy]$ ]]; then
        rm -rfv "$CONFIG_DIR"
    else
        echo "Keeping configuration files in $CONFIG_DIR"
    fi
fi

# Verify removal
if ! command -v prj &> /dev/null; then
    echo "Uninstall complete! prj has been removed."
else
    echo "Warning: prj might still be available elsewhere in your PATH."
fi

echo "Note: Your project files in \$PRJ_ROOT ($PRJ_ROOT) were not removed."
