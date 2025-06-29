#!/bin/bash

# Get the real path of this script (following symlinks)
SCRIPT_PATH="$(readlink -f "${BASH_SOURCE[0]}")"
PRJ_INSTALL_DIR="$(dirname "$SCRIPT_PATH")"

# If we're called via symlink, find the real installation dir
if [ -L "$SCRIPT_PATH" ]; then
    PRJ_INSTALL_DIR="$(dirname "$(readlink -f "$SCRIPT_PATH")")"
fi

# Load common.sh from the installation directory
COMMON_PATH="$PRJ_INSTALL_DIR/common.sh"
if [ ! -f "$COMMON_PATH" ]; then
    # Fallback to share directory if not found in bin
    PRJ_INSTALL_DIR="$HOME/.local/share/prj"
    COMMON_PATH="$PRJ_INSTALL_DIR/common.sh"
fi

if [ -f "$COMMON_PATH" ]; then
    source "$COMMON_PATH"
else
    echo "Error: Could not find common.sh" >&2
    exit 1
fi

# Determine commands directory
COMMANDS_DIR="$PRJ_INSTALL_DIR/commands"
if [ ! -d "$COMMANDS_DIR" ]; then
    # Fallback to share directory
    COMMANDS_DIR="$HOME/.local/share/prj/commands"
fi

if [ $# -eq 0 ]; then
    exec "$COMMANDS_DIR/help.sh"
    exit 0
fi

case "$1" in
    list|ls)
        shift
        exec "$COMMANDS_DIR/list.sh" "$@"
        ;;
    add|-a)
        shift
        exec "$COMMANDS_DIR/add.sh" "$@"
        ;;
    rm|remove|delete)
        shift
        exec "$COMMANDS_DIR/rm.sh" "$@"
        ;;
    mv|move|rename)
        shift
        exec "$COMMANDS_DIR/mv.sh" "$@"
        ;;
    goto|to)
        shift
        exec "$COMMANDS_DIR/goto.sh" "$@"
        ;;
    help|--help|-h)
        exec "$COMMANDS_DIR/help.sh"
        ;;
    *)
        exec "$COMMANDS_DIR/run.sh" "$@"
        ;;
esac
