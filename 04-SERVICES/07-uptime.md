# Uptime Kuma Monitoring

> **Purpose:** Detect outages without confusing uptime with full observability.

`ktx-uptime-01` runs Uptime Kuma. Build/install/configure it using:

- `14-BUILD-DEPLOY/10-uptime-kuma.md`

For each public site monitor the real HTTPS URL, expected response, certificate validity, and optionally a known keyword. This tests DNS + TLS + proxy + backend rather than localhost only.

Also monitor:

- proxy health
- age/status of last backup
- host disk/memory thresholds
- unexpected mail queue growth if practical

Use retries/grace periods so one dropped packet at 3:12 AM does not become DEFCON 1.
