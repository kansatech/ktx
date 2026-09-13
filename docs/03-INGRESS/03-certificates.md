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

Before adding test routes, set `certificatesResolvers.letsencrypt.acme.caServer` in the ignored Traefik static configuration to `https://acme-staging-v02.api.letsencrypt.org/directory` and restart Traefik. Staging certificates are deliberately untrusted by browsers. Use a separate staging storage file (for example `/srv/ktx/data/traefik/acme-staging.json`, owned by traefik, mode 0600) so production ACME state is preserved. The default installer uses the production ACME directory; a reserved example hostname cannot receive a public certificate.

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
