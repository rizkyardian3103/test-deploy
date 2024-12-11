# Gunakan image PHP dengan Apache
FROM php:8.1-apache

# Install ekstensi yang diperlukan, misalnya mysqli untuk MySQL
RUN docker-php-ext-install mysqli pdo pdo_mysql

# Tambahkan ServerName ke konfigurasi Apache
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

# Salin semua file proyek ke /var/www/html
COPY . /var/www/html

# Atur hak akses
RUN chown -R www-data:www-data /var/www/html

# Aktifkan modul Apache rewrite
RUN a2enmod rewrite

# Tentukan port untuk aplikasi
EXPOSE 80