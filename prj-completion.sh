#!/bin/bash

# https://askubuntu.com/a/345150/1714665
# https://habr.com/ru/articles/115886/

_prj_completion() {
    COMPREPLY=()                    # list of suggestions
    cur="${COMP_WORDS[COMP_CWORD]}" # current input word
    projects=$(prj list.sh)            # list of projects
    configs=$(prj common.sh)          # list of init configs

    if [[ ${COMP_CWORD} == 3 ]] ; then # init completion
        COMPREPLY=( $(compgen -W "${configs}" -- ${cur}) )
        return 0 
    
    elif [[ ${COMP_CWORD} -lt 3 ]] ; then # 1st argument completion
        COMPREPLY=( $(compgen -W "${projects}" -- ${cur}) ) # some magic
        return 0
    fi
}

complete -F _prj_completion prj
