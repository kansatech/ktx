ARG KTX_BASE_RELEASE
FROM ktx/base:${KTX_BASE_RELEASE} AS build
ARG UPTIME_KUMA_VERSION=2.5.3
ARG NODE_VERSION=24.21.0
ARG NODE_ARCH=x64

RUN apt-get update \
 && apt-get install -y --no-install-recommends git build-essential python3 xz-utils \
 && rm -rf /var/lib/apt/lists/* \
 && cd /tmp \
 && curl -fsSLO "https://nodejs.org/dist/v${NODE_VERSION}/node-v${NODE_VERSION}-linux-${NODE_ARCH}.tar.xz" \
 && tar -xJf "node-v${NODE_VERSION}-linux-${NODE_ARCH}.tar.xz" -C /opt \
 && ln -s "/opt/node-v${NODE_VERSION}-linux-${NODE_ARCH}" /opt/node
ENV PATH=/opt/node/bin:$PATH
WORKDIR /src
RUN git clone --depth 1 --branch "${UPTIME_KUMA_VERSION}" https://github.com/louislam/uptime-kuma.git . \
 && npm run setup

ARG KTX_BASE_RELEASE
FROM ktx/base:${KTX_BASE_RELEASE}
ARG NODE_VERSION=24.21.0
ARG NODE_ARCH=x64
RUN apt-get update \
 && apt-get install -y --no-install-recommends iputils-ping sqlite3 tini \
 && rm -rf /var/lib/apt/lists/* \
 && useradd -r -u 10001 -m -d /app uptime \
 && mkdir -p /app/data \
 && chown -R uptime:uptime /app
COPY --from=build "/opt/node-v${NODE_VERSION}-linux-${NODE_ARCH}" "/opt/node-v${NODE_VERSION}-linux-${NODE_ARCH}"
RUN ln -s "/opt/node-v${NODE_VERSION}-linux-${NODE_ARCH}" /opt/node
COPY --from=build --chown=uptime:uptime /src /app
ENV PATH=/opt/node/bin:$PATH UPTIME_KUMA_IS_CONTAINER=1
WORKDIR /app
USER uptime
EXPOSE 3001
ENTRYPOINT ["/usr/bin/tini", "--"]
CMD ["node", "server/server.js"]
