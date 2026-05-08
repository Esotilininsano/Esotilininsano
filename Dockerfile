FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    apache2 \
    php8.1 \
    php8.1-sqlite3 \
    libapache2-mod-php8.1 \
    && apt-get clean

RUN a2dismod mpm_event && a2enmod mpm_prefork php8.1

RUN echo "DirectoryIndex index.php index.html" > /etc/apache2/mods-enabled/dir.conf

RUN rm -f /var/www/html/index.html

COPY . /var/www/html/

# Permisos correctos: directorio y db deben ser escribibles por Apache
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html \
    && chmod 664 /var/www/html/usuarios.db \
    && chmod 775 /var/www/html

EXPOSE 80

CMD ["apache2ctl", "-D", "FOREGROUND"]
