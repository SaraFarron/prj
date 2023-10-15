#!/bin/bash

curl https://raw.githubusercontent.com/github/gitignore/main/Python.gitignore >> .gitignore
pipenv update
touch main.py
touch utils.py
touch const.py
