# Build and Deploy Individual Containers

> **Purpose:** The hands-on layer: build the image, create its directories/configuration, start the container, verify it, and know how to update it.

This section exists because an architecture diagram is lovely right up until 11:47 PM when you need to rebuild `ktx-mail-01` and cannot remember whether Postfix was supposed to own a volume.

## Image policy

There are two categories:

### KTX core images

These are built from KTX-controlled Dockerfiles/configuration:

- `ktx/base`
- `ktx/web-php85`
- `ktx/proxy`
- `ktx/dockerapi`
- `ktx/sshpiper`
- `ktx/percona84`
- `ktx/mail`
- `ktx/log`
- `ktx/backup`

### Application appliances

These are complex upstream applications where maintaining a private fork of their complete build system buys little. KTX still pins the upstream source/release, builds or packages it on `ktx-build-26`, gives it a KTX image tag, exports it, tests the exact artifact on dev, and promotes those exact bytes to prod.

- `ktx/uptime-kuma`
- `ktx/vaultwarden`
- `ktx/rustdesk-server`

**Production still never runs `latest`.**

## Pick the service

| Service | Build/deploy document |
|---|---|
| Base image | [01-base-image.md](01-base-image.md) |
| Per-site web runtime | [02-web-site.md](02-web-site.md) |
| Traefik | [03-proxy-traefik.md](03-proxy-traefik.md) |
| Restricted Docker API | [04-docker-api-proxy.md](04-docker-api-proxy.md) |
| SSHPiper | [05-sshpiper.md](05-sshpiper.md) |
| Percona | [06-percona.md](06-percona.md) |
| Postfix relay | [07-mail-postfix.md](07-mail-postfix.md) |
| Central rsyslog | [08-central-logging.md](08-central-logging.md) |
| Restic backup worker | [09-backup-restic.md](09-backup-restic.md) |
| Uptime Kuma | [10-uptime-kuma.md](10-uptime-kuma.md) |
| Vaultwarden | [11-vaultwarden.md](11-vaultwarden.md) |
| RustDesk Server OSS | [12-rustdesk.md](12-rustdesk.md) |

## Release variable used below

Examples use:

```bash
export KTX_RELEASE=2026.09.10-r2
```

Change it for the release you are actually building. Once exported/promoted, a release tag is immutable.

## Build environment

Unless a document explicitly says otherwise, **build images on `ktx-build-26`** and deploy only imported release artifacts on dev/prod.
