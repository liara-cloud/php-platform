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
    COMPOSER_ALLOW_SUPERUSER=1 \
    APACHE_RUN_USER=www-data \
    APACHE_RUN_GROUP=www-data

USER root

ONBUILD COPY . $ROOT

ONBUILD RUN if [ -f $ROOT/composer.json ]; then \
  composer install \
    --no-dev \
    --no-interaction \
    --prefer-dist \
    --optimize-autoloader \
    --ansi \
    --no-scripts; \
fi && chown -R www-data:www-data $ROOT

COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

RUN ln -sf /usr/lib/php/${PHP_VERSION}/php.ini-${TEMPLATE_PHP_INI} /etc/php/${PHP_VERSION}/apache2/php.ini && \ 
  php /usr/local/bin/generate_conf.php > /etc/php/${PHP_VERSION}/mods-available/generated_conf.ini && \
  php /usr/local/bin/setup_extensions.php | sudo bash

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
CMD ["apache2-foreground"]
