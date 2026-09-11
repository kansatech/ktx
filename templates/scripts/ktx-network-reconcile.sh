#!/usr/bin/env bash
set -euo pipefail

present() { docker container inspect "$1" >/dev/null 2>&1; }
connected() {
  docker network inspect "$1" --format '{{range $id,$c := .Containers}}{{$c.Name}}{{"\n"}}{{end}}' | grep -Fxq "$2"
}
want() {
  local net="$1" label="$2"
  [[ "$(docker network inspect "$net" --format "{{ index .Labels \"$label\" }}")" == "true" ]]
}
attach() {
  local net="$1" c="$2"
  present "$c" || { echo "  skip $c (absent)"; return; }
  connected "$net" "$c" && { echo "  ok   $c"; return; }
  echo "  add  $c"; docker network connect "$net" "$c"
}

mapfile -t nets < <(docker network ls --format '{{.Name}}' | grep '^ktx-site-' | sort)
for net in "${nets[@]}"; do
  echo "Reconciling $net"
  want "$net" ktx.proxy    && attach "$net" ktx-proxy-01
  want "$net" ktx.database && attach "$net" ktx-percona-01
  want "$net" ktx.mail     && attach "$net" ktx-mail-01
  want "$net" ktx.logging  && attach "$net" ktx-log-01
  want "$net" ktx.ssh      && attach "$net" ktx-ssh-01
done
