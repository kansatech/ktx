#!/usr/bin/env bash
set -euo pipefail
slug="${1:?usage: $0 <slug> <database:true|false> <mail:true|false> <ssh:true|false>}"
database="${2:-true}"
mail="${3:-true}"
ssh="${4:-false}"
net="ktx-site-${slug}"

docker network create \
  --label ktx.site="${slug}" \
  --label ktx.proxy=true \
  --label ktx.database="${database}" \
  --label ktx.mail="${mail}" \
  --label ktx.logging=true \
  --label ktx.ssh="${ssh}" \
  "${net}"

echo "Created ${net}; run ktx-network-reconcile.sh"
