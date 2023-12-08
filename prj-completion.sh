#!/bin/bash

# https://askubuntu.com/a/345150/1714665
# https://habr.com/ru/articles/115886/

_prj_completion() {
    COMPREPLY=() # пока что мы не знаем, что предложить пользователю, поэтому создадим пустой список.
    cur="${COMP_WORDS[COMP_CWORD]}" #получаем текущий вводимый аргумент
    subcommands_1=$(prj list) # массив подкоманд первого уровня - см. синтаксическое дерево в начале поста.

    if [[ ${COMP_CWORD} == 1 ]] ; then # если вводится первый аргумент, то попробуем его дополнить
        COMPREPLY=( $(compgen -W "${subcommands_1}" -- ${cur}) ) # some magic
        return 0 # COMPREPLY заполнен, можно выходить
    fi
}

complete -F _prj_completion prj
