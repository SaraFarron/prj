#!/bin/bash

function curl-gitignore {
    gitignore_url=https://raw.githubusercontent.com/github/gitignore/main/Python.gitignore
    curl "$gitignore_url" >> .gitignore
    sed -i "s/#Pipfile.lock/Pipfile.lock/g" .gitignore
}

function init-pipenv {
    pipenv update
}

function create-main-py {
    touch main.py
}

function copy-fastapi-template {
    cp "$PRJ_PATH/configs/python/fastapi.py" "main.py"
    mkdir -p "app"
    cp -r "$PRJ_PATH/configs/python/fastapi-app/" "app/"
    
}
