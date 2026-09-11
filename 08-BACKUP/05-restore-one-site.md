# Restore One Site

> **Purpose:** Recover one customer without disturbing everyone else.

1. Identify desired snapshot, DB dump, and historical runtime image if relevant.
2. Preserve current state unless known-hostile: fresh dump/snapshot + image tag.
3. Stop or maintenance-mode site to prevent writes.
4. Restore files to `/srv/ktx/backups/restore-work/<slug>` first.
5. Validate ownership/content/security.
6. If DB restore needed, preserve current DB, recreate/import chosen schema dump, verify grants.
7. Swap staged files into place atomically where practical.
8. Ensure site runtime image is compatible with restored app.
9. Recreate/start container.
10. Verify health, app, DB read/write, uploads, mail, cron, SSH, logs, public TLS.
11. Retain pre-restore state through a confidence period.
