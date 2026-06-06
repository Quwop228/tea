FROM php:8.2-apache

RUN docker-php-ext-install pdo_mysql opcache \
    && a2enmod headers expires \
    && { \
        echo 'opcache.enable=1'; \
        echo 'opcache.enable_cli=0'; \
        echo 'opcache.memory_consumption=128'; \
        echo 'opcache.interned_strings_buffer=16'; \
        echo 'opcache.max_accelerated_files=10000'; \
        echo 'opcache.validate_timestamps=0'; \
        echo 'opcache.jit_buffer_size=64M'; \
        echo 'opcache.jit=tracing'; \
    } > /usr/local/etc/php/conf.d/opcache.ini \
    && { \
        echo 'memory_limit=128M'; \
        echo 'post_max_size=8M'; \
        echo 'upload_max_filesize=8M'; \
        echo 'expose_php=Off'; \
        echo 'display_errors=Off'; \
        echo 'log_errors=On'; \
    } > /usr/local/etc/php/conf.d/app.ini \
    && { \
        echo '<IfModule mod_headers.c>'; \
        echo '  Header set X-Content-Type-Options "nosniff"'; \
        echo '  Header set X-Frame-Options "SAMEORIGIN"'; \
        echo '  Header set Referrer-Policy "strict-origin-when-cross-origin"'; \
        echo '</IfModule>'; \
        echo '<FilesMatch "\.(ttf|otf|woff|woff2)$">'; \
        echo '  Header set Access-Control-Allow-Origin "*"'; \
        echo '  Header set Cache-Control "public, max-age=2592000"'; \
        echo '</FilesMatch>'; \
        echo 'AddType application/font-ttf .ttf'; \
        echo 'AddType image/svg+xml .svg'; \
    } > /etc/apache2/conf-available/app.conf \
    && a2enconf app

COPY public/ /var/www/html/
COPY src/    /var/www/src/
COPY config/ /var/www/config/

RUN chown -R www-data:www-data /var/www \
    && find /var/www -type d -exec chmod 755 {} \; \
    && find /var/www -type f -exec chmod 644 {} \;

EXPOSE 80

HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
    CMD curl -fsS http://127.0.0.1/ > /dev/null || exit 1
