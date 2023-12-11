#!/bin/bash

source "$PRJ_PATH/const.sh"
source "$CONFIGS/git.sh"

if [ -d ".git" ]; then
    echo "directory \".git\" exists" ; exit 1
fi

init-repo
create-readme
