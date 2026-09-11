# Build and Deploy `ktx-rustdesk-01` (RustDesk Server OSS)

> **Purpose:** Run RustDesk's ID/rendezvous (`hbbs`) and relay (`hbbr`) services from one KTX-managed image/data directory.

## Version

As of this revision, RustDesk Server OSS **1.1.16** is the current release.

```bash
export RUSTDESK_VERSION=1.1.16
export KTX_RELEASE=2026.09.10-r2
```

## Build

The supplied baseline Dockerfile is written for the normal **linux/amd64** VPS target. For ARM, update the upstream asset name and checksum deliberately rather than assuming Docker's architecture string matches RustDesk's release filename.

The KTX image downloads the official upstream Linux release archive. The baseline `1.1.16`/amd64 build pins and verifies GitHub's published SHA-256 (`0565c41a…dbcf`). When changing RustDesk version/architecture, update the expected checksum from the release assets before building; do not silently skip verification.

```bash
cd /srv/ktx/platform/templates/images/rustdesk
sudo docker build \
  --build-arg KTX_BASE_RELEASE=${KTX_RELEASE} \
  --build-arg RUSTDESK_VERSION=${RUSTDESK_VERSION} \
  -t ktx/rustdesk-server:${KTX_RELEASE} .
```

Verify:

```bash
sudo docker run --rm ktx/rustdesk-server:${KTX_RELEASE} hbbs --help
sudo docker run --rm ktx/rustdesk-server:${KTX_RELEASE} hbbr --help
```

## Data

```bash
sudo mkdir -p /srv/ktx/data/rustdesk-01
sudo chmod 0700 /srv/ktx/data/rustdesk-01
```

`hbbs` generates/uses the server key in this persistent directory. Protect the private key; changing it changes what clients trust.

## Ports

RustDesk OSS consists of two services. Core self-hosting normally uses:

- TCP 21115
- TCP/UDP 21116
- TCP 21117

WebSocket ports 21118/21119 are only needed if you intentionally use the web client; keep them closed otherwise.

This is an exception to the “only proxy/SSH publish ports” rule because RustDesk is a non-HTTP protocol service and clients must reach its native ports.

## Deploy

```bash
sudo mkdir -p /srv/ktx/containers/ktx-rustdesk-01
sudo cp /srv/ktx/platform/templates/containers/rustdesk/compose.yml.example \
  /srv/ktx/containers/ktx-rustdesk-01/compose.yml

cd /srv/ktx/containers/ktx-rustdesk-01
sudo docker compose up -d
```

The image supervises `hbbs` and `hbbr` in the same container because KTX treats RustDesk Server as one appliance. If you later need independent scaling/restarts, split them into `ktx-rustdesk-hbbs-01` and `ktx-rustdesk-hbbr-01` while sharing the appropriate persistent key/config.

## Firewall

Open only the RustDesk ports you actually use at the provider/host firewall.

## Verify

```bash
sudo docker logs --tail=200 ktx-rustdesk-01
sudo ss -lntup | grep 2111
sudo cat /srv/ktx/data/rustdesk-01/id_ed25519.pub
```

Configure clients with the server DNS name and public key.

## Update

Build from the new pinned release, test client registration and relay behavior on dev, promote exact artifact, recreate using the existing data/key directory.

### Sources

- https://rustdesk.com/docs/en/self-host/rustdesk-server-oss/
- https://rustdesk.com/docs/en/self-host/rustdesk-server-oss/docker/
- https://github.com/rustdesk/rustdesk-server/releases
