# Host Patching and Reboots

> **Purpose:** Patch Ubuntu/Docker-host components without confusing them with container image updates.

Normal cycle:
```bash
sudo apt update
apt list --upgradable
sudo apt upgrade
```

Before prod reboot:
- recent backup confirmed
- no restore/migration running
- Percona healthy
- restart policies correct
- provider console/recovery access known

Reboot, then verify in this order:
1. host SSH
2. Docker
3. Percona
4. Docker API proxy
5. Traefik
6. SSHPiper
7. mail/log
8. sites
9. public URLs
10. backup/monitoring

After recreating shared infrastructure containers, run network reconciliation.
