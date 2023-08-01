#!/bin/bash

curl https://raw.githubusercontent.com/github/gitignore/main/Python.gitignore >> .gitignore
pipenv update
touch main.py
