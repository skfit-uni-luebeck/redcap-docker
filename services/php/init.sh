#!/bin/sh
set -e

if [[ ! -f /var/www/html/database.template ]]; then
  mv /var/www/html/database.php /var/www/html/database.template
fi

cp /var/www/html/database.template /var/www/html/database.php

sed -i 's/\$hostname   = \x27\x27/\$hostname = '\'"$DATABASE_HOST\'"'/' /var/www/html/database.php
sed -i 's/\$username   = \x27\x27/\$username = '\'"$DATABASE_USER\'"'/' /var/www/html/database.php
sed -i 's/\$password   = \x27\x27/\$password = '\'"$DATABASE_PASSWORD\'"'/' /var/www/html/database.php
sed -i 's/\$db     	= \x27\x27/\$db = '\'"$DATABASE_DATABASE\'"'/' /var/www/html/database.php
sed -i 's/\$salt = \x27\x27/\$salt = '\'"$DATABASE_SALT\'"'/' /var/www/html/database.php

# first arg is `-f` or `--some-option`
if [ "${1#-}" != "$1" ]; then
	set -- php-fpm "$@"
fi

exec "$@"
