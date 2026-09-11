# Retire a Site

> **Purpose:** Remove a customer without leaving ambiguous state behind.

1. Confirm authorization/retention.
2. Final files backup + DB dump + manifest/image record.
3. Stop site.
4. Disable SSHPiper route.
5. Remove/transition DNS and proxy routing.
6. Revoke mail credential.
7. Revoke DB user; drop DB only when retention allows.
8. Archive/delete site files and secrets per policy.
9. Remove site network and container definition.
10. Remove monitoring.
11. Record backup expiry date.

`docker rm` is not an offboarding plan.
