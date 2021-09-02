# syntax=docker/dockerfile:experimental
#####################
### Scratch image ###
#####################
FROM php:7.4.16-fpm-alpine3.13 AS scratch

RUN set -x \
    && apk add --no-cache --virtual .build-deps postgresql-dev \
    && docker-php-ext-install -j$(nproc) pdo pdo_pgsql \
    && apk add --no-cache postgresql-libs \
    && apk del .build-deps

######################
### Composer image ###
######################
FROM scratch AS composer

COPY --from=composer:2.1 /usr/bin/composer /usr/local/bin/composer

########################
### Production image ###
########################
FROM composer AS production

RUN cp /usr/local/etc/php/php.ini-production /usr/local/etc/php/php.ini

# ENV TIDEWAYS_VERSION 5.0.4
# RUN set -x \
#     && mkdir -p /usr/src/php/ext/tideways_xhprof \
#     && curl "https://codeload.github.com/tideways/php-xhprof-extension/tar.gz/v${TIDEWAYS_VERSION}" \
#         | tar xvz --directory=/usr/src/php/ext/tideways_xhprof --strip=1 \
#     && docker-php-ext-install -j$(nproc) tideways_xhprof \
#     && rm -rf /usr/src/php/ext/tideways_xhprof

ENV XHPROF_VERSION master
RUN set -x \
    && mkdir -p /usr/src/php/ext/xhprof \
    && curl "https://codeload.github.com/longxinH/xhprof/tar.gz/${XHPROF_VERSION}" \
        | tar xvz --directory=/usr/src/php/ext/xhprof --strip=2 xhprof-${XHPROF_VERSION}/extension \
    && docker-php-ext-install -j$(nproc) xhprof \
    && rm -rf /usr/src/php/ext/xhprof

#####################
### nginx image   ###
#####################
FROM nginx:1.18-alpine AS nginx

RUN rm /etc/nginx/conf.d/default.conf
COPY symfony.conf.template /etc/nginx/templates/
