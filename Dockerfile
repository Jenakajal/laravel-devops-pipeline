FROM php:8.0-fpm

# Install system dependencies and PHP extensions
RUN apt-get update && apt-get install -y \
    git \
    curl \
    unzip \
    zip \
    libzip-dev \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    && docker-php-ext-install pdo pdo_mysql zip exif pcntl bcmath

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php && \
    mv composer.phar /usr/local/bin/composer

# Set working directory
WORKDIR /var/www

# Copy the entire Laravel project
COPY laravel-app/ /var/www

# Install Laravel dependencies
RUN composer install --no-dev --prefer-dist --no-interaction

# Set permissions
RUN chown -R www-data:www-data /var/www

# Expose port (optional, useful for local testing)
EXPOSE 9000

# Start PHP-FPM
CMD ["php-fpm"]

