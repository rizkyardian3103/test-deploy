# Menggunakan image resmi PHP dengan Apache
FROM php:8.2-apache

# Set servername melalui environment variable
ARG SERVER_NAME=localhost

# Install ekstensi PHP jika diperlukan (misalnya mysqli, pdo_mysql)
RUN docker-php-ext-install mysqli pdo pdo_mysql

# Aktifkan module Apache rewrite (opsional jika dibutuhkan)
RUN a2enmod rewrite

# Konfigurasi servername di Apache
RUN echo "ServerName ${SERVER_NAME}" >> /etc/apache2/apache2.conf

# Salin file aplikasi ke dalam container (pastikan aplikasi ada di folder yang sama dengan Dockerfile)
COPY . /var/www/html

# Set folder kerja
WORKDIR /var/www/html

# Set permission untuk folder aplikasi
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html

# Expose port 80 untuk Apache
EXPOSE 80

# Jalankan Apache
CMD ["apache2-foreground"]