# Stage 1: Build Laravel dependencies
FROM composer:2.6 AS vendor

WORKDIR /app

COPY laravel-app/composer.json laravel-app/composer.lock ./
RUN composer install --no-dev --prefer-dist --no-interaction

# Stage 2: Laravel App with PHP
FROM php:8.2-fpm

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git curl zip unzip libzip-dev libpng-dev libonig-dev libxml2-dev \
    && docker-php-ext-install pdo pdo_mysql zip exif pcntl bcmath

WORKDIR /var/www

# Copy Laravel source
COPY laravel-app/ ./

# Copy vendor files
COPY --from=vendor /app/vendor ./vendor

# Set permissions
RUN chown -R www-data:www-data /var/www \
    && chmod -R 775 /var/www/storage /var/www/bootstrap/cache

EXPOSE 9000
CMD ["php-fpm"]

