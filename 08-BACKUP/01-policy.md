# Backup Policy

> **Purpose:** Define what recoverable means.

Goals: recover one file, one DB, one whole site, shared application state, platform configuration/secrets, or the entire host.

Starting schedule:
- logical DB dumps nightly (more often for high-change sites if needed)
- restic snapshot nightly after dumps
- retention example: 7 daily, 5 weekly, 12 monthly; adjust for business/legal needs
- targeted restore test monthly
- broader DR rehearsal quarterly

Keep at least one **off-host** copy. `/srv/ktx/backups` on the same VPS is staging, not disaster recovery.

Backups must alert on failure.
