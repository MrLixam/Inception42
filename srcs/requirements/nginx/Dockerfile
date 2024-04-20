FROM debian:11

RUN apt-get update \
	&& apt-get install -y nginx openssl curl

RUN mkdir /etc/nginx/ssl

RUN openssl req -x509 -nodes \
	-keyout /etc/nginx/ssl/nginx.key \
	-out /etc/nginx/ssl/nginx.crt \
	-subj "/C=FR/ST=Charente/L=Angouleme/O=42/OU=Seekers/CN=lvincent.42.fr/UID=lvincent"

COPY config/nginx.conf /etc/nginx/nginx.conf

RUN chmod 777 /var/www/html
RUN chown -R www-data:www-data /var/www/html

CMD ["nginx", "-g", "daemon off;"]
