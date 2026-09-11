# Daily Checks

> **Purpose:** Catch obvious failures quickly.

Review or alert on:
- backup success
- filesystems/inodes >80%
- stopped/restarting containers
- OOM kills
- Percona health
- unexpected mail queue growth
- proxy health
- persistent monitor failures
- host reboot-required/security state

Quick commands:
```bash
docker ps
docker ps -a --filter status=exited
docker stats --no-stream
df -h
df -i
free -h
```
