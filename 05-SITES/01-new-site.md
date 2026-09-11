# Add a New Site

> **Purpose:** The ten-years-later procedure for creating a customer environment.

Example slug: `example`.

## 1. Gather inputs
Primary domain/aliases, site type, PHP/runtime image, database yes/no, SSH yes/no, mail yes/no, cron, memory limit, customer SSH keys, DNS owner.

## 2. Paths
```bash
sudo mkdir -p /srv/ktx/sites/example/{app,cron,ssh/hostkeys,config,restore}
sudo mkdir -p /srv/ktx/secrets/sites/example
sudo chmod 0700 /srv/ktx/secrets/sites/example
```

## 3. Manifest
Copy `templates/site/manifest.yml.example` to `/srv/ktx/sites/example/manifest.yml` and fill it out.

## 4. Network
```bash
docker network create ktx-site-example
```
Attach only needed shared services (proxy always; log normally; DB/mail/SSH only when used).

## 5. Database
Create `example_app` + unique `example_app` credentials if required. Store password only in site secrets.

## 6. Deploy files
Place/restore application in `/srv/ktx/sites/example/app` and set ownership according to your site UID/GID convention.

## 7. Cron
Create `cron/ktx-site` even if initially empty/comment-only.

## 8. SSH
If enabled, generate/persist site ssh host keys; create SSHPiper route and strict known_hosts entry; install customer downstream public key.

## 9. Compose
Copy site template to `/srv/ktx/containers/ktx-web-example-01/compose.yml`; fill image tag, paths, memory limits, labels/network.

## 10. DNS
Point domains to production proxy after route/backend is ready, or use test DNS/hosts first.

## 11. Start
```bash
cd /srv/ktx/containers/ktx-web-example-01
docker compose up -d
```

## 12. Verify
Container health, HTTPS/redirect, app, DB, mail, SSH/SFTP, cron syntax, central logs.

## 13. Backup proof
Confirm files + DB dump enter backup, then perform at least a small onboarding restore verification.
