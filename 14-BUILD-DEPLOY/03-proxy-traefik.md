# Build and Deploy `ktx-proxy-01` (Traefik)

> **Purpose:** Build the HTTP/HTTPS edge, dynamic Docker discovery, redirects, and ACME certificate handling.

## Version

Use a supported Traefik 3.7.x release **at least 3.7.12**; 3.7.12 fixed a 2026 header-alias security issue affecting earlier 3.7 builds. Pin the exact release you test.

Example:

```bash
export TRAEFIK_VERSION=3.7.12
export KTX_RELEASE=2026.09.10-r2
```

## Build

```bash
cd /srv/ktx/platform/templates/images/proxy
sudo docker build \
  --build-arg KTX_BASE_RELEASE=${KTX_RELEASE} \
  --build-arg TRAEFIK_VERSION=${TRAEFIK_VERSION} \
  -t ktx/proxy:${KTX_RELEASE} .
```

The Dockerfile downloads the upstream release archive and verifies it against the release checksum list before installing the binary.

Verify:

```bash
sudo docker run --rm ktx/proxy:${KTX_RELEASE} version
```

## Create state/config

```bash
sudo mkdir -p /srv/ktx/containers/ktx-proxy-01
sudo mkdir -p /srv/ktx/data/proxy-01/acme
sudo touch /srv/ktx/data/proxy-01/acme/acme.json
sudo chmod 0600 /srv/ktx/data/proxy-01/acme/acme.json
sudo cp /srv/ktx/platform/templates/proxy/traefik.yml.example \
  /srv/ktx/containers/ktx-proxy-01/traefik.yml
sudo cp /srv/ktx/platform/templates/containers/proxy/compose.yml.example \
  /srv/ktx/containers/ktx-proxy-01/compose.yml
```

Edit:

- ACME email
- exact KTX image release
- staging vs production ACME endpoint if you use one

## Networks

Ensure:

```bash
sudo docker network inspect ktx-control >/dev/null || sudo docker network create ktx-control
```

Start Docker API proxy first, then Traefik:

```bash
cd /srv/ktx/containers/ktx-proxy-01
sudo docker compose up -d
sudo /srv/ktx/platform/templates/scripts/ktx-network-reconcile.sh
```

## Verify

```bash
sudo docker logs --tail=200 ktx-proxy-01
curl -I http://YOUR_PUBLIC_IP/
```

A site with a valid Traefik router should redirect HTTP to HTTPS and receive/renew its certificate automatically.

## Important

Do not mount `/var/run/docker.sock` into Traefik. It talks to `ktx-dockerapi-01` over `ktx-control`.

### Sources

- https://doc.traefik.io/traefik/providers/docker/
- https://github.com/traefik/traefik/security/advisories/GHSA-rf44-j88r-hh8c
