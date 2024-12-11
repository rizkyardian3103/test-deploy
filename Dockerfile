# Menggunakan image PHP resmi dengan Apache
FROM php:8.2-apache

# Set working directory di dalam container
WORKDIR /var/www/html

# Install ekstensi PHP yang diperlukan (tambahkan sesuai kebutuhan project Anda)
RUN apt-get update && apt-get install -y \
    libzip-dev zip unzip git curl \
    && docker-php-ext-install pdo pdo_mysql zip \
    && a2enmod rewrite \
    && apt-get clean

# Salin file composer ke container (jika menggunakan Composer)
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Salin semua file project ke dalam container
COPY . /var/www/html

# Set permission agar file memiliki hak akses yang sesuai
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html

# Jalankan perintah Composer jika file composer.json ada
RUN if [ -f "composer.json" ]; then composer install --no-dev --optimize-autoloader; fi

# Expose port 80 untuk aplikasi web
EXPOSE 80

# Jalankan Apache saat container dimulai
CMD ["apache2-foreground"]