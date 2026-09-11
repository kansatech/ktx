#!/usr/bin/env bash
set -euo pipefail

SOCKET=/var/run/docker.sock
if [[ ! -S "$SOCKET" ]]; then
  echo "Docker socket missing at $SOCKET" >&2
  exit 1
fi

gid="$(stat -c '%g' "$SOCKET")"
if ! getent group "$gid" >/dev/null 2>&1; then
  groupadd -g "$gid" dockersock
  group=dockersock
else
  group="$(getent group "$gid" | cut -d: -f1)"
fi

sed "s/DOCKER_SOCKET_GROUP/${group}/" /etc/nginx/nginx.conf.template > /etc/nginx/nginx.conf
exec nginx -g 'daemon off;'
