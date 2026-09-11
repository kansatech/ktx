# Network Isolation

> **Purpose:** Prevent a compromised site from directly reaching other customer sites.

Each customer web container belongs only to its `ktx-site-<slug>` network. Shared infrastructure is attached only when required.

Inspect:
```bash
docker network inspect ktx-site-clienta
```
Expected might be clienta web + proxy + log + DB/mail/SSH as enabled. Another customer's web container, Vaultwarden, or Docker API proxy is unexpected and should be removed.
