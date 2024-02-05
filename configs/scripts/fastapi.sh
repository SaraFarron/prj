#!/bin/bash

source "$PRJ_PATH/const.sh"
source "$CONFIGS/python.sh"

curl-gitignore
init-pipenv
pipenv install fastapi uvicorn sqlalchemy
copy-fastapi-template

