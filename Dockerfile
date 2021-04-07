FROM php:apache-buster

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="e-novinfo VBO365-REST version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="mme"

RUN \
echo "**** install apt Dependency ****" && \
apt update  &&\
apt install curl -y &&\
apt install git -y &&\
apt autoremove -y &&\
echo "**** install composer ****" && \
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" &&\
php -r "if (hash_file('sha384', 'composer-setup.php') === '756890a4488ce9024fc62c56153228907f1545c228516cbf63f885e036d37e9a59d27d63f46af1d4d07ee0f76181c7d3') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" &&\
php composer-setup.php &&\
php -r "unlink('composer-setup.php');" &&\

echo "***** configure apache2 *****" && \
a2enmod rewrite && \
service apache2 stop && \
cd /  && \
mkdir /data && \
mkdir /config && \
rm -rf /var/www/html && \
ln -s /data /var/www/html && \
mv /etc/apache2/* /config && \
rm /etc/apache2 -rf && \
ln -s /config /etc/apache2 && \
service apache2 start && \



#echo 'fastcgi_param  SCRIPT_FILENAME $document_root$fastcgi_script_name;' >> \
#	/etc/nginx/fastcgi_params && \

echo "**** install composer Dependency ****" && \
curl -s https://getcomposer.org/installer | php && /bin/mv -f composer.phar /usr/local/bin/composer &&\
cd /var/www/html &&\
git clone https://github.com/nielsengelen/vbo365-rest.git /var/www/html/  &&\

composer install &&\
chown www-data /data/config.php
# ports and volumes


EXPOSE 80
VOLUME /config
VOLUME /data



