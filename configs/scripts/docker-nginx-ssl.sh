#!/bin/bash

source "$MANAGER_PATH/docker.sh"
source "$MANAGER_PATH/nginx.sh"

if [ -f 'docker-compose.yml' ]; then
  echo 'docker-compose.yml already exists' ; exit "$ERRCODE"
fi

echo "Creating docker files"
create-docker-compose
add-nginx
add-certbot
create-dockerfile

echo "Creating data folder"

mkdir data
mkdir data/nginx
create-ssl-certbot-config

INIT_LETSINCRYPT_URL=https://raw.githubusercontent.com/wmnnd/nginx-certbot/master/init-letsencrypt.sh

url -L "$INIT_LETSINCRYPT_URL" > init-letsencrypt.sh
chmod +x init-letsencrypt.sh

echo 'Done! Do not forget to replace example.org in nginx.conf'
echo 'and example.org and email in init-letsencrypt.sh!'
