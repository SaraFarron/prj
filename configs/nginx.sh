#!/bin/bash

NGINX_CONFIGS="$MANAGER_PATH/nginx"

function create-ssl-certbot-config() {
    cat "$NGINX_CONFIGS/ssl-certbot.conf" >> data/nginx/nginx.conf
}
