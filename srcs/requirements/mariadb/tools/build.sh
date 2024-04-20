#!/bin/bash

# Initialize the data directory
mysql_install_db --user=mysql --ldata=/var/lib/mysql

# Start MariaDB in the background for initial setup
mysqld_safe &

# Wait for MariaDB to start
sleep 5

# Perform initial setup
mysql -u root --password=$SQL_ROOT_PWD -e "CREATE DATABASE IF NOT EXISTS $SQL_DB;"
mysql -u root --password=$SQL_ROOT_PWD -e "DROP USER IF EXISTS '$SQL_USER'@'%'; FLUSH PRIVILEGES;"
mysql -u root --password=$SQL_ROOT_PWD -e "CREATE USER '$SQL_USER'@'%' IDENTIFIED BY '$SQL_USER_PWD';"
mysql -u root --password=$SQL_ROOT_PWD -e "GRANT ALL ON $SQL_DB.* TO '$SQL_USER'@'%'; FLUSH PRIVILEGES;"

# Shutdown the background MariaDB
mysqladmin -u root --password=$SQL_ROOT_PWD shutdown

# Start MariaDB in the foreground
exec mysqld