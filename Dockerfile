FROM ubuntu:xenial

ENV REFRESHED_AT "2016-06-27 14:04:00"

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y -q nginx net-tools \
    && rm -rf /var/lib/apt/lists/*

ADD nginx.conf /etc/nginx/
ADD logformat.conf /etc/nginx/conf.d

# forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log \
	&& ln -sf /dev/stderr /var/log/nginx/error.log

EXPOSE 80 443

CMD ["nginx", "-g", "daemon off;"]
