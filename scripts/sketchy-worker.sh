#!/bin/sh
exec 2>&1
cd /home/app/sketchy
#exec chpst -uapp celery worker -A sketchy.celery
export C_FORCE_ROOT=true
exec celery worker -A sketchy.celery
