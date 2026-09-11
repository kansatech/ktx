# Traefik Operation

> **Purpose:** Run dynamic HTTP routing and certificate automation.

Static config owns entrypoints 80/443, global redirect, Docker provider, ACME, logging, and optional authenticated dashboard.

Per-site routing comes from labels on the site container. Example concepts:
```yaml
labels:
  traefik.enable: "true"
  traefik.http.routers.example.rule: "Host(`example.com`) || Host(`www.example.com`)"
  traefik.http.routers.example.entrypoints: "websecure"
  traefik.http.routers.example.tls: "true"
  traefik.http.routers.example.tls.certresolver: "letsencrypt"
  traefik.http.services.example.loadbalancer.server.port: "8080"
  traefik.docker.network: "ktx-site-example"
```

Starting/removing a labeled container changes routing dynamically; no giant central vhost file or proxy restart should be needed.

Use Let's Encrypt staging on build/dev while iterating. Production uses the real CA only after DNS and routing are correct.

No Certbot lives in site containers. The old `/.well-known` Apache exception disappears because the edge proxy owns ACME.
