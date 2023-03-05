FROM php:8.0-alpine
WORKDIR /app
COPY . .
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer
#RUN mv .env.example .env
#RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN composer install
RUN php artisan key:generate && php artisan cache:clear
EXPOSE 8000
RUN php artisan config:clear
RUN composer update
CMD php artisan serve --host 0.0.0.0 --port 8000