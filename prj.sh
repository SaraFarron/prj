#!/bin/bash


# First, properly set the root directory path
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Then source common.sh with full path verification
if [ -f "$SCRIPT_DIR/common.sh" ]; then
    source "$SCRIPT_DIR/common.sh"
else
    echo "Error: common.sh not found in $SCRIPT_DIR" >&2
    exit 1
fi

# Safely create PRJ_ROOT directory if it doesn't exist
if [ -n "$PRJ_ROOT" ] && [ ! -d "$PRJ_ROOT" ]; then
    mkdir -p "$PRJ_ROOT" || {
        echo "Error: Failed to create project directory: $PRJ_ROOT" >&2
        exit 1
    }
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
        # Если первый аргумент не команда, то это имя проекта или git-репозиторий
        exec "$(dirname "$0")/commands/run.sh" "$@"
        ;;
esac
