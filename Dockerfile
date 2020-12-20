FROM debian:buster

RUN apt-get update && apt-get upgrade &&  apt-get install -y vim wget libnss3-tools 
RUN apt-get -y install nginx 
RUN apt-get -y install php7.3  php7.3-cli php7.3-cgi php7.3-mbstring php7.3-fpm php7.3-mysql
RUN apt-get -y install mariadb-server

WORKDIR /var/www/localhost
WORKDIR /tmp/mkcert
COPY srcs/init_container.sh /tmp

COPY srcs/nginx-local /etc/nginx/sites-enabled/nginx-local
RUN rm -f /etc/nginx/sites-enabled/default /etc/nginx/sites-available/default
RUN ln -s /etc/nginx/sites-enabled/nginx-local /etc/nginx/sites-available/nginx-local

RUN wget -P /tmp  https://wordpress.org/latest.tar.gz 
RUN wget -P /tmp https://files.phpmyadmin.net/phpMyAdmin/4.9.7/phpMyAdmin-4.9.7-all-languages.tar.gz
RUN wget -P /tmp/mkcert https://github.com/FiloSottile/mkcert/releases/download/v1.1.2/mkcert-v1.1.2-linux-amd64

COPY srcs/wordpress.sql /tmp
COPY srcs/wp-config.php /tmp 
COPY srcs/database /tmp 

WORKDIR /tmp
