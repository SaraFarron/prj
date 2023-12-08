#!/bin/bash

source "$PRJ_PATH/const.sh"
NGINX_CONFIGS="$CONFIGS/nginx"

function create-ssl-certbot-config() {
    cat "$NGINX_CONFIGS/ssl-certbot.conf" >> data/nginx/nginx.conf
}
