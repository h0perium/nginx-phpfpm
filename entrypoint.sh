#!/bin/bash

# Start PHP-FPM
php-fpm -D

# Start NGINX
nginx -g "daemon off;"

