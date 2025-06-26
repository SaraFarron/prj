#!/bin/bash

REPO_URL="https://github.com/SaraFarron/prj.git"
TARGET_DIR="$HOME/.local/share/prj"
BIN_DIR="$HOME/.local/bin"

# Create directories
mkdir -p "$TARGET_DIR" "$BIN_DIR"

# Clone repo
if [ -d "$TARGET_DIR/.git" ]; then
    echo "Updating existing installation..."
    cd "$TARGET_DIR" && git pull
else
    echo "Cloning repository..."
    git clone "$REPO_URL" "$TARGET_DIR"
fi

# Create main symlink
ln -sf "$TARGET_DIR/prj.sh" "$BIN_DIR/prj"

# Set permissions
chmod +x "$TARGET_DIR"/prj.sh
chmod +x "$TARGET_DIR"/commands/*.sh

# Ensure bin dir is in PATH
if [[ ":$PATH:" != *":$BIN_DIR:"* ]]; then
    echo "Adding $BIN_DIR to your PATH..."
    echo "export PATH=\"\$PATH:$BIN_DIR\"" >> "$HOME/.bashrc"
    echo "export PATH=\"\$PATH:$BIN_DIR\"" >> "$HOME/.zshrc"  # For zsh users
    source "$HOME/.bashrc"
fi

echo "Installation complete!"
echo "Project files are in: $TARGET_DIR"
echo "Symlink is in: $BIN_DIR/prj"
