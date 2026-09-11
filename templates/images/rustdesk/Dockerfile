ARG KTX_BASE_RELEASE
FROM ktx/base:${KTX_BASE_RELEASE}
ARG RUSTDESK_VERSION=1.1.16
ARG TARGETARCH=amd64
ARG RUSTDESK_AMD64_SHA256=0565c41affe6c3f409b0bddfaf5a24ccbf3f64f5f8e3fec250b69a0d5f6bdbcf

RUN apt-get update \
 && apt-get install -y --no-install-recommends unzip supervisor \
 && rm -rf /var/lib/apt/lists/* \
 && cd /tmp \
 && curl -fsSLo rustdesk.zip "https://github.com/rustdesk/rustdesk-server/releases/download/${RUSTDESK_VERSION}/rustdesk-server-linux-${TARGETARCH}.zip" \
 && if [ "$TARGETARCH" = "amd64" ] && [ "$RUSTDESK_VERSION" = "1.1.16" ]; then echo "${RUSTDESK_AMD64_SHA256}  rustdesk.zip" | sha256sum -c -; fi \
 && unzip rustdesk.zip \
 && HBBS="$(find . -type f -name hbbs -print -quit)" \
 && HBBR="$(find . -type f -name hbbr -print -quit)" \
 && test -n "$HBBS" && test -n "$HBBR" \
 && install -m 0755 "$HBBS" /usr/local/bin/hbbs \
 && install -m 0755 "$HBBR" /usr/local/bin/hbbr \
 && rm -rf /tmp/* \
 && mkdir -p /data

COPY supervisord.conf /etc/supervisor/conf.d/rustdesk.conf
WORKDIR /data
EXPOSE 21115 21116 21117
EXPOSE 21116/udp
CMD ["/usr/bin/supervisord", "-n"]
