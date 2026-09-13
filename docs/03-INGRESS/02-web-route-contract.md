# Web Route Contract

Future modules expose a web backend using `/srv/ktx/bin/web-route`.

## Add

```bash
sudo /srv/ktx/bin/web-route add \
  example \
  172.28.4.2 \
  8080 \
  example.com www.example.com
```

This writes one atomic file:

```text
/srv/ktx/config/traefik/dynamic/50-example.yml
```

Traefik sees it automatically.

## Verify

```bash
sudo /srv/ktx/bin/web-route show example
sudo journalctl -u traefik -n 100 --no-pager
curl -I http://example.com
curl -I https://example.com
```

HTTP should redirect to HTTPS.

## Remove

```bash
sudo /srv/ktx/bin/web-route remove example
```

The helper removes only that route file. It does not touch DNS, container state, or certificates.

## Domain rules

The helper accepts normal DNS hostnames. Wildcard TLS (`*.example.com`) requires DNS-01 configuration and is **not** enabled by the default HTTP-01 Host Core setup; a template requiring wildcards must document a Host Core-compatible DNS-01 extension.

## Backend health

Traefik does not make a broken application healthy. Modules should define their own backend health check and monitoring expectations.
