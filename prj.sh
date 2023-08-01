#!/bin/bash

PROJECTS_FOLDER="$HOME/Projects/"  # your projects folder
EDITOR_COMMAND="code ."  # edit to run in your favourite editor

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
    
    if [[ $1 == http* ]] ; then
        
        # creates project from git link
        PROJECT="${1##*/}"  # split by / and take last
        PROJECT=$(echo "$PROJECT"| cut -d'.' -f 1)  # remove .git
        if [ -f "$MANAGER_PATH/projects/$PROJECT.sh" ]; then
            echo "$PROJECT already exists"
            exit
        fi
        echo "Creating project $PROJECT..."
        git clone "$1"
        GIT="git pull $1"
    else
        
        # creates empty project without git
        PROJECT=$1
        if [ -f "$MANAGER_PATH/projects/$PROJECT.sh" ]; then
            echo "$PROJECT already exists"
            exit
        fi
        GIT=""
        echo "Creating project $PROJECT..."
        mkdir "$PROJECT" || echo "Directory $PROJECT already exists"
    fi
    
    cd "$MANAGER_PATH" || exit
    
    echo "Creating project config..."
    PROJECTPATH="$MANAGER_PATH/projects/$PROJECT.sh"
    touch "$PROJECTPATH"
    
    # here you can edit default project script
    cat >> "$PROJECTPATH" <<- EOM
#!/bin/bash

cd $PROJECTS_FOLDER/$PROJECT || exit
$GIT
$EDITOR_COMMAND
EOM
    chmod +x "$PROJECTPATH"
    
    echo "Project $PROJECT created"
    # opens project after creation
    cd "$PROJECTS_FOLDER/$PROJECT" || exit
    $EDITOR_COMMAND
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
    while true; do
        read -p "Do you also want to remove $PROJECTS_FOLDER/$2? " yn
        case $yn in
            [Yy]* ) rm -rf "${PROJECTS_FOLDER:?}/$2"; break;;
            [Nn]* ) exit;;
            * ) echo "Please answer yes or no.";;
        esac
    done

}

function run() {
    cd "$MANAGER_PATH/projects/" || exit
    "./$1.sh"
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
