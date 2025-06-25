#!/bin/bash

PRJ_ROOT_DIR="$(dirname "$(dirname "$0")")"
source "$PRJ_ROOT_DIR/common.sh"


if [ $# -ne 2 ]; then
    echo "Usage: prj mv <source-project> <destination-project>" >&2
    exit 1
fi

source_project="$1"
dest_project="$2"

# Находим исходный проект
matches=()
while IFS= read -r project; do
    if [ "$(basename "$project")" = "$source_project" ]; then
        matches+=("$project")
    fi
done < <("$(dirname "$0")/list.sh")

if [ ${#matches[@]} -eq 0 ]; then
    echo "Error: Source project not found: $source_project" >&2
    exit 1
elif [ ${#matches[@]} -gt 1 ]; then
    echo "Multiple source projects found with name '$source_project':" >&2
    for i in "${!matches[@]}"; do
        echo "$((i+1)). ${matches[$i]}"
    done
    read -p "Select source project (1-${#matches[@]}): " choice
    if [[ ! "$choice" =~ ^[0-9]+$ ]] || [ "$choice" -lt 1 ] || [ "$choice" -gt ${#matches[@]} ]; then
        echo "Invalid selection" >&2
        exit 1
    fi
    source_path="${matches[$((choice-1))]}"
else
    source_path="${matches[0]}"
fi

full_source_path="$PRJ_ROOT/$source_path"

# Check if the destination project already exists
if "$(dirname "$0")/list.sh" | grep -q "^$dest_project$"; then
    echo "Error: Destination project already exists: $dest_project" >&2
    exit 1
fi

if [[ "$dest_project" == */* ]]; then
    full_dest_path="$PRJ_ROOT/$dest_project"
else
    full_dest_path="$PRJ_ROOT/$dest_project"
fi

mkdir -p "$(dirname "$full_dest_path")"

echo "Moving project: $source_path -> $dest_project"
mv "$full_source_path" "$full_dest_path"

source_dir=$(dirname "$full_source_path")
if [ -d "$source_dir" ] && [ -z "$(ls -A "$source_dir")" ]; then
    rmdir "$source_dir"
fi
