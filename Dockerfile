FROM dotriver/alpine-s6

ENV TITLE="Test title" \
    ADMIN_USERNAME=admin \
    ADMIN_FULLNAME="test admin" \
    ADMIN_EMAIL=test.admin@test.com \
    ADMIN_PASSWORD=password \
    ACL_POLICY=open \
    ALLOW_REG=FALSE \
    LICENSE=gnufdl \
    SEND_USAGE_DATA=TRUE \
    APP_LANGUAGE=en

RUN set -x \
    && apk --no-cache add php7 php7-fpm php7-opcache php7-gd php7-session php7-json php7-openssl php7-ldap

RUN set -x \
    && apk --no-cache add nginx mysql-client \
    && mkdir -p /run/nginx/ \
    && rm -R /var/www/* || true \
    && chown nginx:nginx /var/www/ /run/nginx/

RUN set -x \
    && rm /etc/nginx/conf.d/* \
    && rm /etc/php7/php-fpm.d/* 

ADD conf/ /

RUN set -x \
    && chmod +x /etc/cont-init.d/ -R \
    && chmod +x /etc/periodic/ -R  \
    && chmod +x /etc/s6/services/ -R 