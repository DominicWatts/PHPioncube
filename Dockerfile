FROM php:5.6-cli
MAINTAINER Dominic Xigen <dominic@xigen.co.uk>

RUN php --version

ENV PHP_MEMORY_LIMIT 2G

ENV PHP_CONF_DIR=/usr/local/etc/php/conf.d

RUN apt-get update \
  && apt-get upgrade -y \
  && apt-get install -y --no-install-recommends \
  wget

# IonCube
RUN cd /tmp \
    && wget http://downloads3.ioncube.com/loader_downloads/ioncube_loaders_lin_x86-64.tar.gz \
    && tar xfz ioncube_loaders_lin_x86-64.tar.gz \
    && mkdir -p /usr/local/ \
    && mv ioncube /usr/local/ \
    && rm ioncube_loaders_lin_x86-64.tar.gz \
    && echo "zend_extension=/usr/local/ioncube/ioncube_loader_lin_5.6.so" > $PHP_CONF_DIR/99_docker-php-ext-ioncube_loader_lin_5.6.ini

RUN php -m

# And clean up the image
RUN rm -rf /var/lib/apt/lists/* \
    && apt-get autoremove -y \
    && apt-get clean

VOLUME ["/code"]
WORKDIR /code