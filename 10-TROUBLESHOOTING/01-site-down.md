# Site Down

> **Purpose:** Diagnose an outage in the fastest useful order.

1. DNS: `dig +short example.com`
2. Public request: `curl -vkI https://example.com/`
3. Traefik route/provider logs
4. Site container state/logs
5. `docker network inspect ktx-site-example`
6. Internal `/__ktx/health`
7. Apache/PHP/application logs
8. DB connectivity
9. memory/disk/inodes/OOM

Do not debug Symfony for forty minutes when DNS still points at the old VPS.
