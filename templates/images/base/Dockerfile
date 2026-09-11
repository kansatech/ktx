FROM ubuntu:24.04

ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=UTC LANG=C.UTF-8 LC_ALL=C.UTF-8

RUN apt-get update \
 && apt-get dist-upgrade -y \
 && apt-get install -y --no-install-recommends \
      ca-certificates curl tzdata procps iproute2 netcat-openbsd \
 && rm -rf /var/lib/apt/lists/*

CMD ["/bin/bash"]
