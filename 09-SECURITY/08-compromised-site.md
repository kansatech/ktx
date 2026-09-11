# Compromised Site

> **Purpose:** Handle the common one-site compromise case.

1. Stop site.
2. Disable SSHPiper route/key if relevant.
3. Disable site's mail relay identity.
4. Preserve logs/files/current image metadata.
5. Dump DB if useful/safe.
6. Verify no unexpected cross-site network membership.
7. Rotate site DB/app/mail/API credentials exposed to the site.
8. Obtain known-good source/backup and patch vulnerable component.
9. Recreate from trusted KTX image.
10. Restore/clean application data and inspect writable uploads.
11. Test, reopen, monitor.

Because site containers are isolated, do not automatically declare every customer compromised; widen scope based on actual escape/shared-credential evidence.
