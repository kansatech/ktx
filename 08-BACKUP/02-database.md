# Database Backups

> **Purpose:** Produce one easily restorable dump per site.

Use a dedicated backup account and a compatible MySQL/Percona client.

Concept:
```bash
mysqldump --single-transaction --routines --triggers --events --hex-blob   --databases example_app | zstd -T0 > /backup-staging/databases/example_app.sql.zst
```
Verify exact options against the pinned database/client version.

One file per database is intentional: restoring client A should not require extracting a 40-database monolith.

Record database, UTC timestamp, server/client version, compressed size, checksum.

A successful dump command is not proof of recovery. Periodically import one into dev and run the application.
