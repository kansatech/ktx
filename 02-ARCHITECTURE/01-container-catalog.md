# Container Catalog

> **Purpose:** Define the baseline services and why each exists.

| Container | Required | Prod public ports | Job |
|---|---:|---|---|
| `ktx-proxy-01` | Yes | 80,443 | Traefik routing + TLS/ACME |
| `ktx-dockerapi-01` | Yes | none | restricted read-only Docker API for Traefik |
| `ktx-ssh-01` | If customer SSH | 22 | username-routed SSH gateway |
| `ktx-percona-01` | Yes for DB sites | none | shared Percona engine |
| `ktx-mail-01` | Recommended | none | internal outbound mail relay |
| `ktx-log-01` | Recommended | none | central syslog |
| `ktx-backup-01` | Prod required | none | dumps + restic |
| `ktx-uptime-01` | Recommended | via proxy if desired | availability checks |
| `ktx-vaultwarden-01` | Optional | via proxy | password vault |
| `ktx-rustdesk-01` | Optional | app-specific | remote support |
| `ktx-web-<slug>-01` | per site | none | Apache/PHP/cron/SSH site runtime |

Deliberately absent until actually needed: Redis, Adminer/phpMyAdmin, Kubernetes, private image registry, global application cron, SSO.
