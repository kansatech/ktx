ARG KTX_BASE_RELEASE
FROM ktx/base:${KTX_BASE_RELEASE}
RUN apt-get update \
 && apt-get install -y --no-install-recommends rsyslog logrotate \
 && rm -rf /var/lib/apt/lists/* \
 && mkdir -p /var/log/ktx
EXPOSE 514
CMD ["rsyslogd", "-n"]
