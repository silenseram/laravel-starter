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

COPY --from=composer/composer:latest-bin /composer /usr/bin/composer

# fpm config
COPY ./deploy/php/php-fpm.conf /usr/local/etc/php-fpm.d/php-fpm.conf

# opcache config
COPY ./deploy/php/opcache.ini /usr/local/etc/php/conf.d/opcache.ini

# supervisor config
COPY ./deploy/supervisor/laravel-queue.conf /etc/supervisor/conf.d/laravel-queue.conf

RUN useradd -m -u 1000 dev

RUN chown -R dev:dev /app