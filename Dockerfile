# Pull base image
FROM centos:7

# Locale && Timezone
RUN  sed -i -e "s/LANG=\"en_US.UTF-8\"/LANG=\"ja_JP.UTF-8\"/g" /etc/locale.conf && \
     cp -p /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

# System update
RUN  yum -y update

# Install repository
COPY conf/nginx.repo /etc/yum.repos.d/nginx.repo
COPY conf/unit.repo /etc/yum.repos.d/unit.repo
RUN  yum install -y epel-release && \
     rpm -Uvh http://www.city-fan.org/ftp/contrib/yum-repo/city-fan.org-release-1-13.rhel7.noarch.rpm && \
     rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-7.rpm

RUN  yum install -y \
        # Tools
        libcurl \
        net-tools && \
     yum install -y --enablerepo=nginx \
        # nginx
        nginx && \
     yum install -y --enablerepo=unit \
        # Nginx Unit
        unit && \
     yum install -y --enablerepo=remi-php54 \
        # PHP
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
        php-pecl-zendopcache && \
     # Cache cleaning
     yum clean all

# nginx
RUN rm /etc/nginx/conf.d/default.conf
COPY ./conf/vhost-unit.conf /etc/nginx/conf.d/vhost-unit.conf

# PHP
COPY ./conf/php.ini /etc/php.ini
COPY ./conf/index.php /var/www/html/index.php
COPY ./conf/config.json /etc/unit/config.json
COPY ./conf/startup.sh /etc/unit/startup.sh
RUN  chmod 755 /etc/unit/config.json && \
     chmod 755 /etc/unit/startup.sh

# document root
RUN groupadd --gid 1000 www-data && \
    useradd www-data --uid 1000 --gid 1000 && \
    chmod -R 755 /var/www && \
    chown -R www-data:www-data /var/www

# Listen port
EXPOSE 8300

# Startup
CMD /etc/unit/startup.sh
