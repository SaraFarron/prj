#!/bin/bash

# Configuration for local user install
REPO_URL="https://github.com/SaraFarron/prj.git"
LOCAL_BIN="$HOME/.local/bin"
LOCAL_SHARE="$HOME/.local/share/prj"

# Check for git
if ! command -v git &> /dev/null; then
    echo "Error: git is required but not installed" >&2
    exit 1
fi

# Create directories
mkdir -p "$LOCAL_BIN" "$LOCAL_SHARE"

# Clone or update repository
if [ -d "$LOCAL_SHARE/.git" ]; then
    echo "Updating existing installation..."
    cd "$LOCAL_SHARE" && git pull
else
    echo "Cloning repository..."
    git clone "$REPO_URL" "$LOCAL_SHARE"
fi

# Create symlink
ln -sf "$LOCAL_SHARE/prj.sh" "$LOCAL_BIN/prj"

# Set permissions
chmod +x "$LOCAL_SHARE/prj.sh"
chmod +x "$LOCAL_SHARE"/commands/*.sh

# Add to PATH if needed
if [[ ":$PATH:" != *":$LOCAL_BIN:"* ]]; then
    echo "Adding $LOCAL_BIN to your PATH..."
    echo "export PATH=\"\$PATH:$LOCAL_BIN\"" >> "$HOME/.bashrc"
    source "$HOME/.bashrc"
fi

echo "Installation complete!"
echo "You can now use 'prj' command from anywhere"
