#!/bin/bash

source "$PRJ_PATH/const.sh"
source "$CONFIGS/docker.sh"
source "$CONFIGS/nginx.sh"

if [ -f 'docker-compose.yml' ]; then
  echo 'docker-compose.yml already exists' ; exit 1
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

curl -L "$INIT_LETSINCRYPT_URL" > init-letsencrypt.sh
chmod +x init-letsencrypt.sh

echo 'Done! Do not forget to replace example.org in nginx.conf'
echo 'and example.org and email in init-letsencrypt.sh!'
