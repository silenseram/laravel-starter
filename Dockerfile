FROM php:8.1-fpm

WORKDIR /app
VOLUME ["/app", "/etc/supervisor/conf.d/laravel-queue.conf:delegated", "/usr/local/etc/php-fpm.d/php-fpm.conf:delegated"]

COPY ./ /app

RUN apt-get update && apt-get install -y \
    supervisor \
    git \
    wget \
    ntp \
    lvm2 \
    libmcrypt-dev \
    libxml2-dev \
    libgmp-dev \
    libzip-dev \
    libpng-dev \
    gnupg \
    iputils-ping \
    cron

RUN docker-php-ext-install soap zip gmp gd pdo_mysql opcache
RUN docker-php-ext-enable soap gmp zip gd

RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN composer --version

# fpm config
COPY ./deploy/php/php-fpm.conf /usr/local/etc/php-fpm.d/php-fpm.conf

# opcache config
COPY ./deploy/php/opcache.ini /usr/local/etc/php/conf.d/opcache.ini

# supervisor config
COPY ./deploy/supervisor/laravel-queue.conf /etc/supervisor/conf.d/laravel-queue.conf
