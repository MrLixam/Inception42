#!/bin/bash

set -x

mysql_install_db

service mariadb start;

mysql -u root -p${SQL_ROOT_PWD} -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PWD}'; FLUSH PRIVILEGES;"

DB_EXISTS=$(mysql -u root --password=${SQL_ROOT_PWD} -e "SHOW DATABASES LIKE '${SQL_DB}';" | grep ${SQL_DB})

if [ -n "$DB_EXISTS" ]; then
	echo "Mariadb $SQL_DB database exists."
else
	echo "Mariadb $SQL_DB database does not exist."
	mysql -u root --password=${SQL_ROOT_PWD} -e "CREATE DATABASE $SQL_DB; FLUSH PRIVILEGES;"
	mysql -u root --password=${SQL_ROOT_PWD} -e "CREATE USER '$SQL_USER'@'%' IDENTIFIED BY '$SQL_USER_PWD'; FLUSH PRIVILEGES"
	mysql -u root --password=${SQL_ROOT_PWD} -e "ALTER USER '${SQL_USER}'@'%' IDENTIFIED BY '${SQL_USER_PWD}'; FLUSH PRIVILEGES;"
	mysql -u root --password=${SQL_ROOT_PWD} -e "GRANT ALL ON $SQL_DB.* TO '$SQL_USER'@'%' IDENTIFIED BY '$SQL_USER_PWD' WITH GRANT OPTION; FLUSH PRIVILEGES"
fi

mysqladmin -u root --password=${SQL_ROOT_PWD} shutdown

mysqld