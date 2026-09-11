ARG KTX_BASE_RELEASE
FROM ktx/base:${KTX_BASE_RELEASE}
ARG DEBIAN_FRONTEND=noninteractive

RUN echo 'postfix postfix/mailname string ktx-mail-01' | debconf-set-selections \
 && echo 'postfix postfix/main_mailer_type select No configuration' | debconf-set-selections \
 && apt-get update \
 && apt-get install -y --no-install-recommends postfix libsasl2-modules ca-certificates \
 && rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh /usr/local/sbin/ktx-postfix-entrypoint
RUN chmod 0755 /usr/local/sbin/ktx-postfix-entrypoint

EXPOSE 25
ENTRYPOINT ["/usr/local/sbin/ktx-postfix-entrypoint"]
