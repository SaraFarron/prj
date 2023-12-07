#!/bin/bash

function create-docker-compose() {
    touch docker-compose.yml
    cat "$MANAGER_PATH/docker/header.yml" >> docker-compose.yml
}

function create-dockerfile() {
    touch Dockerfile
}
