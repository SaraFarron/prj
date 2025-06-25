#!/bin/bash

PRJ_ROOT="${PRJ_ROOT:-$HOME/projects}"  # Глобальная переменная для корневой папки проектов
PRJ_EDITOR="${PRJ_EDITOR:-code}"       # Редактор по умолчанию (VS Code)

# Проверяем, существует ли папка проектов, если нет - создаем
[ -d "$PRJ_ROOT" ] || mkdir -p "$PRJ_ROOT"

case "$1" in
    list)
        shift
        exec "$(dirname "$0")/prj-list" "$@"
        ;;
    add)
        shift
        exec "$(dirname "$0")/prj-add" "$@"
        ;;
    rm|remove|delete)
        shift
        exec "$(dirname "$0")/prj-rm" "$@"
        ;;
    help|--help|-h)
        exec "$(dirname "$0")/prj-help"
        ;;
    *)
        # Если первый аргумент не команда, то это имя проекта или git-репозиторий
        exec "$(dirname "$0")/prj-open" "$@"
        ;;
esac
