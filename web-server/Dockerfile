FROM php:8.2-apache

RUN docker-php-ext-install mysqli pdo pdo_mysql zip

RUN pecl install xdebug \
    docker-php-ext-enable xdebug

RUN a2enmod ssl rewrite

RUN /etc/init.d/apache2 restart

EXPOSE 80