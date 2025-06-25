#!/bin/bash

PRJ_ROOT_DIR="$(dirname "$(dirname "$0")")"
source "$PRJ_ROOT_DIR/common.sh"


if [ $# -eq 0 ]; then
    echo "Error: Project name or git URL required" >&2
    exit 1
fi

input="$1"
project_path=""
git_url=""

# Check if input is git URL
if [[ "$input" =~ ^(git@|https?://|git://) ]]; then
    git_url="$input"
    project_name=$(basename "$git_url" .git)
    project_path="$PRJ_ROOT/$project_name"
else
    if [[ "$input" == */* ]]; then
        project_path="$PRJ_ROOT/$input"
        # Check if last part is git URL
        last_part=$(basename "$input")
        if [[ "$last_part" =~ ^(git@|https?://|git://) ]]; then
            git_url="$last_part"
            project_path="$PRJ_ROOT/$(dirname "$input")/$(basename "$git_url" .git)"
        fi
    else
        project_path="$PRJ_ROOT/$input"
    fi
fi

# Check if project already exists
if [ -d "$project_path" ]; then
    echo "Error: Project already exists: ${project_path#$PRJ_ROOT/}" >&2
    exit 1
fi

mkdir -p "$project_path"

# Clone if git URL is provided
if [ -n "$git_url" ]; then
    echo "Cloning $git_url to $project_path..."
    git clone "$git_url" "$project_path"
    if [ $? -ne 0 ]; then
        echo "Error: Failed to clone repository" >&2
        rm -rf "$project_path"
        exit 1
    fi
else
    echo "Created empty project at ${project_path#$PRJ_ROOT/}"
fi
