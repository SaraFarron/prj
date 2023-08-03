#!/bin/bash

LIST=$(prj list)
complete -W "$LIST" prj run
