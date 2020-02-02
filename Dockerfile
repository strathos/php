FROM php:7.2-fpm-alpine

RUN apk add --no-cache shadow \
  && usermod -u 1000 www-data \
  && groupmod -g 1000 www-data \
  && chown www-data:www-data /home/www-data \
  && chown -R www-data:www-data /var/www

ADD docker-php-entrypoint /usr/local/bin/
