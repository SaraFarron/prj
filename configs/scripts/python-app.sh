#!/bin/bash

source "$PRJ_PATH/const.sh"
source "$CONFIGS/python.sh"

curl-gitignore
init-pipenv
create-main-py
touch const.py
touch utils.py
echo "from const import *" >> main.py
echo "from utils import *" >> main.py
echo "" >> main.py
echo "def main()" >> main.py
echo "    pass" >> main.py
echo "" >> main.py
echo "" >> main.py
echo "if __name__ == \"__main__\"" >> main.py
echo "    main()" >> main.py
echo "" >> main.py
