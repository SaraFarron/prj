#!/bin/bash

_prj_completion() {
    local cur prev projects commands
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"

    commands="list ls add -a rm remove delete mv move rename goto to cd help --help -h init"

    projects=$(prj list 2>/dev/null)

    if [[ $COMP_CWORD -eq 1 ]]; then
        COMPREPLY=( $(compgen -W "$commands $projects" -- "$cur") )
        return 0
    fi

    if [[ "$prev" =~ ^(rm|remove|delete|goto|to|mv|move|rename|run|init)$ ]]; then
        COMPREPLY=( $(compgen -W "$projects" -- "$cur") )
        return 0
    fi
}

complete -F _prj_completion prj
