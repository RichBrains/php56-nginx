FROM alpine:3.5

RUN apk --update --no-cache add \
        php5 \
        php5-bcmath \
        php5-dom \
        php5-ctype \
        php5-curl \
        php5-fpm \
        php5-gd \
        php5-iconv \
        php5-intl \
        php5-json \
        php5-mcrypt \
        php5-opcache \
        php5-openssl \
        php5-pdo \
        php5-pdo_mysql \
        php5-pdo_pgsql \
        php5-pdo_sqlite \
        php5-phar \
        php5-posix \
        php5-soap \
        php5-xml \
	php5-zip \
	php5-zlib \
        php5-mysql \
    && rm -rf /var/cache/apk/*

RUN apk --update --no-cache add \
        nginx \
        git \
        curl \
&& rm -rf /var/cache/apk/*


RUN apk --no-cache add ca-certificates wget
RUN wget --quiet --output-document=/etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub
RUN wget https://github.com/sgerrand/alpine-pkg-php5-redis/releases/download/3.1.6-r0/php5-redis-3.1.6-r0.apk
RUN apk add php5-redis-3.1.6-r0.apk



RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer && \
    mkdir -p /run/nginx

COPy ./php.ini /etc/php5/conf.d/php.ini
COPY ./init.sh /
COPY ./default.conf /etc/nginx/conf.d/default.conf
RUN chmod +x /init.sh

EXPOSE 80

ENTRYPOINT [ "/init.sh" ]
