#!/bin/bash
set -x

# Wait for the database to be ready
until mysql -h mariadb -u $SQL_USER --password=$SQL_USER_PWD -e ";" ; do
    echo "Waiting for database connection..."
    sleep 2
done

# Check if WordPress is already installed
if ! wp core is-installed --allow-root --path='/var/www/wordpress'; then
    echo "Installing WordPress..."
    wp core download --allow-root --path='/var/www/wordpress'
    wp config create --allow-root --dbname=$SQL_DB --dbuser=$SQL_USER --dbpass=$SQL_USER_PWD --dbhost=mariadb --path='/var/www/wordpress'
    wp core install  --allow-root --url=$DOMAIN --title='Inception' --admin_user=$ADMIN_USER --admin_password=$ADMIN_PWD --admin_email=$ADMIN_EMAIL --path='/var/www/wordpress'
    wp user create $USER1 $USER1_EMAIL --user_pass=$USER1_PWD --role=author --allow-root --path='/var/www/wordpress'
else
    echo "WordPress is already installed."
fi



##!bin/bash

# sed -i 's|9000|'9000'|g' /etc/php/7.3/fpm/pool.d/www.conf

# if [ ! -f /var/www/wordpress/wp-config.php ]
# then
# 	wp core download --allow-root --path=/var/www/wordpress
# 	wp config create --allow-root --dbname=$SQL_DB --dbuser=$SQL_USER --dbpass=$SQL_USER_PWD --dbhost=mariadb --path='/var/www/wordpress' --skip-check

# 	wp core install --url=$DOMAIN --title=inception --admin_user=$ADMIN_USER --admin_email=$ADMIN_EMAIL --admin_password=$ADMIN_PWD --allow-root --path='/var/www/wordpress'
# 	wp user create --allow-root --role=author $USER1 --user_pass=$USER1_PWD --path='/var/www/wordpress'
# fi
# if [ ! -d /run/php ]; then
# 	mkdir -p /run/php
# fi
# chown www-data:www-data /run/php

# /usr/sbin/php-fpm7.4 -F