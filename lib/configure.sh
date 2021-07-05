#/bin/bash

if [ "$__PHP_MIRROR" = "true" ]; then
  echo '> Using mirror: ' $__PHP_MIRRORURL
  composer config repo.packagist false
  composer config repo.liara composer $__PHP_MIRRORURL
fi

composer update --lock --no-dev --no-interaction --prefer-dist --optimize-autoloader --ansi --no-scripts