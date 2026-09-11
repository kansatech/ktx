# Network Reference

| Pattern | Purpose |
|---|---|
| `ktx-control` | Traefik <-> restricted Docker API |
| `ktx-management` | backup/infrastructure management |
| `ktx-site-<slug>` | isolated customer site + required shared endpoints |
| `ktx-app-<slug>` | isolated platform app (for example Uptime Kuma/Vaultwarden) + selected shared endpoints |

Site/app network labels drive reconciliation: `ktx.proxy`, `ktx.database`, `ktx.mail`, `ktx.logging`, `ktx.ssh`.

A site web container belongs to its own `ktx-site-<slug>` network and not to another site's network.
