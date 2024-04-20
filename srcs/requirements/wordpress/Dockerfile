FROM debian:11

RUN apt-get update \
	&& apt-get install -y wget \
	&& apt-get install -y php php-fpm php-mysql mariadb-client curl

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

RUN chmod +x wp-cli.phar

RUN mv wp-cli.phar /usr/local/bin/wp

COPY conf/www.conf /etc/php/7.4/fpm/pool.d/
COPY tools/build.sh /build.sh

EXPOSE 9000

ENTRYPOINT ["bash", "build.sh"]