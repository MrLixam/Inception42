FROM debian:11

RUN apt-get update \
	&& apt-get upgrade -y \
	&& apt-get install mariadb-server -y

COPY conf/my.cnf	/etc/mysql/mariadb.conf.d/50-server.cnf

COPY tools/build.sh /build.sh

ENTRYPOINT ["bash", "build.sh"]

EXPOSE 3306