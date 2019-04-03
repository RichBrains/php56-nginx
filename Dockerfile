FROM alpine:latest

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
    && rm -rf /var/cache/apk/*

RUN apk --update --no-cache add \
        nginx \
        git \
        curl \
&& rm -rf /var/cache/apk/*


RUN ln -s /usr/bin/php5 /usr/bin/php && \
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer && \
    mkdir -p /run/nginx


COPY ./init.sh /
COPY ./default.conf /etc/nginx/conf.d/default.conf
RUN chmod +x /init.sh

EXPOSE 80

ENTRYPOINT [ "/init.sh" ]
