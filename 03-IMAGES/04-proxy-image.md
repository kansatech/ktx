# Traefik Image

> **Purpose:** Build a pinned public edge without giving it unrestricted Docker control.

Baseline: supported Traefik 3.7 release, pinned to an exact version/checksum in real releases.

Public: 80/443. No insecure dashboard port.

Traefik's Docker provider points at `tcp://ktx-dockerapi-01:2375`, **not** `/var/run/docker.sock` directly.

Configure:
- `exposedByDefault: false`
- `watch: true`
- global HTTP -> HTTPS redirect
- ACME resolver
- per-container `traefik.docker.network=ktx-site-<slug>`

Every public site must explicitly label `traefik.enable=true` and declare hostname(s) and backend port 8080.

Ordinary certificates: HTTP-01 or TLS-ALPN-01. Wildcards: DNS-01.

Persistent ACME state lives outside the container.
