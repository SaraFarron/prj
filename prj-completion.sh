#!/bin/bash

_prj_completion() {
    local cur prev commands projects
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"

    commands="list ls add -a rm remove delete mv move rename goto to help --help -h"

    # Suggest commands after `prj`
    if [[ $COMP_CWORD -eq 1 ]]; then
        COMPREPLY=( $(compgen -W "$commands" -- "$cur") )
        return 0
    fi

    # Commands that take a project name as argument
    if [[ "$prev" =~ ^(rm|remove|delete|goto|to|mv|move|rename|run)$ ]]; then
        # Use 'prj list' to get available projects
        projects=$(prj list 2>/dev/null)
        COMPREPLY=( $(compgen -W "$projects" -- "$cur") )
        return 0
    fi
}

complete -F _prj_completion prj
