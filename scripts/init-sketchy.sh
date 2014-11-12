#!/bin/bash

cd /home/app/sketchy

if [ "$SKETCHY_CREATE_DB" == "true" ]; then
  echo "*** Creating sketchy db"
  python manage.py create_db
fi
