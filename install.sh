#!/bin/bash

# Configuration
REPO_URL="https://github.com/SaraFarron/prj.git"
INSTALL_DIR="/usr/local/bin/prj"
BIN_DIR="/usr/local/bin"
PRJ_DIR="/usr/local/share/prj"

# Check for git
if ! command -v git &> /dev/null; then
    echo "Error: git is required but not installed" >&2
    exit 1
fi

# Check for root
if [ "$(id -u)" -ne 0 ]; then
    echo "This installer needs root privileges to install to system directories" >&2
    exit 1
fi

# Create temp directory
TMP_DIR=$(mktemp -d)
trap 'rm -rf "$TMP_DIR"' EXIT

# Clone repository
echo "Cloning repository..."
if ! git clone "$REPO_URL" "$TMP_DIR"; then
    echo "Error: Failed to clone repository" >&2
    exit 1
fi

# Create installation directories
echo "Creating directories..."
mkdir -p "$PRJ_DIR" "$BIN_DIR"

# Install files
echo "Installing files..."
cp -r "$TMP_DIR"/* "$PRJ_DIR/"

# Create symlink
echo "Creating symlink..."
ln -sf "$PRJ_DIR/prj.sh" "$INSTALL_DIR"

# Set permissions
echo "Setting permissions..."
chmod +x "$PRJ_DIR/prj.sh"
chmod +x "$PRJ_DIR"/commands/*.sh

# Verify installation
if command -v prj &> /dev/null; then
    echo "Installation complete!"
    echo "You can now use 'prj' command from anywhere"
else
    echo "Error: Installation failed" >&2
    exit 1
fi
