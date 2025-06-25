#!/bin/bash

PRJ_ROOT="${PRJ_ROOT:-$HOME/projects}"  # Глобальная переменная для корневой папки проектов
PRJ_EDITOR="${PRJ_EDITOR:-code}"       # Редактор по умолчанию (VS Code)

# Проверяем, существует ли папка проектов, если нет - создаем
[ -d "$PRJ_ROOT" ] || mkdir -p "$PRJ_ROOT"

# Если нет аргументов - показываем справку
if [ $# -eq 0 ]; then
    exec "$(dirname "$0")/commands/help.sh"
    exit 0
fi

case "$1" in
    list)
        shift
        exec "$(dirname "$0")/commands/list.sh" "$@"
        ;;
    add)
        shift
        exec "$(dirname "$0")/commands/add.sh" "$@"
        ;;
    rm|remove|delete)
        shift
        exec "$(dirname "$0")/commands/rm.sh" "$@"
        ;;
    mv|move|rename)
        shift
        exec "$(dirname "$0")/commands/mv.sh" "$@"
        ;;
    help|--help|-h)
        exec "$(dirname "$0")/commands/help.sh"
        ;;
    *)
        # Если первый аргумент не команда, то это имя проекта или git-репозиторий
        exec "$(dirname "$0")/commands/run.sh" "$@"
        ;;
esac
