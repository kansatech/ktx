# Changelog

## 2026-09-10 - Revision 2
- Added `14-BUILD-DEPLOY/` with hands-on build, configuration, deployment, verification, and update commands for every baseline container.
- Added dedicated Vaultwarden, Uptime Kuma, RustDesk, and restic operational documentation.
- Added KTX image/Compose templates for Traefik, restricted Docker API, SSHPiper, Percona, Postfix, rsyslog, restic, Uptime Kuma, and RustDesk.
- Expanded quick lookup and container reference to point directly to service deployment instructions.
- Updated current pinned examples from September 2026 upstream releases.

## 2026.09.10-r2 operational completion
- Added `14-BUILD-DEPLOY/` with command-level build/deploy instructions for every baseline service.
- Added KTX Dockerfiles/Compose templates for proxy, Docker API proxy, SSHPiper, Percona, Postfix, rsyslog, restic, Uptime Kuma, and RustDesk.
- Added pinned Vaultwarden source-build/deploy workflow.
- Added label-aware app/site network reconciliation.
- Extended backup worker to logical Percona dumps and consistent SQLite appliance backups.
- Added Uptime Kuma, Vaultwarden, RustDesk, and restic operations coverage.
