#!/bin/bash
set -x

until mysql -h mariadb -u $SQL_USER --password=$SQL_USER_PWD -e ";" ; do
    echo "Waiting for database connection..."
    sleep 2
done

if [ ! -f /var/www/wordpress/wp-config.php ]; then
    echo "Installing WordPress..."
    wp.phar core download --allow-root --path='/var/www/wordpress'
    wp.phar config create --allow-root --dbname=$SQL_DB --dbuser=$SQL_USER --dbpass=$SQL_USER_PWD --dbhost=mariadb --path='/var/www/wordpress'
    wp.phar core install  --allow-root --url=$DOMAIN --title='Inception' --admin_user=$ADMIN_USER --admin_password=$ADMIN_PWD --admin_email=$ADMIN_EMAIL --path='/var/www/wordpress'
    wp.phar user create $USER1 $USER1_EMAIL --allow-root --user_pass=$USER1_PWD --role=author --path='/var/www/wordpress'
else
    echo "WordPress is already installed."
fi

if [ ! -d /run/php ]; then
 	mkdir -p /run/php
fi
chown www-data:www-data /run/php
exec php-fpm7.4 -F