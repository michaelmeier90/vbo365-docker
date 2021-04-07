FROM php:7.4-apache

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/Zurich
# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="e-novinfo VBO365-REST version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="mme"


RUN apt-get update && apt-get install -yq zip unzip zlib1g-dev libzip-dev git iputils-ping nano && rm -rf /var/lib/apt/lists/*
RUN docker-php-ext-install zip
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN \
service apache2 stop && \
cd /  && \
mkdir /data && \
mkdir /config && \
rm -rf /var/www/html && \
ln -s /data /var/www/html && \
mv /etc/apache2/* /config && \
rm /etc/apache2 -rf && \
ln -s /config /etc/apache2 && \
service apache2 start
WORKDIR /var/www/html
RUN \
cd /var/www/html && \
git clone https://github.com/VeeamHub/vbo365-rest-self-service.git /var/www/html/  

RUN composer install
RUN chown www-data /var/www/html/config.php

RUN a2enmod rewrite

EXPOSE 80

VOLUME /data
VOLUME /config
