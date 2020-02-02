# PHP 7.2 php-fpm alpine with configurable UID and GID
Otherwise the same as [php:7.2-fpm-alpine](https://github.com/docker-library/php/blob/bac7b0ca07ab28de2a3b3e8d9a052084ca98937d/7.2/alpine3.11/fpm/Dockerfile) from [official php](https://hub.docker.com/_/php) but with configurable UID and GID for www-data. The container itself is still ran as root.

Dockerfile installs shadow for usermod and groupmod command and defaults for UID and GID 1000. Also docker-php-entrypoint file has been modified to take new values on runtime. Use environment variables `PUID` and `PGID` to override the defaults.

```bash
docker run -it --rm -e PUID=1001 -e PGID=1234 strathos/php:7.2-fpm-uid sh
```