FROM php:8.2-apache

RUN apt-get update \
    && apt-get install -y git curl wget libpng-dev libonig-dev libxml2-dev libzip-dev zip unzip

RUN docker-php-ext-install pdo pdo_mysql mysqli exif gd zip

RUN wget -O- https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN docker-php-ext-install mysqli pdo pdo_mysql zip \
    && pecl install xdebug \
    && docker-php-ext-enable xdebug

RUN a2enmod ssl rewrite && /etc/init.d/apache2 restart

RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash \
    && . "$HOME/.bashrc" \
    && nvm install v14.17.1 \
    && nvm install v16.4.0 \
    && nvm install v20.17.0 \
    && nvm alias default v20.17.0

EXPOSE 80 443