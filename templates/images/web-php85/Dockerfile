ARG KTX_BASE_RELEASE
FROM ktx/base:${KTX_BASE_RELEASE}

ARG DEBIAN_FRONTEND=noninteractive

# PHP 8.5 is not Ubuntu 24.04's archive baseline.
# Treat the Ondrej PHP PPA as a deliberate dependency and pin/test releases.
RUN apt-get update \
 && apt-get install -y --no-install-recommends software-properties-common gnupg \
 && add-apt-repository -y ppa:ondrej/php \
 && apt-get update \
 && apt-get install -y --no-install-recommends \
      apache2 supervisor cron openssh-server rsyslog git unzip composer \
      php8.5-cli php8.5-fpm php8.5-opcache php8.5-mysql \
      php8.5-curl php8.5-gd php8.5-intl php8.5-mbstring \
      php8.5-xml php8.5-zip php8.5-bcmath php8.5-soap \
 && mkdir -p /run/sshd /var/www/html /opt/ktx-health /etc/ssh/ktx-hostkeys \
 && useradd -m -s /bin/bash site \
 && mkdir -p /home/site/.ssh \
 && chmod 0700 /home/site/.ssh \
 && chown -R site:site /home/site /var/www/html \
 && sed -i 's/^Listen 80$/Listen 8080/' /etc/apache2/ports.conf \
 && rm -rf /var/lib/apt/lists/*

RUN a2dismod mpm_prefork || true
RUN a2enmod mpm_event proxy proxy_fcgi setenvif rewrite headers remoteip \
 && a2enconf php8.5-fpm

COPY apache/000-default.conf /etc/apache2/sites-available/000-default.conf
COPY php/zz-ktx.conf /etc/php/8.5/fpm/pool.d/zz-ktx.conf
COPY supervisor/ktx.conf /etc/supervisor/conf.d/ktx.conf
COPY ssh/10-ktx-site.conf /etc/ssh/sshd_config.d/10-ktx-site.conf
COPY rsyslog/50-ktx-forward.conf /etc/rsyslog.d/50-ktx-forward.conf
COPY health/index.html /opt/ktx-health/index.html

EXPOSE 8080 2222
CMD ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisor/supervisord.conf"]
