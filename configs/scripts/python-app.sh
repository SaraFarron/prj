#!/bin/bash

source "$PRJ_PATH/const.sh"
source "$CONFIGS/python.sh"
PYTHON_CONFIGS="$CONFIGS/python"

curl-gitignore
init-pipenv
create-main-py
touch const.py
touch utils.py
cat "$PYTHON_CONFIGS/main.py" >> main.py
