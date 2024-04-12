FROM debian:11

RUN apt-get update \
	&& apt-get install -y mariadb-server

COPY conf/my.cnf	/etc/mysql/mariadb.conf.d/my.cnf

COPY tools/build.sh /build.sh
COPY tools/entrypoint.sh /entrypoint.sh

ENTRYPOINT ["bash", "entrypoint.sh"]
EXPOSE 3306