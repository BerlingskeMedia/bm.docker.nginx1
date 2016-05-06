FROM debian:jessie

RUN apt-get update && apt-get install -y nginx && apt-get install -y net-tools

ADD nginx.conf /etc/nginx/
ADD logformat.conf /etc/nginx/conf.d

RUN echo "upstream php-upstream { server php:9000; }" > /etc/nginx/conf.d/upstream.conf

RUN usermod -u 1000 www-data
RUN groupmod -g 1000 www-data

CMD ["nginx"]
