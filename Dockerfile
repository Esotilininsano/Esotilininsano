FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    apache2 \
    php8.1 \
    php8.1-sqlite3 \
    libapache2-mod-php8.1 \
    && apt-get clean

RUN a2dismod mpm_event && a2enmod mpm_prefork php8.1

COPY . /var/www/html/
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html

EXPOSE 80

CMD ["apache2ctl", "-D", "FOREGROUND"]
