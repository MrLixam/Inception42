#!bin/bash

sleep 10

if [! -e /var/www/wordpress/wp-config.php]; then
wp config create --allow-root --dbname=$SQL_DB --dbuser=$SQL_USER --dbpass=$SQL_PWD --dbhost=mariadb:3306 --path='/var/www/wordpress'

wp core install --url=$DOMAIN --title=inception --admin_user=$ADMIN_USER --admin_password=$ADMIN_PWD --allow-root --path='/var/www/wordpress'
wp user create --allow-root --role=author $USER1 --user_pass=$USER1_PWD --path='/var/www/wordpress'
fi
if [! -d /run/php]; then
	mkdir ./run/php
fi
/usr/sbin/php-fpm7.3 -F