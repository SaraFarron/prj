#!/bin/bash

PRJ_ROOT_DIR="$(dirname "$(dirname "$0")")"
source "$PRJ_ROOT_DIR/common.sh"


if [ $# -eq 0 ]; then
    echo "Error: Project name or git URL required" >&2
    exit 1
fi

input="$1"

# Проверяем, является ли ввод git URL
if [[ "$input" =~ ^(git@|https?://|git://) ]]; then
    # Если это git URL, добавляем проект и открываем
    "$(dirname "$0")/commands/add.sh" "$input"
    project_name=$(basename "$input" .git)
    input="$project_name"
fi

project_name="$input"
matches=()

while IFS= read -r project; do
    if [ "$(basename "$project")" = "$project_name" ]; then
        matches+=("$project")
    fi
done < <("$(dirname "$0")/commands/list.sh")

if [ ${#matches[@]} -eq 0 ]; then
    echo "Error: Project not found: $project_name" >&2
    exit 1
elif [ ${#matches[@]} -gt 1 ]; then
    echo "Multiple projects found with name '$project_name':" >&2
    for i in "${!matches[@]}"; do
        echo "$((i+1)). ${matches[$i]}"
    done
    read -p "Select project to open (1-${#matches[@]}): " choice
    if [[ ! "$choice" =~ ^[0-9]+$ ]] || [ "$choice" -lt 1 ] || [ "$choice" -gt ${#matches[@]} ]; then
        echo "Invalid selection" >&2
        exit 1
    fi
    project_path="${matches[$((choice-1))]}"
else
    project_path="${matches[0]}"
fi

full_path="$PRJ_ROOT/$project_path"
echo "Opening project: $project_path"
"$PRJ_EDITOR" "$full_path"
