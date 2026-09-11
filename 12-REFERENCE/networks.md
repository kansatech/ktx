# Network Reference
- `ktx-control` — Traefik <-> restricted Docker API
- `ktx-management` — infrastructure management/backup DB access
- `ktx-site-<slug>` — one site's web container + only required shared endpoints

Per-site network labels drive reconciliation: `ktx.proxy`, `ktx.database`, `ktx.mail`, `ktx.logging`, `ktx.ssh`.
