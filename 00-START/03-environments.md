# Build / Dev / Prod

> **Purpose:** Know which differences are intentional rather than configuration drift.

| Capability | Build | Dev | Prod |
|---|---|---|---|
| Build compilers/toolchains | Yes | Normally no | No |
| Production customer data | No | Sanitized only | Yes |
| Image builds | Yes | Only experiments/emergency | No |
| Xdebug/debug PHP | Optional | Optional | No |
| MySQL host mapping | Trusted/private if useful | Trusted/private e.g. 33601+ | Never |
| Public ACME | Staging/test | Staging/test domains | Production CA |
| External mail | Controlled | Restricted/safe | Approved relays |
| Customer SSH | Not needed | Test | SSHPiper |
| Backups | Source/releases | Useful | Required |

### Build special instructions
Build compiles/downloads/pins software and outputs immutable release bundles. It never contains production customer data or secrets.

### Dev special instructions
Dev imports the exact release from build. It tests representative WordPress/Symfony/PHP apps, proxy/TLS, DB, mail, SSH, cron, logs, and restore procedures. If dev rebuilds different bytes, the promotion model is broken.

### Prod special instructions
Prod never builds. It uses immutable image tags, no Xdebug, no database exposure, production backup/monitoring, and deploys shared runtime changes in small batches.
