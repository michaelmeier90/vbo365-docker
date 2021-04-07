FROM php:7.4-apache

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/Zurich
# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="e-novinfo VBO365-REST version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="mme"

RUN apt-get update && apt-get install -yq zip unzip zlib1g-dev libzip-dev && rm -rf /var/lib/apt/lists/*
RUN docker-php-ext-install zip
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

ADD . /var/www/html/

WORKDIR /var/www/html

RUN composer install

RUN a2enmod rewrite

RUN \

service apache2 stop && \
cd /  && \
mkdir /data && \
mkdir /config && \
rm -rf /var/www/html && \
ln -s /data /var/www/html && \
mv /etc/apache2/* /config && \
rm /etc/apache2 -rf && \
echo "debug 1" && \
ls -la /etc && \
ln -s /config /etc/apache2 && \
echo "debug 2" && \
ls -la /etc && \
service apache2 start && \



#echo 'fastcgi_param  SCRIPT_FILENAME $document_root$fastcgi_script_name;' >> \
#	/etc/nginx/fastcgi_params && \

echo "**** install composer Dependency ****" && \
curl -s https://getcomposer.org/installer | php && /bin/mv -f composer.phar /usr/local/bin/composer &&\
cd /var/www/html &&\
git clone https://github.com/nielsengelen/vbo365-rest.git /var/www/html/  &&\

composer install
# ports and volumes

EXPOSE 80

VOLUME /data
VOLUME /config



