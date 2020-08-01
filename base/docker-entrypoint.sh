#!/usr/bin/env bash
set -e

if [ -n "${PUID-}" ]; then
  usermod -u "${PUID}" "${PHP_FPM_USER:=www-data}"
  chown "${PHP_FPM_USER}":"${PHP_FPM_GROUP:=www-data}" /home/"${PHP_FPM_USER}"
  chown -R "${PHP_FPM_USER}":"${PHP_FPM_GROUP}" /var/www
fi

if [ -n "${PGID-}" ]; then
  groupmod -g "${PGID}" "${PHP_FPM_USER:=www-data}"
  chown -R "${PHP_FPM_USER}":"${PHP_FPM_GROUP:=www-data}" /home/"${PHP_FPM_USER}"
  chown -R "${PHP_FPM_USER}":"${PHP_FPM_GROUP}" /var/www
fi

if [ -n "${PHP_UPLOAD_MAX_FILESIZE-}" ]; then
  sed -i "s/upload_max_filesize = 2M/upload_max_filesize = ${PHP_UPLOAD_MAX_FILESIZE}/" "${PHP_INI_DIR}"/php.ini
fi

if [ -n "${PHP_POST_MAX_SIZE-}" ]; then
  sed -i "s/post_max_size = 8M/post_max_size = ${PHP_POST_MAX_SIZE}/" "${PHP_INI_DIR}"/php.ini
fi

exec /usr/local/bin/docker-php-entrypoint "${@}"
