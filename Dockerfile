FROM php:8.4-apache

# Ativar módulos do Apache
RUN a2enmod rewrite

# Instalar extensões do PHP necessárias para o Laravel
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip \
    git \
    curl \
    libzip-dev \
    libsqlite3-dev \
    && docker-php-ext-install pdo_mysql pdo_sqlite mbstring exif pcntl bcmath gd zip

# Configurar o DocumentRoot do Apache para a pasta /public do Laravel
ENV APACHE_DOCUMENT_ROOT /var/www/html/public
RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf
RUN sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf

# Instalar Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Copiar os arquivos do projeto
WORKDIR /var/www/html
COPY . .

# Instalar dependências do PHP
RUN composer install --no-dev --optimize-autoloader --no-interaction

# Ajustar permissões para as pastas de cache e storage
RUN chown -R www-data:www-data storage bootstrap/cache

# Variáveis de ambiente para o Docker
ENV APP_ENV=production
ENV APP_DEBUG=false
ENV LOG_CHANNEL=stderr

# Porta padrão que o Render espera (Render injeta a porta, mas o Apache usa 80 por padrão)
EXPOSE 80

# Comando para iniciar o Apache
CMD ["apache2-foreground"]
