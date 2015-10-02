FROM php:apache

MAINTAINER Charlie Murray <charliemurray37@gmail.com>

RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng12-dev \
        sendmail \
    && docker-php-ext-install iconv mcrypt mysql mysqli \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install gd

RUN echo "sendmail_path = /usr/sbin/sendmail -i -t" /usr/local/etc/php/conf.d/sendmail.ini
