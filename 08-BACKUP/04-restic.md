# Restic Operations

> **Purpose:** Run encrypted deduplicated snapshots and validate them.

Backup concept:
```bash
restic backup --tag ktx-prod /source/sites /source/platform /source/data-selected /backup-staging/databases
```
List:
```bash
restic snapshots
```
Retention example:
```bash
restic forget --keep-daily 7 --keep-weekly 5 --keep-monthly 12 --prune
```
Repository check:
```bash
restic check
```
Restore to staging first:
```bash
restic restore SNAPSHOT --target /restore-work
```

Restic encrypts repositories, but the repository password must be preserved separately/offline.
