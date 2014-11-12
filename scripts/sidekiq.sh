#!/bin/sh
exec 2>&1
cd /home/app/scumblr
exec chpst -uapp /home/app/.gem/ruby/2.1.0/bin/bundle exec sidekiq
