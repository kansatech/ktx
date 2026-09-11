# DNS and TLS Onboarding

> **Purpose:** Add domains without hand-managing certificates.

1. Make Traefik labels contain every accepted hostname.
2. Point A/AAAA records to the proxy IP.
3. Verify public DNS.
4. Ensure public 80/443 reach Traefik.
5. Traefik obtains certificate and redirects HTTP -> HTTPS.

No site-level `/.well-known` exception is required when Traefik owns ACME.

Wildcard `*.example.com` requires DNS-01 and a scoped DNS API credential.

When retiring a domain, remove routing and DNS; abandoned DNS pointing at your edge is operational/security clutter.
