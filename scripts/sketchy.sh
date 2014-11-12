#!/bin/sh
exec 2>&1
cd /home/app/sketchy
#exec chpst -uapp gunicorn sketchy:app -b 0.0.0.0:8000
exec gunicorn sketchy:app -b 0.0.0.0:8000
