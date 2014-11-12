#!/bin/bash

cd /home/app/scumblr
USER=app

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

echo "*** Seeding db"
chpst -u$USER /home/app/.gem/ruby/2.1.0/bin/bundle exec rake db:seed

echo "*** Precompiling assets"
chpst -u$USER /home/app/.gem/ruby/2.1.0/bin/bundle exec rake assets:precompile
