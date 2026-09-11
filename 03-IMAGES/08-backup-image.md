# Backup Image

> **Purpose:** Run backups without privileged access or live datadir copies.

Contains restic, compatible MySQL dump/client tools, zstd, and minimal shell utilities.

No public ports. No privileged mode.

Read-only mounts: site files, selected shared-service state, platform definitions.
Read/write: backup staging/restore workspace and repository connectivity.

Database access uses a dedicated backup account. Normal DB backup is one logical dump per site database.

Platform-wide backups are invoked by a host systemd timer; per-site application schedules stay in site cron.
