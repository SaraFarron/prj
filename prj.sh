#!/bin/bash

source "$PRJ_PATH/const.sh"

function help {
    echo ""
    echo "Usage:"
    echo "  prj add <project name>           Add project."
    echo "  prj add <git link>               Add project from git host."
    echo "  prj list                         List all projects."
    echo "  prj remove <project name>        Remove project(s)."
    echo "  prj run <project name>           Start project."
    echo "  prj init <project name> <config> Init project."
    echo "  prj -h --help                    Display this information."
    echo ""
}

function create-run-script {
    # creates run file for a project
    echo "Creating project config..."
    PROJECTPATH="$SCRIPTS/$PROJECT.sh"
    touch "$PROJECTPATH"

    # here you can edit default project script
    cat >> "$PROJECTPATH" <<- EOM
#!/bin/bash

cd $PROJECTS_FOLDER/$PROJECT || exit
$GIT
$EDITOR_COMMAND
EOM
}

function clone-project {
    # creates project from git link
    PROJECT="${1##*/}"  # split by / and take last
    PROJECT=$(echo "$PROJECT"| cut -d'.' -f 1)  # remove .git
    if [ -f "$SCRIPTS/$PROJECT.sh" ]; then
        echo "$PROJECT already exists"
        exit 1
    fi
    echo "Creating project $PROJECT..."
    git clone "$1"
}

function create-project {
    # creates empty project without git
    PROJECT=$1
    if [ -f "$SCRIPTS/$PROJECT.sh" ]; then
        echo "$PROJECT already exists"
        exit 1
    fi

    echo "Creating project $PROJECT..."
    mkdir "$PROJECT" || echo "Directory $PROJECT already exists"
}

function add {
    # add a project
    cd "$PROJECTS_FOLDER" ||exit 1
    
    if [[ $1 == http* ]] ; then
        clone-project "$1"
        GIT="git fetch $1"
    else
        create-project "$1"
        GIT=""
    fi
    
    cd "$PRJ_PATH" || exit
    create-run-script
    chmod +x "$PROJECTPATH"
    echo "Project $PROJECT created"

    # opens project after creation
    cd "$PROJECTS_FOLDER/$PROJECT" || exit 1
    $EDITOR_COMMAND
}

function list {
    # list all projects
    cd "$SCRIPTS" || exit 1
    for f in *.sh; do
        printf '%s\n' "${f%.sh}"
    done

}

function remove {
    # remove a project
    if [ ! -f "$SCRIPTS/$1.sh" ]; then
        echo "Project does not exist"
        exit 1
    fi
    rm "$SCRIPTS/$1.sh"
    while true; do
        read -p "Do you also want to remove $PROJECTS_FOLDER/$1? " yn
        case $yn in
            [Yy]* ) rm -rf "${PROJECTS_FOLDER:?}/$1"; break;;
            [Nn]* ) exit;;
            * ) echo "Please answer yes or no.";;
        esac
    done

}

function run {
    if [ ! -f "$SCRIPTS/$1.sh" ]; then
        echo "Project does not exist"
        exit 1
    fi
    cd "$SCRIPTS" || exit 1
    "./$1.sh"
}

function init {
    if [ ! -e "$PROJECTS_FOLDER/$1" ]; then
        add "$1" || exit 1
    fi
    
    cd "$PROJECTS_FOLDER/$1" || exit 1
    for config in "${@:2}"
    do
        if [ ! -f "$CONFIG_SCRIPTS/$config.sh" ]; then
            echo "There is no $config config"
            continue
        fi
        echo "Executing $config..."
        /bin/bash "$CONFIG_SCRIPTS/$config.sh"
    done
    
}

function init-list {
    # list all init configs
    cd "$CONFIG_SCRIPTS" || 1
    for f in *.sh; do
        printf '%s\n' "${f%.sh}"
    done
}

function save-tag {
    "$1 $2" >> "$PRJ_PATH/tags.txt"
}

function list-tag {
    declare -A tags
    while IFS= read -r line
    do
        tags["${line%% *}"]=${line#* }
    done < "$TAGS"
    return "${tags[@]}"
}

function tag {
    if [[ "${list}" == *"${1}"* ]]; then
        echo "${list} contains: ${1}"
    fi
    
    echo "tag functionality"
}

function main {
    # main function
    case "$1" in
    add)
        if [ "$2" ]; then
            add "$2"
        fi
    ;;
    list)
        list
    ;;
    remove)
        if [ "$2" ]; then
            remove "$2"
        fi
    ;;
    run)
        if [ "$2" ]; then
            run "$2"
        fi
    ;;
    init)
        if [ "$3" ]; then
            init "${@:2}"
        fi
    ;;
    configs)
        init-list
    ;;
    tag)
        if [ "$3" ]; then
            tag "$2" "$3"
        fi
    ;;
    help)
        help
    ;;
    *)
        run "$1"
    ;;
    esac
            
}

main "$@"
