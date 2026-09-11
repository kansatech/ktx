ARG KTX_BASE_RELEASE
FROM ktx/base:${KTX_BASE_RELEASE}

RUN apt-get update \
 && apt-get install -y --no-install-recommends nginx \
 && rm -rf /var/lib/apt/lists/* \
 && rm -f /etc/nginx/sites-enabled/default

COPY nginx.conf /etc/nginx/nginx.conf.template
COPY entrypoint.sh /usr/local/sbin/ktx-dockerapi-entrypoint
RUN chmod 0755 /usr/local/sbin/ktx-dockerapi-entrypoint

EXPOSE 2375
ENTRYPOINT ["/usr/local/sbin/ktx-dockerapi-entrypoint"]
