#!/usr/bin/env bash
set -euo pipefail
slug="${1:?usage: $0 <slug> [mail:true|false] [logging:true|false]}"
mail="${2:-false}"
logging="${3:-false}"
net="ktx-app-${slug}"

docker network create \
  --label ktx.app="${slug}" \
  --label ktx.proxy=true \
  --label ktx.database=false \
  --label ktx.mail="${mail}" \
  --label ktx.logging="${logging}" \
  --label ktx.ssh=false \
  "${net}"

echo "Created ${net}; run ktx-network-reconcile.sh"
