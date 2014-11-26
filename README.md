docker-scumblr
=====================

# Scumblr with Docker

This container is derived from https://github.com/ahoernecke/docker_scumblr

This repo contains everything you need to deploy a basic instance of [Scumblr](https://github.com/netflix/scumblr) and [Sketchy](https://github.com/netflix/sketchy). Scumblr is a Netflix open source project that allows performing periodic searches and storing / taking actions on the identified results. Sketchy is a Netflix open source project that performs screen captures of a URL.

**If you just want to quickly test the application, start with the deployment section below.**

## Configuration

This section discusses required/optional configuration that can be done prior to deploying Scumblr. Configuration is broken up into the following sections:

* API Keys (required for most Search providers to work)
* Admin User (Setup admin credentials)
* Database (Use a persistent database instead of the default ephemeral SQLite db)
* SSL

### API Keys

Scumblr requires API keys to function. These can be setup in the config/scumblr/scumblr.rb file. Templates are contained in the file. By default these can be set using environment variables (see Environment Variables below).

### Admin User

The default configuration will create the following admin user:

``admin@admin.admin:password``

These credentials can be set using environment variables (see Environment Variables below).

### Database

The default database will be an onboard SQLite db. This will work for testing but will be lost if the container terminates. To configure a permanent database, setup the database.yml file in config/scumblr/database.yml or use the environment variables (see Environment Variables below). For more information on the database.yml file see http://edgeguides.rubyonrails.org/configuring.html#configuring-a-database.

### SSL

This docker container ships with a self-signed cert to be used for SSL. To use a custom key pair/certificate replace the server.key and server.crt files in config/nginx

### Environment Variables

The following are environment variables available to configure scumblr:
```
SCUMBLR_HOST # Default hostname for scumblr (used for email notifications, etc.) i.e. "scumblr.com"
SCUMBLR_PROTOCOL # Default protocol i.e. "https"

SCUMBLR_DB_TYPE # database type i.e. "mysql"
SCUMBLR_CREATE_DB # Run rake db:create if true. For initial DB setup.
SCUMBLR_LOAD_SCHEMA # Run rake db:schema:load. For initial DB setup. Will reset DB to default!
SCUMBLR_RUN_MIGRATIONS # Run rake db:migrate if true. Will update database with migrations if included.
SCUMBLR_SEED_STATUSES # Create a default set of statuses if set to "true"
SCUMBLR_SEED_ADMIN # Create an admin user (admin@admin.admin/password) if no users exist and SEED_ADMIN set to "true"

SCUMBLR_ADMIN_USER # User (defaults to admin@admin.admin)
SCUMBLR_ADMIN_PASSWORD # Password (defaults to password)

SKETCHY_PORT_443_TCP_ADDR
SKETCHY_PORT_443_TCP_PORT
SKETCHY_USE_SSL
SKETCHY_VERIFY_SSL
SKETCHY_ACCESS_TOKEN
SKETCHY_TAG_STATUS_CODE

RAILS_ENV # Select a rails environment (development, staging, production)

EBAY_ACCESS_KEY

FACEBOOK_APP_ID
FACEBOOK_APP_SECRET

GOOGLE_DEVELOPER_KEY
GOOGLE_CX
GOOGLE_APPLICATION_NAME
GOOGLE_APPLICATION_VERSION

YOUTUBE_DEVELOPER_KEY
YOUTUBE_APPLICATION_NAME
YOUTUBE_APPLICATION_VERSION

TWITTER_CONSUMER_KEY
TWITTER_CONSUMER_SECRET
TWITTER_ACCESS_TOKEN
TWITTER_ACCESS_TOKEN_SECRET

```

## Deployment

This section includes instructions on creating and deploying a container running Scumblr and Sketchy.

* Pull this repo from Github:

``git clone https://github.com/bprodoehl/docker-scumblr``
``cd docker-scumblr``

* Build the docker image

``docker build -t scumblr . ``

* Run the container either:

``docker run -p 80:80 -p 443:443 scumblr``

* Visit your server's domain name or ip in a browser

* Login with the credentials you specified (or the default if not changed: admin@admin.admin/password)

### Advanced Deployment

A more advanced deployment scenario is provided in the launch-scumblr.sh script.  This will create a MySQL database container using the official MySQL repository in the Docker Hub, and will configure that database for UTF8 character set, which is critical if you will have any international search results.  It will then spin up the scumblr container, linked to that database.
