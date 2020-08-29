#!/bin/bash

ln -sf /usr/lib/php/${PHP_VERSION}/php.ini-${TEMPLATE_PHP_INI} /etc/php/${PHP_VERSION}/apache2/php.ini

php /usr/local/bin/generate_conf.php > /etc/php/${PHP_VERSION}/mods-available/generated_conf.ini
php /usr/local/bin/setup_extensions.php | sudo bash

echo '[APACHE] Starting...';
exec "docker-php-entrypoint" "$@";
