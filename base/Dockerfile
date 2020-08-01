# from https://www.drupal.org/docs/8/system-requirements/drupal-8-php-requirements
FROM php:7.4-fpm-alpine

RUN set -eux; \
	\
  apk add --update --no-cache \
    bash \
    c-client=2007f-r11 \
    fcgi \
    findutils \
    freetype \
    ghostscript \
    gmp \
    icu-libs \
    imagemagick\
    jpegoptim \
    less \
    libbz2 \
    libevent \
    libjpeg-turbo \
    libjpeg-turbo-utils \
    libldap \
    libltdl \
    libmemcached-libs \
    libmcrypt \
    libpng \
    librdkafka \
    libuuid \
    libwebp \
    libxml2 \
    libxslt \
    libzip \
    patch \
    pngquant \
    postgresql-client \
    rabbitmq-c \
    rsync \
    shadow \
    su-exec \
    sudo \
    tidyhtml-libs \
    yaml \
  ; \
	apk add --no-cache --virtual .build-deps \
    autoconf \
    cmake \
    build-base \
    bzip2-dev \
    freetype-dev \
    gmp-dev \
    icu-dev \
    imagemagick-dev \
    imap-dev \
    jpeg-dev \
    krb5-dev \
    libevent-dev \
    libgcrypt-dev \
    libjpeg-turbo-dev \
    libmemcached-dev \
    libmcrypt-dev \
    libpng-dev \
    librdkafka-dev \
    libtool \
    libwebp-dev \
    libxslt-dev \
    libzip-dev \
    openldap-dev \
    openssl-dev \
    pcre-dev \
    postgresql-dev \
    rabbitmq-c-dev \
    tidyhtml-dev \
    yaml-dev \
	; \
	\
	docker-php-ext-configure gd \
    --with-webp \
    --with-freetype \
    --with-jpeg \
	; \
	\
	docker-php-ext-install -j "$(nproc)" \
    bcmath \
    bz2 \
    calendar \
    exif \
    gd \
    gmp \
    intl \
    ldap \
    mysqli \
    opcache \
    pcntl \
    pdo_mysql \
    pdo_pgsql \
    pgsql \
    soap \
    sockets \
    tidy \
    xmlrpc \
    xsl \
    zip \
	; \
	\
  pecl install \
    amqp-1.10.2 \
    apcu-5.1.18 \
    ast-1.0.5 \
    ds-1.2.9 \
    event-2.5.6 \
    grpc-1.23.1 \
    igbinary-3.0.1 \
    imagick-3.4.4 \
    mcrypt-1.0.3 \
    memcached-3.1.5 \
    oauth-2.0.4 \
    pcov \
    rdkafka-4.0.3 \
    redis-4.3.0 \
    uploadprogress \
    uuid-1.0.4 \
    yaml-2.1.0 \
  ; \
  docker-php-ext-enable \
    amqp \
    apcu \
    ast \
    ds \
    event \
    igbinary \
    imagick \
    grpc \
    mcrypt \
    memcached \
    oauth \
    pcov \
    redis \
    rdkafka \
    uploadprogress \
    uuid \
    yaml \
  ; \
  mv /usr/local/etc/php/conf.d/docker-php-ext-event.ini /usr/local/etc/php/conf.d/z-docker-php-ext-event.ini; \
	runDeps="$( \
		scanelf --needed --nobanner --format '%n#p' --recursive /usr/local \
			| tr ',' '\n' \
			| sort -u \
			| awk 'system("[ -e /usr/local/lib/" $1 " ]") == 0 { next } { print "so:" $1 }' \
	)"; \
	apk add --virtual .drupal-phpexts-rundeps $runDeps; \
  pecl clear-cache; \
	apk del .build-deps

RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"

RUN { \
		echo 'opcache.memory_consumption=128'; \
		echo 'opcache.interned_strings_buffer=8'; \
		echo 'opcache.max_accelerated_files=4000'; \
		echo 'opcache.revalidate_freq=60'; \
		echo 'opcache.fast_shutdown=1'; \
	} > /usr/local/etc/php/conf.d/opcache-recommended.ini

RUN { \
		echo 'error_reporting = E_ERROR | E_WARNING | E_PARSE | E_CORE_ERROR | E_CORE_WARNING | E_COMPILE_ERROR | E_COMPILE_WARNING | E_RECOVERABLE_ERROR'; \
		echo 'display_errors = Off'; \
		echo 'display_startup_errors = Off'; \
		echo 'log_errors = On'; \
		echo 'error_log = /dev/stderr'; \
		echo 'log_errors_max_len = 1024'; \
		echo 'ignore_repeated_errors = On'; \
		echo 'ignore_repeated_source = Off'; \
		echo 'html_errors = Off'; \
	} > /usr/local/etc/php/conf.d/error-logging.ini

# set default UID and GID for www-data to 1000
# override these with PUID and PGID environment variables
RUN usermod -u 1000 www-data \
  && groupmod -g 1000 www-data \
  && chown www-data:www-data /home/www-data \
  && chown -R www-data:www-data /var/www

WORKDIR /var/www/html
COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["php-fpm", "--nodaemonize"]

# vim:set ft=dockerfile: