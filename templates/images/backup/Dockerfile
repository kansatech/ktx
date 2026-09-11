ARG KTX_BASE_RELEASE
FROM ktx/base:${KTX_BASE_RELEASE}
ARG RESTIC_VERSION=0.19.1
ARG TARGETARCH=amd64

RUN apt-get update \
 && apt-get install -y --no-install-recommends bzip2 zstd default-mysql-client sqlite3 \
 && rm -rf /var/lib/apt/lists/* \
 && cd /tmp \
 && curl -fsSLO "https://github.com/restic/restic/releases/download/v${RESTIC_VERSION}/restic_${RESTIC_VERSION}_linux_${TARGETARCH}.bz2" \
 && curl -fsSLO "https://github.com/restic/restic/releases/download/v${RESTIC_VERSION}/SHA256SUMS" \
 && grep " restic_${RESTIC_VERSION}_linux_${TARGETARCH}.bz2$" SHA256SUMS > checksums.one \
 && sha256sum -c checksums.one \
 && bunzip2 "restic_${RESTIC_VERSION}_linux_${TARGETARCH}.bz2" \
 && install -m 0755 "restic_${RESTIC_VERSION}_linux_${TARGETARCH}" /usr/local/bin/restic \
 && rm -rf /tmp/*

COPY ktx-backup.sh /usr/local/sbin/ktx-backup
COPY ktx-restic.sh /usr/local/bin/ktx-restic
RUN chmod 0755 /usr/local/sbin/ktx-backup /usr/local/bin/ktx-restic
CMD ["sleep", "infinity"]
