# Update Docker Engine

> **Purpose:** Upgrade the host runtime separately from application images.

1. Review target Docker release/package change.
2. Patch build host first and verify builds/Compose/networks.
3. Patch dev and test representative stack.
4. Schedule prod; verify backups/console access.
5. Update Docker packages/reboot if required.
6. Verify networks and containers.
7. Run network reconciliation if shared containers were recreated.
8. Test public routes, SSH, DB, mail.

Do not combine a Docker Engine upgrade with a PHP/database major upgrade.
