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
echo "***** configure dlcoker *****" && \
a2enmod rewrite && \
service apache2 restart && \
cd /  && \
rm -rf /var/www/  && \
mkdir /data && \
ln -s /data /var/www/html && \


echo "**** install composer Dependency ****" && \
curl -s https://getcomposer.org/installer | php && /bin/mv -f composer.phar /usr/local/bin/composer &&\
git clone https://github.com/nielsengelen/vbo365-rest.git /var/www/html  &&\
cd /var/www/html &&\
composer install

