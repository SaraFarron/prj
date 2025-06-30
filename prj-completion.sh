#!/bin/bash

_prj_completion() {
    local cur prev projects commands all_options
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"

    # Command options
    commands="list ls add -a rm remove delete mv move rename goto to help --help -h"

    # Project list
    projects=$(prj list 2>/dev/null)

    # First argument: either a command or a project name
    if [[ $COMP_CWORD -eq 1 ]]; then
        # Use newline separator to visually group commands and projects
        all_options=$(printf "%s\n-- Commands --\n%s" "$commands" "$projects")
        COMPREPLY=( $(compgen -W "$all_options" -- "$cur") )
        return 0
    fi

    # Project completion for specific commands
    if [[ "$prev" =~ ^(rm|remove|delete|goto|to|mv|move|rename|run)$ ]]; then
        COMPREPLY=( $(compgen -W "$projects" -- "$cur") )
        return 0
    fi
}

complete -F _prj_completion prj
