#!/bin/bash
docker stop scumblr-mysql
docker rm scumblr-mysql

docker stop scumblr
docker rm scumblr

DB_USER=scumblr
DB_PASSWORD=secret
DB_NAME=scumblr

docker run --name scumblr-mysql \
           -e MYSQL_ROOT_PASSWORD=mysecretpassword \
           -e MYSQL_USER=$DB_USER \
           -e MYSQL_PASSWORD=$DB_PASSWORD \
           -e MYSQL_DATABASE=$DB_NAME \
           -v $(pwd)/sample-mysql.cnf:/etc/my.cnf:ro \
           -d mysql:latest

echo "Giving MySQL a chance to start up"
sleep 10

docker run --name scumblr \
           -e SCUMBLR_HOST=localhost \
           -e SCUMBLR_PROTOCOL=http \
           -e GOOGLE_DEVELOPER_KEY=$GOOGLE_DEVELOPER_KEY \
           -e GOOGLE_CX=$GOOGLE_CX \
           -e SCUMBLR_DB_TYPE=mysql \
           -e SCUMBLR_CREATE_DB=true \
           -e SCUMBLR_LOAD_SCHEMA=true \
           -e SCUMBLR_RUN_MIGRATIONS=true \
           -e SCUMBLR_SEED_STATUSES=true \
           -e SCUMBLR_SEED_ADMIN=true \
           -e "SCUMBLR_ADMIN_USER=admin@admin.admin" \
           -e SCUMBLR_ADMIN_PASSWORD=password \
           -e SKETCHY_USE_SSL=false \
           -e SKETCHY_CREATE_DB=true \
           -e DB_USER=$DB_USER \
           -e DB_PASSWORD=$DB_PASSWORD \
           -e DB_NAME=$DB_NAME \
           -e SMTP_ADDRESS=$SMTP_ADDRESS \
           -e SMTP_PORT=$SMTP_PORT \
           -e SMTP_DOMAIN=$SMTP_DOMAIN \
           -e SMTP_USER=$SMTP_USER \
           -e SMTP_PASSWORD=$SMTP_PASSWORD \
           -e SMTP_AUTHENTICATION=$SMTP_AUTHENTICATION \
           -e SMTP_STARTTLS=$SMTP_STARTTLS \
           --link scumblr-mysql:db_1 \
           -p 80:80 -p 443:443 \
           -itd  bprodoehl/scumblr
