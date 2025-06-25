#!/bin/bash

PRJ_ROOT_DIR="$(dirname "$(dirname "$0")")"
source "$PRJ_ROOT_DIR/common.sh"


find_projects() {
    local dir="$1"
    
    # Find all directories (excluding dot-prefixed ones) at current level
    find "$dir" -mindepth 1 -maxdepth 1 -type d -not -path '*/.*' -print0 | while IFS= read -r -d '' subdir; do
        
        # Check if this directory contains any regular files (not just subdirectories)
        if [ -n "$(find "$subdir" -maxdepth 1 -type f -not -path '*/.*' -print -quit)" ]; then
            # If it contains files, it's a project - print relative path
            echo "${subdir#$PRJ_ROOT/}"
        else
            # If no files found, it's a container directory - search deeper
            find_projects "$subdir"
        fi
    done
}

# Find all projects, sort them uniquely and print
find_projects "$PRJ_ROOT" | sort -u
