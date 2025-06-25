#!/bin/bash

PRJ_ROOT_DIR="$(dirname "$(dirname "$0")")"
source "$PRJ_ROOT_DIR/common.sh"

find_projects() {
    local dir="$1"
    while IFS= read -r -d '' project; do
        echo "$project"
    done < <(find "$dir" -mindepth 1 -type d -exec bash -c '
        for dir do
            # Проверяем, есть ли в папке файлы (не папки)
            if [ -n "$(find "$dir" -maxdepth 1 -type f -print -quit)" ]; then
                printf "%s\0" "$dir"
            fi
        done
    ' bash {} +)
}

find_projects "$PRJ_ROOT" | sort | while read -r project; do
    echo "${project#$PRJ_ROOT/}"
done
