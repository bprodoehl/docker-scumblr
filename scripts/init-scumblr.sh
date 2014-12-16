#!/bin/bash

cd /home/app/scumblr
USER=app

# Support a git checkout in a volume, by making sure that these Docker-specific
# config files are where they should be.
if [ ! -f /home/app/scumblr/config/initializers ]; then
  cp /home/app/scumblr-config/scumblr.rb /home/app/scumblr/config/initializers/
fi

if [ ! -f /home/app/scumblr/config/database.yml ]; then
  cp /home/app/scumblr-config/database.yml /home/app/scumblr/config/
fi

if [ ! -f /home/app/scumblr/db/seeds.rb ]; then
  cp /home/app/scumblr-config/seeds.rb /home/app/scumblr/db/
fi

if [ "$SCUMBLR_DB_TYPE" == "mysql" ]; then
  DBYML=/home/app/scumblr/config/database.yml
  # MySQL database host
  if [ ! -z $DB_1_PORT_3306_TCP_ADDR ]; then
      DB_HOST=$DB_1_PORT_3306_TCP_ADDR
  fi

  if [ ! -z $DB_1_PORT_3306_TCP_PORT ]; then
      DB_PORT=$DB_1_PORT_3306_TCP_PORT
  fi

  if [ ! -z $DB_PORT ]; then
      DB_PORT=3306
  fi

  echo "Initializing for MySQL database type"
  echo "development:" > $DBYML
  echo "  adapter: mysql2" >> $DBYML
  echo "  encoding: utf8" >> $DBYML
  echo "  database: ${DB_NAME}" >> $DBYML
  echo "  username: ${DB_USER}" >> $DBYML
  echo "  password: ${DB_PASSWORD}" >> $DBYML
  echo "  host: ${DB_HOST}" >> $DBYML
  echo "  port: ${DB_PORT}" >> $DBYML
  echo "" >> $DBYML
  echo "production:" >> $DBYML
  echo "  adapter: mysql2" >> $DBYML
  echo "  encoding: utf8" >> $DBYML
  echo "  database: ${DB_NAME}" >> $DBYML
  echo "  username: ${DB_USER}" >> $DBYML
  echo "  password: ${DB_PASSWORD}" >> $DBYML
  echo "  host: ${DB_HOST}" >> $DBYML
  echo "  port: ${DB_PORT}" >> $DBYML
else
  echo "Initializing for SQLite database type"
fi

if [ "$SCUMBLR_CREATE_DB" == "true" ]; then
  echo "*** Creating db"
  chpst -u$USER /home/app/.gem/ruby/2.1.0/bin/bundle exec rake db:create
fi

if [ "$SCUMBLR_LOAD_SCHEMA" == "true" ]; then
  echo "*** Loading schema"
  chpst -u$USER /home/app/.gem/ruby/2.1.0/bin/bundle exec rake db:schema:load
fi

if [ "$SCUMBLR_RUN_MIGRATIONS" == "true" ]; then
  echo "*** Migrating db"
  chpst -u$USER /home/app/.gem/ruby/2.1.0/bin/bundle exec rake db:migrate
fi

if [ "$SCUMBLR_SEED_DB" == "true" ]; then
  echo "*** Seeding db"
  chpst -u$USER /home/app/.gem/ruby/2.1.0/bin/bundle exec rake db:seed
fi

echo "*** Precompiling assets"
chpst -u$USER /home/app/.gem/ruby/2.1.0/bin/bundle exec rake assets:precompile
