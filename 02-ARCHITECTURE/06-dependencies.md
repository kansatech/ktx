# Service Dependencies

> **Purpose:** Avoid unnecessary startup coupling.

A site should start even if DB/mail is temporarily unavailable. Its app may error until dependencies recover, but entrypoint scripts should not wait forever for a perfect universe.

Normal restart policy on prod: `unless-stopped`.

Health checks test the service itself:
- site: local Apache `/__ktx/health`
- proxy: Traefik ping
- DB: authenticated simple query/ping
- backup: age/status of last successful backup, not merely PID existence

After normal host reboot, site containers should start in seconds regardless of site data size. Site **restore** time scales with data size; normal container startup does not copy all site data.
