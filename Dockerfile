# Stage 1: Base PHP image
FROM php:8.0-fpm as base

# Install dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    zip \
    unzip \
    libzip-dev \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    && docker-php-ext-install pdo pdo_mysql zip exif pcntl bcmath

# Set working directory
WORKDIR /var/www

# Copy Laravel app's composer.json and composer.lock files to Docker container
COPY laravel-app/composer.json laravel-app/composer.lock ./

# Install Composer dependencies (this should work if the artisan file is present)
RUN composer install --no-dev --prefer-dist --no-interaction

# Stage 2: Copy the entire Laravel app
COPY laravel-app /var/www

# Set file permissions for Laravel app
RUN chown -R www-data:www-data /var/www

# Expose port 80
EXPOSE 80

# Start the PHP-FPM server
CMD ["php-fpm"]

