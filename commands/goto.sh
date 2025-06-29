#!/bin/bash

source "$(dirname "$(dirname "${BASH_SOURCE[0]}")")/common.sh"

if [ $# -eq 0 ]; then
    echo "Usage: prj goto <project-name>" >&2
    exit 1
fi

project_name="$1"
matches=()

while IFS= read -r project; do
    if [ "$(basename "$project")" = "$project_name" ]; then
        matches+=("$project")
    fi
done < <("$(dirname "$0")/list.sh")

if [ ${#matches[@]} -eq 0 ]; then
    echo "Error: Project not found: $project_name" >&2
    exit 1
elif [ ${#matches[@]} -gt 1 ]; then
    echo "Multiple projects found with name '$project_name':" >&2
    for i in "${!matches[@]}"; do
        echo "$((i+1)). ${matches[$i]}"
    done
    read -p "Select project (1-${#matches[@]}): " choice
    if [[ ! "$choice" =~ ^[0-9]+$ ]] || [ "$choice" -lt 1 ] || [ "$choice" -gt ${#matches[@]} ]; then
        echo "Invalid selection" >&2
        exit 1
    fi
    project_path="${matches[$((choice-1))]}"
else
    project_path="${matches[0]}"
fi

full_path="$PRJ_ROOT/$project_path"
echo "Changing to project directory: $full_path"
cd "$full_path" || {
    echo "Error: Failed to change directory" >&2
    exit 1
}

exec "$SHELL"
