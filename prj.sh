#!/bin/bash

PROJECTS_FOLDER="$HOME/Projects/"  # your projects folder

function help() {
    echo ""
    echo "Usage:"
    echo "  prj add <project name>       Add project."
    echo "  prj add <git link>           Add project from git host."
    echo "  prj list                     List all projects."
    echo "  prj remove <project name>    Remove project(s)."
    echo "  prj run <project name>       Start project."
    echo "  prj -h --help                Display this information."
    echo ""
}

function add() {
    # add a project
    cd "$PROJECTS_FOLDER" || exit
    
    if [[ $1 == http* ]] ; then  # starts with http
        git clone "$1"
        PROJECT="${1##*/}"  # split by / and take 5th
        PROJECT=$(echo "$PROJECT"| cut -d'.' -f 1)  # remove .git
        echo "Creating project $PROJECT..."
        GIT="git pull $1"
    else
        PROJECT=$1
        GIT=""
        echo "Creating project $PROJECT..."
        mkdir "$PROJECT" || echo "Error occured, mb directory $PROJECT already exists?"
    fi
    
    cd "$MANAGER_PATH" || exit
    
    PROJECTPATH="$MANAGER_PATH/projects/$PROJECT.sh"
    touch "$PROJECTPATH"
    cat >> "$PROJECTPATH" <<- EOM
#!/bin/bash

cd $PROJECTS_FOLDER/$PROJECT || exit
$GIT
code .
EOM
    chmod +x "$PROJECTPATH"
    cd "$PROJECTS_FOLDER/$PROJECT" || exit
    code .
}

function list() {
    # list all projects
    cd "$MANAGER_PATH/projects" || exit
    for f in *.sh; do
        printf '%s\n' "${f%.sh}"
    done

}

function remove() {
    # remove a project
    rm "$MANAGER_PATH/projects/$2.sh"
}

function run() {
    cd "$MANAGER_PATH" || exit
    "./$2.sh"
}

function main() {
    # main function
    case "$1" in
        add)
        if [ "$2" ]; then
            add "$2"
        else
            echo "usage:"
            help
        fi
        ;;
        list)
        list
        ;;
        remove)
        if [ "$2" ]; then
            remove "$2"
        else
            echo "usage:"
            help
        fi
        ;;
        run)
        if [ "$2" ]; then
            run "$2"
        else
            echo "usage:"
            help
        fi
        ;;
        help)
        help
        ;;
        "")
        help
        ;;
    esac
            
}

MANAGER_PATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

main "$@"
