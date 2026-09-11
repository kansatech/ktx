# Proxy / TLS / Certificate

> **Purpose:** Find routing and ACME failures without installing Certbot as a bandage.

Check in order: DNS -> public 80/443 -> Traefik running -> Docker API proxy -> site labels -> exact hostname rule -> correct `traefik.docker.network` -> proxy/site share site network -> backend 8080 -> ACME storage/logs/rate limits.

For wildcard certificates also verify DNS-01 API token/zone permissions.
