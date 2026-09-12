# Web Route Contract

Future template packs expose a web backend using `ktx-web-route`.

## Add

```bash
sudo ktx-web-route add \
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
sudo ktx-web-route show example
sudo journalctl -u traefik -n 100 --no-pager
curl -I http://example.com
curl -I https://example.com
```

HTTP should redirect to HTTPS.

## Remove

```bash
sudo ktx-web-route remove example
```

The helper removes only that route file. It does not touch DNS, container state, or certificates.

## Domain rules

The helper accepts normal DNS hostnames. Wildcard TLS (`*.example.com`) requires DNS-01 configuration and is **not** enabled by the default HTTP-01 Host Core setup; a template requiring wildcards must document a Host Core-compatible DNS-01 extension.

## Backend health

Traefik does not make a broken application healthy. Template packs should define their own backend health check and monitoring expectations.
