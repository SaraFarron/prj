#!/bin/bash


# Get the real path of this script (following symlinks)
SCRIPT_PATH="$(readlink -f "${BASH_SOURCE[0]}")"
PRJ_INSTALL_DIR="$(dirname "$SCRIPT_PATH")"

# If we're called via symlink, find the real installation dir
if [ -L "$PRJ_INSTALL_DIR/prj.sh" ]; then
    PRJ_INSTALL_DIR="$(dirname "$(readlink -f "$PRJ_INSTALL_DIR/prj.sh")")"
fi

# Load common.sh from the installation directory
if [ -f "$PRJ_INSTALL_DIR/common.sh" ]; then
    source "$PRJ_INSTALL_DIR/common.sh"
else
    echo "Error: Could not find common.sh in $PRJ_INSTALL_DIR" >&2
    exit 1
fi


if [ $# -eq 0 ]; then
    exec "$(dirname "$0")/commands/help.sh"
    exit 0
fi

case "$1" in
    list)
        shift
        exec "$(dirname "$0")/commands/list.sh" "$@"
        ;;
    add)
        shift
        exec "$(dirname "$0")/commands/add.sh" "$@"
        ;;
    rm|remove|delete)
        shift
        exec "$(dirname "$0")/commands/rm.sh" "$@"
        ;;
    mv|move|rename)
        shift
        exec "$(dirname "$0")/commands/mv.sh" "$@"
        ;;
    help|--help|-h)
        exec "$(dirname "$0")/commands/help.sh"
        ;;
    *)
        exec "$(dirname "$0")/commands/run.sh" "$@"
        ;;
esac
