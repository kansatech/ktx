# KTX Container Platform Playbook

> **Purpose:** Index for building, operating, patching, restoring, and eventually remembering the KTX hosting platform.

This playbook describes **Ubuntu 24.04 LTS + Docker Engine** hosts named `ktx-build-26`, `ktx-dev-26`, and `ktx-prod-26`. The design uses **one isolated web container per site/customer**, plus a small group of shared infrastructure services.

Do not read this front-to-back unless insomnia has become a project requirement. Each file is deliberately a small island.

## Architecture in one screen

```text
                               INTERNET
                                  |
                    +-------------+-------------+
                    |                           |
                  80/443                       22
                    |                           |
              ktx-proxy-01                ktx-ssh-01
                Traefik                    SSHPiper
                    |                           |
          +---------+---------+                 |
          |                   |                 |
 ktx-web-sitea-01      ktx-web-siteb-01 <-------+
          |                   |
          +---------+---------+
                    |
       Percona / mail relay / central logging
       joined only to the site networks that need them
```

Each site web container contains Apache, PHP-FPM, Composer, cron, SSH, and log forwarding. It serves plain HTTP internally. Traefik owns public TLS and certificates.

## Find what you need

| I need to... | Read |
|---|---|
| Build a server from fresh Ubuntu | `01-HOST/01-fresh-install.md` |
| Understand build/dev/prod differences | `00-START/03-environments.md` |
| Understand Docker networking | `02-ARCHITECTURE/02-networking.md` |
| Build/deploy an individual container | `14-BUILD-DEPLOY/README.md` |
| Add a site after forgetting everything | `05-SITES/01-new-site.md` |
| Update PHP | `06-LIFECYCLE/04-update-php.md` |
| Promote build -> dev -> prod | `06-LIFECYCLE/01-build-dev-prod.md` |
| Roll back | `06-LIFECYCLE/08-rollback.md` |
| Restore one site | `08-BACKUP/05-restore-one-site.md` |
| Rebuild after total loss | `08-BACKUP/07-disaster-recovery.md` |
| Troubleshoot a dead site | `10-TROUBLESHOOTING/01-site-down.md` |
| Harden prod | `09-SECURITY/02-production-hardening.md` |
| Remember ports/paths/names | `12-REFERENCE/README.md` |

## Non-negotiable rules

1. **Build once; promote the exact artifact.** Prod never rebuilds an image that was tested elsewhere.
2. **Containers are disposable; data is not.** Persistent state lives under `/srv/ktx`.
3. **One site = one web container, one database, one DB user, one private site network.**
4. **No site container gets privileged mode, the Docker socket, another customer's files, or host root.**
5. **Only intended edge services publish production ports.**
6. **Restart is not upgrade.** A new image requires container recreation.
7. **Traefik owns certificates.** Site containers do not run Certbot.
8. **Backups are not trusted until a restore has succeeded.**
9. **Use immutable release tags; never `latest` on prod.**
10. **Keep the system boring enough to understand ten years later.**

## Current baseline (September 2026)

- Ubuntu 24.04 LTS
- Docker Engine from Docker's official APT repository
- Traefik 3.7 series (currently active + security supported)
- Percona Server for MySQL 8.4 LTS
- PHP 8.5 normal web runtime
- Apache event MPM + PHP-FPM `ondemand`
- SSHPiper working-directory routing
- Postfix internal relay
- rsyslog central collection
- restic encrypted backups
- Uptime Kuma monitoring
- Vaultwarden application service
- RustDesk Server OSS remote-support infrastructure

See `12-REFERENCE/upstream-sources.md` before any major platform upgrade.
