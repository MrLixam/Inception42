FROM debian:11

RUN apt-get update \
	&& apt-get install -y wget \
	&& apt-get install -y php php-fpm php-mysql mariadb-client curl

RUN wget https://github.com/wp-cli/wp-cli/releases/download/v2.10.0/wp-cli-2.10.0.phar

RUN chmod +x wp-cli-2.10.0.phar

RUN mv wp-cli-2.10.0.phar /usr/local/bin/wp.phar

COPY conf/www.conf /etc/php/7.4/fpm/pool.d/
COPY tools/build.sh /build.sh

EXPOSE 9000

ENTRYPOINT ["bash", "build.sh"]

CMD ["php-fpm7.4", "-F"]
