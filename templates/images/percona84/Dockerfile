ARG KTX_BASE_RELEASE
FROM ktx/base:${KTX_BASE_RELEASE}
ARG DEBIAN_FRONTEND=noninteractive
ENV PERCONA_TELEMETRY_DISABLE=1

RUN set -eux; \
    printf '#!/bin/sh\nexit 101\n' > /usr/sbin/policy-rc.d; chmod +x /usr/sbin/policy-rc.d; \
    apt-get update; apt-get install -y --no-install-recommends curl gnupg2 lsb-release debconf-utils; \
    cd /tmp; curl -fsSLO https://repo.percona.com/apt/percona-release_latest.generic_all.deb; \
    apt-get install -y ./percona-release_latest.generic_all.deb; \
    percona-release setup -y ps-84-lts --scheme https; \
    percona-release enable ps-84-lts release --scheme https; \
    apt-get update; \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends percona-server-server percona-server-client; \
    rm -f /usr/sbin/policy-rc.d; \
    rm -rf /var/lib/apt/lists/* /tmp/*

COPY mysqld.cnf /etc/mysql/mysql.conf.d/90-ktx.cnf
COPY entrypoint.sh /usr/local/sbin/ktx-percona-entrypoint
RUN chmod 0755 /usr/local/sbin/ktx-percona-entrypoint \
 && mkdir -p /run/mysqld /var/lib/mysql \
 && chown -R mysql:mysql /run/mysqld /var/lib/mysql

EXPOSE 3306
ENTRYPOINT ["/usr/local/sbin/ktx-percona-entrypoint"]
