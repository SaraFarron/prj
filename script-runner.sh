#!/bin/bash

function main() {
    if [ -d "$1" ]; then
        cd "$1"
    else
        echo "Group '$1' does not exist"
        exit 1
    fi
    
    if [ -f "$2.sh" ]; then
        "./$2.sh"
    else
        echo "Script '$2' does not exist"
        exit 1
    fi
    exit 0
}

main "$1" "$2"
