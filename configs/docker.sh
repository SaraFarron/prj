#!/bin/bash

source "$PRJ_PATH/const.sh"
DOCKER_CONFIGS="$CONFIGS/docker"
COMPOSE_FILE="docker-compose.yml"

function create-docker-compose {
    touch "$COMPOSE_FILE"
    cat "$DOCKER_CONFIGS/header.yml" >> "$COMPOSE_FILE"
}

function create-dockerfile {
    touch Dockerfile
}

function add-nginx {
    cat "$DOCKER_CONFIGS/nginx.yml" >> "$COMPOSE_FILE"
}

function add-certbot {
    cat "$DOCKER_CONFIGS/certbot.yml" >> "$COMPOSE_FILE"
}