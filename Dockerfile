FROM thecodingmachine/php:7.2-v2-apache

ENV PHP_EXTENSIONS="bcmath bz2 calendar exif \
amqp gnupg imap mcrypt memcached \
mongodb sockets yaml \
gd gettext gmp igbinary imagick intl \
pcntl pdo_pgsql pgsql redis \
shmop soap sysvmsg \
apcu mysqli pdo_mysql \
sysvsem sysvshm wddx xsl opcache zip"

ENV ROOT=/var/www/html \
    COMPOSER_ALLOW_SUPERUSER=1

USER root

ONBUILD COPY . /var/www/html/

ONBUILD RUN if [ -f $ROOT/composer.json ]; then \
  composer install \
    --no-dev \
    --no-interaction \
    --prefer-dist \
    --optimize-autoloader \
    --ansi \
    --no-scripts; \
fi
