# Central Log Image

> **Purpose:** Collect useful logs without deploying a resource-heavy indexing stack.

Use rsyslog as the baseline receiver.

Collect at least:
- Apache access/error
- PHP-FPM errors
- auth/sshd
- cron
- application syslog where available

Store by site/service under `/srv/ktx/logs` and rotate/compress aggressively enough that logs cannot fill the VPS.

Keep Docker's `local` logging driver too; it keeps `docker logs` useful and bounded. Central logging and Docker stdout/stderr logging solve different operational problems.

For ~12 sites, grep/zgrep/journalctl are often enough. Add Graylog/ELK only when searching flat logs becomes a real pain worth the RAM.
