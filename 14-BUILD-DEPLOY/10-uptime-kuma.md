# Build and Deploy `ktx-uptime-01` (Uptime Kuma)

> **Purpose:** Build a pinned Uptime Kuma release into a KTX image and expose its UI only through Traefik.

## Version

As of this playbook revision, Uptime Kuma **2.5.3** is the current release. It requires Node.js >=20.4; the KTX source build uses Node.js 24 LTS.

```bash
export UPTIME_KUMA_VERSION=2.5.3
export NODE_VERSION=24.21.0
export KTX_RELEASE=2026.09.10-r2
```

## Build

```bash
cd /srv/ktx/platform/templates/images/uptime-kuma
sudo docker build \
  --build-arg KTX_BASE_RELEASE=${KTX_RELEASE} \
  --build-arg UPTIME_KUMA_VERSION=${UPTIME_KUMA_VERSION} \
  --build-arg NODE_VERSION=${NODE_VERSION} \
  -t ktx/uptime-kuma:${KTX_RELEASE} .
```

The build clones the exact upstream tag and runs the upstream non-Docker setup workflow. The runtime uses `/app/data` for state.

## Data

Uptime Kuma requires a filesystem with normal POSIX locking semantics. Upstream explicitly warns against NFS for `/app/data`.

```bash
sudo mkdir -p /srv/ktx/data/uptime-01
sudo chown -R 10001:10001 /srv/ktx/data/uptime-01
```

## Network and Compose

Create a dedicated application network. `true` enables attachment of the internal mail relay for notifications:

```bash
sudo /srv/ktx/platform/templates/scripts/ktx-app-network-create.sh uptime true false
sudo /srv/ktx/platform/templates/scripts/ktx-network-reconcile.sh
```

```bash
sudo mkdir -p /srv/ktx/containers/ktx-uptime-01
sudo cp /srv/ktx/platform/templates/containers/uptime-kuma/compose.yml.example \
  /srv/ktx/containers/ktx-uptime-01/compose.yml
```

Edit:

- image release
- monitoring hostname, e.g. `status.example.com`
- Traefik certificate resolver if different

Traefik and, when requested, `ktx-mail-01` are attached by reconciliation. This means recreating either shared container can be repaired with the same reconciliation command.

Start:

```bash
cd /srv/ktx/containers/ktx-uptime-01
sudo docker compose up -d
```

## First configuration

Open the HTTPS hostname and create the first administrator. Configure:

- external checks for every public site
- certificate-expiry monitoring
- backup-success monitor
- host disk/memory alerts through the mechanism you choose
- SMTP notification through `ktx-mail-01` if desired
- 2FA on the Uptime Kuma account

Do not expose port 3001 directly on prod.

## Verify

```bash
sudo docker logs --tail=100 ktx-uptime-01
sudo docker exec ktx-uptime-01 node --version
curl -I https://status.example.com/
```

## Update

Build the new pinned source tag on build, promote the image, update the Compose image tag, and recreate. `/srv/ktx/data/uptime-01` persists.

### Sources

- https://github.com/louislam/uptime-kuma/releases
- https://github.com/louislam/uptime-kuma/wiki/%F0%9F%94%A7-How-to-Install
- https://nodejs.org/en/about/previous-releases
