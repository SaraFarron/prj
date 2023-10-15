#!/bin/bash

if [ -f 'docker-compose.yml' ]; then
  echo 'docker-compose.yml already exists' ; exit "$ERRCODE"
fi

cat >> 'docker-compose.yml' <<- 'EOM'
version: '3'

services:
  nginx:
    image: nginx:1.15-alpine
    restart: unless-stopped
    volumes:
      - ./data/nginx:/etc/nginx/conf.d
      - ./data/certbot/conf:/etc/letsencrypt
      - ./data/certbot/www:/var/www/certbot
    ports:
      - "80:80"
      - "443:443"
    command: "/bin/sh -c 'while :; do sleep 6h & wait $${!}; nginx -s reload; done & nginx -g \"daemon off;\"'"
  certbot:
    image: certbot/certbot
    restart: unless-stopped
    volumes:
      - ./data/certbot/conf:/etc/letsencrypt
      - ./data/certbot/www:/var/www/certbot
    entrypoint: "/bin/sh -c 'trap exit TERM; while :; do certbot renew; sleep 12h & wait $${!}; done;'"
EOM

mkdir data
mkdir data/nginx

cat >> 'data/nginx/nginx.conf' <<- 'EOM'
upstream website {
    server web:8000;
}

server {
    listen 80;
    server_name example.org;
    server_tokens off;

    location /.well-known/acme-challenge/ {
        root /var/www/certbot;
    }

    location / {
        return 301 https://$host$request_uri;
    }
}

server {
    listen 443 ssl;
    server_name example.org;
    server_tokens off;

    ssl_certificate /etc/letsencrypt/live/example.org/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/example.org/privkey.pem;
    include /etc/letsencrypt/options-ssl-nginx.conf;
    ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem;

    location / {
        proxy_pass  http://website;
        proxy_set_header    Host                $http_host;
        proxy_set_header    X-Real-IP           $remote_addr;
        proxy_set_header    X-Forwarded-For     $proxy_add_x_forwarded_for;
    }
}
EOM

wget http://94.103.83.67/init-letsencrypt.sh
chmod +x init-letsencrypt.sh

echo 'Do not forget to replace example.org in nginx.conf'
echo 'and example.org and email in init-letsencrypt.sh!'
