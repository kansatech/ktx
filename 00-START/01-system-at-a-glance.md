# System at a Glance

> **Purpose:** Understand the platform without implementation detail.

## Hosts

- `ktx-build-26`: builds trusted KTX images and release bundles. No production data or secrets.
- `ktx-dev-26`: imports the exact build artifacts and proves them with realistic applications.
- `ktx-prod-26`: public live host. Consumes only previously tested artifacts.

## Infrastructure containers

- `ktx-proxy-01` — Traefik HTTP/HTTPS edge
- `ktx-dockerapi-01` — restricted Docker API used only for proxy discovery
- `ktx-ssh-01` — SSHPiper customer SSH gateway
- `ktx-percona-01` — shared database engine with per-site databases/users
- `ktx-mail-01` — internal outbound SMTP relay
- `ktx-log-01` — central syslog receiver
- `ktx-backup-01` — database dumps + restic
- `ktx-uptime-01` — uptime checks
- `ktx-vaultwarden-01` — optional platform vault
- `ktx-rustdesk-01` — optional remote-support service

## Site containers

`ktx-web-<slug>-01` contains the complete per-site runtime:

- Apache on internal TCP 8080
- PHP-FPM through a Unix socket
- PHP CLI + Composer
- cron
- sshd on internal TCP 2222
- rsyslog forwarding
- `/var/www/html` as the site root

## Disposable vs persistent

Disposable: container writable layers, caches, temp data, runtime PID files.

Persistent: site app/uploads, DB data/dumps, SSH host keys, customer keys, Traefik ACME state, secrets, Vaultwarden state, site manifests, platform release bundles.
