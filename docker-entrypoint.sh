#!/bin/bash

echo '[APACHE] Starting...';
exec "docker-php-entrypoint" "$@";
