# File Backups

> **Purpose:** Back up persistent state, not caches and Docker internals.

Include:
- `/srv/ktx/sites`
- `/srv/ktx/platform`
- relevant shared app data under `/srv/ktx/data`
- database dump staging
- site/infrastructure manifests
- optionally `/srv/ktx/secrets` inside the encrypted repository

Exclude or deliberately limit:
- caches/temp
- restore workspace
- Docker `/var/lib/docker`
- normal live Percona datadir from file snapshots
- logs beyond retention policy

Release bundles/build definitions replace the need to back up Docker's own image store.
