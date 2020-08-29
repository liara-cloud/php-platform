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

RUN php /usr/local/bin/generate_conf.php | tee /usr/local/etc/php/conf.d/generated_conf.ini > /dev/null

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
CMD ["apache2-foreground"]
