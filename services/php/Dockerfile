FROM docker.io/php:8.5-fpm-alpine

# https://github.com/Imagick/imagick/issues/643
RUN apk add --no-cache --virtual .build-deps \
    g++ make autoconf
RUN apk add --no-cache libzip-dev zlib-dev libpng-dev imagemagick imagemagick-pdf imagemagick-dev msmtp

RUN pecl install imagick && docker-php-ext-enable imagick
RUN docker-php-ext-install mysqli gd zip
RUN apk del --purge .build-deps
RUN docker-php-ext-enable mysqli gd zip
COPY ./redcap.ini /usr/local/etc/php/conf.d/redcap.ini

# Setup crontab for cron container
RUN echo '* * * * * /usr/local/bin/php /var/www/html/cron.php > /dev/null' > /etc/crontabs/root

# First run init script for db init
COPY ./init.sh /init.sh
ENTRYPOINT ["/init.sh"]
CMD ["php-fpm"]
