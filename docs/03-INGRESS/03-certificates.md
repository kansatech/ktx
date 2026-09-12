# TLS and Certificates

Traefik's `letsencrypt` certificate resolver owns normal public certificates.

## Persistent state

```text
/srv/ktx/data/traefik/acme.json
```

Permissions must remain 0600 and owned by the Traefik service account.

## HTTP-01

The baseline uses HTTP-01 on entrypoint `web` (TCP 80). Traefik documents HTTP-01 as compatible with HTTP-to-HTTPS redirection, so workloads do not need Certbot or a `/.well-known` exception.

## Build/dev

Use Let's Encrypt staging or non-public/self-signed/test domains while repeatedly iterating. Do not burn production ACME rate limits during development.

## Prod

Before enabling a new route, verify:

```bash
dig +short example.com
```

points to the correct public host and that 80/443 reach Traefik.

## Failure checklist

1. DNS correct?
2. provider firewall allows 80/443?
3. UFW allows 80/443?
4. Traefik running?
5. dynamic route valid?
6. backend reachable from host?
7. ACME log shows rate-limit/challenge error?

Sources:
- https://doc.traefik.io/traefik/reference/install-configuration/entrypoints/
- https://doc.traefik.io/traefik/v3.6/reference/install-configuration/tls/certificate-resolvers/acme/
