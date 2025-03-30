FROM php:8.2-apache

# Install required packages and extensions
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    vim

# Create wp-cli cache directory and set proper permissions
RUN mkdir -p /var/www/.wp-cli/cache/ && \
    chown -R www-data:www-data /var/www/.wp-cli

# Enable mod_rewrite for Apache
RUN a2enmod rewrite

# Restart Apache
RUN service apache2 restart

# Install additional PHP extensions
RUN docker-php-ext-install mysqli pdo pdo_mysql

# Install Composer
RUN apt-get update && apt-get install -y unzip curl git \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install WP-CLI
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

# Change UID and GID
RUN usermod -u 1000 www-data
RUN groupmod -g 1000 www-data

# Set file permissions
RUN chown -R www-data:www-data /var/www/