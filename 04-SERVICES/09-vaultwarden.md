# Vaultwarden

> **Purpose:** Isolate the password-management application from customer hosting while still operating it as part of the KTX platform.

`ktx-vaultwarden-01` has its own persistent data directory and application network. It is reverse-proxied through Traefik and is not attached to customer site networks.

Hands-on build/deploy instructions:

- `14-BUILD-DEPLOY/11-vaultwarden.md`

Back up its persistent data and treat its administrator token/data as high-value secrets.
