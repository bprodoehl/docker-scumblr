docker-scumblr
=====================

# Scumblr with Docker

This container is derived from https://github.com/ahoernecke/docker_scumblr

This repo contains everything you need to deploy a basic instance of [Scumblr](https://github.com/netflix/Scumblr) and [Sketchy](https://github.com/netflix/Sketchy). Scumblr is a Netflix open source project that allows performing periodic searches and storing / taking actions on the identified results. Sketchy is a Netflix open source project that performs screen captures of a URL.

**If you just want to quickly test the application, start with the deployment section below.**

## Configuration

This section discusses required/optional configuration that can be done prior to deploying Scumblr. Configuration is broken up into the following sections:

* API Keys (required for most Search providers to work)
* Admin User (Setup admin credentials)
* Database (Use a persistent database instead of the default ephemeral SQLite db)
* SSL

### API Keys

Scumblr requires API keys to function. Information on obtaining these keys can be found in the wiki, here: https://github.com/Netflix/Scumblr/wiki/Configuration

Once obtained, these should be setup using environment variables (see Environment Variables below).

### Admin User

The default configuration will create the following admin user:

``admin@admin.admin:password``

These credentials can be set using the ```SCUMBLR_ADMIN_USER``` and ```SCUMBLR_ADMIN_PASSWORD``` environment variables (see Environment Variables below).

### Database

The default database will be an onboard SQLite db. This will work for testing but will be lost if the container terminates. To configure a permanent database use the environment variables (see Environment Variables below).

### SSL

This docker container ships with a self-signed cert to be used for SSL. To use a custom key pair/certificate replace the server.key and server.crt files in config/nginx

### Environment Variables

The following are environment variables available to configure scumblr:

  * ```SCUMBLR_HOST``` is the default hostname for scumblr (used for email notifications, etc.) i.e. "scumblr.com"
  * ```SCUMBLR_PROTOCOL``` is the default protocol, i.e. "https"

  * ```SCUMBLR_DB_TYPE``` is the database type, i.e. "mysql"
  * ```SCUMBLR_CREATE_DB``` runs rake db:create if true. For initial DB setup.
  * ```SCUMBLR_LOAD_SCHEMA``` runs rake db:schema:load. For initial DB setup. Will reset DB to default!
  * ```SCUMBLR_RUN_MIGRATIONS``` runs rake db:migrate if true. Will update database with migrations if included.
  * ```SCUMBLR_SEED_STATUSES``` creates a default set of statuses if set to "true"
  * ```SCUMBLR_SEED_ADMIN``` creates an admin user (admin@admin.admin/password) if no users exist and SEED_ADMIN set to "true"

  * ```SCUMBLR_ADMIN_USER``` sets the initial super user (defaults to admin@admin.admin)
  * ```SCUMBLR_ADMIN_PASSWORD``` sets the initial super user's password (defaults to password)

  * ```RAILS_ENV``` selects a rails environment (development, staging, production)

  * ```EBAY_ACCESS_KEY``` is the Ebay key, with [information on how to obtain that here](https://github.com/Netflix/Scumblr/wiki/eBay-Search-Provider-Configuration)

  * ```FACEBOOK_APP_ID``` and ```FACEBOOK_APP_SECRET``` are the Facebook API keys. Information on how to get those is [coming soon](https://github.com/Netflix/Scumblr/wiki/Configuration).

  * ```GOOGLE_DEVELOPER_KEY```,  ```GOOGLE_CX```, ```GOOGLE_APPLICATION_NAME``` and ```GOOGLE_APPLICATION_VERSION``` are the Google developer keys, with [information on how to obtain those here](https://github.com/Netflix/Scumblr/wiki/Google-Search-Provider-Configuration)

  * ```YOUTUBE_DEVELOPER_KEY```, ```YOUTUBE_APPLICATION_NAME``` and ```YOUTUBE_APPLICATION_VERSION``` are the Youtube developer keys. Information on how to get those is [coming soon](https://github.com/Netflix/Scumblr/wiki/Configuration).

  * ```TWITTER_CONSUMER_KEY```, ```TWITTER_CONSUMER_SECRET```, ```TWITTER_ACCESS_TOKEN``` and ```TWITTER_ACCESS_TOKEN_SECRET``` are the Twitter developer keys, with [information on how to obtain that here](https://github.com/Netflix/Scumblr/wiki/Twitter-Search-Provider-Configuration)

## Deployment

This section includes instructions on creating and deploying a container running Scumblr and Sketchy.

* Pull this repo from Github:

``git clone https://github.com/bprodoehl/docker-scumblr``
``cd docker-scumblr``

* Build the docker image

``docker build -t scumblr . ``

* Run the container either:

``docker run -p 80:80 -p 443:443 scumblr``

* Visit your server's domain name or IP in a browser

* Login with the credentials you specified (or the default if not changed: admin@admin.admin/password)

### Advanced Deployment

A more advanced deployment scenario is provided in the launch-scumblr.sh script.  This will create a MySQL database container using the official MySQL repository in the Docker Hub, and will configure that database for UTF8 character set, which is critical if you will have any international search results.  It will then spin up the scumblr container, linked to that database.
