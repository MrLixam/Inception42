FROM debian:11

RUN apt-get update \
	&& apt-get upgrade \
	&& apt-get install mariadb-server -y

COPY conf/my.cnf /etc/mysql/mariadb.conf.d/my.cnf