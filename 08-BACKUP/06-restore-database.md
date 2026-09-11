# Restore One Database

> **Purpose:** Recover a database while minimizing collateral damage.

1. Stop writes/maintenance mode.
2. Dump current DB unless unsafe/malicious.
3. If uncertain, import backup to temporary dev schema first.
4. Decompress/import selected dump.
5. Verify tables/migrations/application expectations.
6. Restore production schema/grants.
7. Start site and test reads/writes.
8. Review logs.

Do not pair a DB dump with an arbitrary application version and hope migrations sort themselves out.
