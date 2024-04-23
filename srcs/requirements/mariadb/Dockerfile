FROM debian:11

RUN apt-get update \
	&& apt-get install -y mariadb-server

EXPOSE 3306

RUN mkdir -p /run/mariadb
COPY ./tools/build.sh /run/mariadb/build.sh
COPY ./conf/my.cnf /etc/mysql/mariadb.conf.d/myserver.cnf

RUN mkdir -p /var/run/mysqld \
	&& chown -R mysql:mysql /var/run/mysqld \
	&& chmod 777 /var/run/mysqld

RUN chmod +x /run/mariadb/build.sh

RUN mkdir  -p /var/log/mariadb && touch /var/log/mariadb/error.log
ENTRYPOINT ["bash", "/run/mariadb/build.sh"]
