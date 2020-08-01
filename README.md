# PHP 7.4 php-fpm Alpine with configurable UID and GID
Based on the official php:7.4-fpm-alpine from [php](https://hub.docker.com/_/php/) but with configurable UID and GID for www-data. The container itself is still ran as root.

The Dockerfile is heavily inspired by Wodby's Drupal and WordPress Dockerfiles. 

Dockerfile installs shadow for usermod and groupmod command and defaults for UID and GID 1000. Also docker-entrypoint.sh file has been modified to take new values on runtime. Use environment variables `PUID` and `PGID` to override the defaults.

PHP configuration defaults to the provided php.ini-production. Use environment variables `PHP_UPLOAD_MAX_FILESIZE` and `PHP_POST_MAX_SIZE` to override upload_max_filesize and post_max_size.
```bash
docker run -it --rm -e PUID=1001 -e PGID=1234 strathos/php:7.4-fpm-alpine bash
```
There are also Dockerfiles for WordPress and Drupal. Both of them have Git, Vim, Nano and PHP Composer installed, but WordPress one has wp-cli while Drupal has Drush-loader.

Tags:
- strathos/php:7.4-fpm-alpine
- strathos/php:7.4-fpm-alpine-wordpress
- strathos/php:7.4-fpm-alpine-drupal