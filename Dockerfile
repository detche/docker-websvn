FROM php:8.1-apache
WORKDIR /var/www/html

# Version of WebSVN to be used. Should this be changed, the compatbility of
# PHP image we use it to be verified.
ARG version=2.8.1

# Some dependencies, enscript is used for file content syntax coloration.
RUN apt-get update && apt-get install -y curl subversion enscript

# Those extensions are documented as required by WebPHP. Archive_Tar seemed to
# be installed already in that PHP image:
# https://websvnphp.github.io/docs/install.html
RUN pear channel-discover pear.geshi.org \
    && pear install geshi/geshi \
    && pear install Text_Diff

RUN curl -Lo $version.tar.gz https://github.com/websvnphp/websvn/archive/refs/tags/$version.tar.gz \
    && tar -xzf $version.tar.gz \
    && mv websvn-$version websvn \
    && rm $version.tar.gz

# Update the source code to allow customization of the About message by the
# docker container user.
COPY patches/customizable-about-text.patch customizable-about-text.patch
RUN patch -s -p0 < customizable-about-text.patch \
    && rm customizable-about-text.patch

# Felt cleaner to expose the site as document root rather than /websvn/...
ENV APACHE_DOCUMENT_ROOT /var/www/html/websvn
RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf
RUN sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf

# Our user will mount their repositories as subfolders of /repos,
# which are picked by websvn via our config.php.
RUN mkdir /repos
COPY config.php /var/www/html/websvn/include/config.php

RUN apt-get remove -y curl \
    && apt-get -y autoremove \
    && apt-get clean

EXPOSE 80
