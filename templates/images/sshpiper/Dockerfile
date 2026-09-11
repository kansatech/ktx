# Build stage intentionally uses upstream Go tooling; the runtime is KTX-owned.
ARG SSHPIPER_VERSION=v1.5.4
FROM golang:1.26-bookworm AS build
ARG SSHPIPER_VERSION
WORKDIR /src
RUN git clone --depth 1 --branch "${SSHPIPER_VERSION}" https://github.com/tg123/sshpiper.git . \
 && mkdir -p /out/plugins \
 && (cd cmd/sshpiperd && go build -o /out/sshpiperd .) \
 && go build -tags full -o /out/plugins ./plugin/workingdir

ARG KTX_BASE_RELEASE
FROM ktx/base:${KTX_BASE_RELEASE}
RUN useradd -r -u 10001 -m -d /var/lib/sshpiper -s /usr/sbin/nologin sshpiper \
 && mkdir -p /var/sshpiper /etc/sshpiper \
 && chown -R sshpiper:sshpiper /var/sshpiper /etc/sshpiper
COPY --from=build /out/sshpiperd /usr/local/bin/sshpiperd
COPY --from=build /out/plugins/workingdir /usr/local/bin/workingdir
USER sshpiper
EXPOSE 2222
ENTRYPOINT ["/usr/local/bin/sshpiperd"]
CMD ["--port", "2222", "--server-key-generate-mode", "notexist", "--server-key", "/etc/sshpiper/ssh_host_ed25519_key", "/usr/local/bin/workingdir", "--root", "/var/sshpiper", "--strict-hostkey", "--no-password-auth"]
