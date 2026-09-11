# Full Disaster Recovery

> **Purpose:** Rebuild production from a blank host.

Required: Ubuntu install access, playbook/platform source, release bundles or reproducible builds, off-host restic repo + password, DNS/provider access, production secrets, admin SSH key.

Sequence:
1. fresh Ubuntu 24.04
2. hostname/network/SSH/Docker
3. `/srv/ktx` layout
4. restore platform definitions + secrets
5. load last known-good KTX release
6. create base networks
7. start clean Percona and import DB dumps
8. restore site files/shared app state
9. recreate per-site networks with labels
10. start shared infrastructure
11. run network reconciliation
12. start sites
13. restore SSHPiper routing/keys
14. restore Traefik ACME state or reissue where appropriate
15. validate mail/monitoring/backup
16. cut/verify DNS/IP
17. run acceptance checks
18. verify next backup succeeds

Priority: host/Docker -> DB -> proxy -> required sites -> SSH/mail/log -> backup/monitoring -> optional utilities.

A disaster plan never tested on a blank VM is creative writing. Rehearse it.
