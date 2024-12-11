# Menggunakan image PHP resmi dengan Apache
FROM php:8.2-apache

# Set working directory di dalam container
WORKDIR /var/www/html

# Install ekstensi PHP yang diperlukan
RUN apt-get update && apt-get install -y \
    libzip-dev zip unzip git curl \
    && docker-php-ext-install pdo pdo_mysql zip \
    && a2enmod rewrite \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Set ServerName untuk mencegah error
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

# Copy composer terlebih dahulu untuk caching
COPY composer.json composer.lock /var/www/html/
RUN composer install --no-dev --optimize-autoloader

# Copy seluruh file project
COPY . /var/www/html

# Set file permission
RUN chown -R www-data:www-data /var/www/html \
    && find /var/www/html -type d -exec chmod 755 {} \; \
    && find /var/www/html -type f -exec chmod 644 {} \;

# Expose port 80 untuk aplikasi web
EXPOSE 80

# Jalankan Apache saat container dimulai
CMD ["apache2-foreground"]