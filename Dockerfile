FROM php:5.6-apache

MAINTAINER Charlie Murray <charlie@bmore.co.uk>

ENV APACHE_LOG_DIR=/var/log/

RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng12-dev \
        libicu-dev \
        libxslt-dev \
        ssl-cert \
	&& make-ssl-cert generate-default-snakeoil \
    && docker-php-ext-install mbstring iconv mcrypt intl xsl mysql mysqli pdo pdo_mysql \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install gd

RUN a2enmod rewrite \
	&& a2enmod ssl \
	&& a2ensite default-ssl

EXPOSE 443