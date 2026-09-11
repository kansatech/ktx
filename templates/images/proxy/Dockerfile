ARG KTX_BASE_RELEASE
FROM ktx/base:${KTX_BASE_RELEASE}

ARG TRAEFIK_VERSION=3.7.12
ARG TARGETARCH=amd64

RUN set -eux; \
    cd /tmp; \
    curl -fsSLO "https://github.com/traefik/traefik/releases/download/v${TRAEFIK_VERSION}/traefik_v${TRAEFIK_VERSION}_linux_${TARGETARCH}.tar.gz"; \
    curl -fsSLO "https://github.com/traefik/traefik/releases/download/v${TRAEFIK_VERSION}/traefik_v${TRAEFIK_VERSION}_checksums.txt"; \
    grep " traefik_v${TRAEFIK_VERSION}_linux_${TARGETARCH}.tar.gz$" "traefik_v${TRAEFIK_VERSION}_checksums.txt" > checksums.one; \
    sha256sum -c checksums.one; \
    tar -xzf "traefik_v${TRAEFIK_VERSION}_linux_${TARGETARCH}.tar.gz" traefik; \
    install -m 0755 traefik /usr/local/bin/traefik; \
    rm -rf /tmp/*

EXPOSE 80 443
ENTRYPOINT ["/usr/local/bin/traefik"]
CMD ["--configFile=/etc/traefik/traefik.yml"]
