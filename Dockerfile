# Pull base image
FROM centos:7

# locale && timezone
RUN  sed -i -e "s/LANG=\"en_US.UTF-8\"/LANG=\"ja_JP.UTF-8\"/g" /etc/locale.conf \
     && cp -p /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

# system update
RUN  yum -y update


# install repository & packages

     # [repo]] unit
COPY conf/nginx.repo /etc/yum.repos.d/nginx.repo
     # [repo]] nginx
COPY conf/unit.repo /etc/yum.repos.d/unit.repo
     # [repo]] epel
RUN  yum install -y epel-release \
     # [repo]] remim
     && rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-7.rpm \
     # [repo]] city-fan
     && rpm -Uvh http://www.city-fan.org/ftp/contrib/yum-repo/city-fan.org-release-1-13.rhel7.noarch.rpm \
     # tools
     && yum install -y \
        less \
        libcurl \
        net-tools \
     # nginx
     && yum install -y --enablerepo=unit \
        nginx \
     # unit
     && yum install -y --enablerepo=unit \
        unit \
     # php
     && yum install -y --enablerepo=remi-php54 \
        php \
        php-devel \
        php-embedded \
        php-mcrypt \
        php-mbstring \
        php-gd \
        php-mysql \
        php-pdo \
        php-xml \
        php-pecl-apcu \
        php-pecl-zendopcache \
     # cache cleaning
     && yum clean all

# nginx
RUN rm -rf /etc/nginx/conf.d/*
COPY ./conf/nginx.conf /etc/nginx/nginx.conf
COPY ./conf/backend-unit.conf /etc/nginx/conf.d/backend-unit.conf

# PHP
COPY ./conf/php.ini /etc/php.ini
COPY ./conf/index.php /var/www/html/index.php
COPY ./conf/config.json /etc/unit/config.json
COPY ./conf/startup.sh /etc/unit/startup.sh
RUN  chmod 755 /etc/unit/config.json && \
     chmod 755 /etc/unit/startup.sh

# document root
RUN groupadd --gid 1000 www-data \
    && useradd www-data --uid 1000 --gid 1000 \
    && chmod -R 755 /var/www \
    && chown -R www-data:www-data /var/www

# listen port
EXPOSE 8300

# startup
ENTRYPOINT /usr/local/startup.sh
