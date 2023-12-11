#!/bin/bash

function curl-gitignore() {
    gitignore_url=https://raw.githubusercontent.com/github/gitignore/main/Python.gitignore
    curl "$gitignore_url" | sed "s/#Pipfile.lock/Pipfile.lock" >> .gitignore
}

function init-pipenv() {
    pipenv update
}

function create-main-py() {
    touch main.py
}
