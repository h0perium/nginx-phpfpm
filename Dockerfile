FROM php:fpm

# Install additional dependencies
RUN apt-get update \
    && apt-get install -y \
        libmcrypt-dev \
	nginx \
        default-mysql-client \
    && rm -rf /var/lib/apt/lists/*

#COPY nginx.conf /etc/nginx/nginx.conf

# Install PHP extensions
RUN docker-php-ext-install mysqli pdo pdo_mysql && docker-php-ext-enable pdo_mysql

# Copy NGINX configuration
COPY nginx.conf /etc/nginx/nginx.conf
COPY fastcgi_params /etc/nginx/fastcgi_params

# Copy the entrypoint script
COPY entrypoint.sh /entrypoint.sh

# Make the entrypoint script executable
RUN chmod +x /entrypoint.sh

# Expose ports (if needed)
EXPOSE 80

# Set the entrypoint
ENTRYPOINT ["/entrypoint.sh"]
