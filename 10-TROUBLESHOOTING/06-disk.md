# Disk or Inode Exhaustion

> **Purpose:** Find what is full before deleting random Docker objects.

```bash
df -h
df -i
docker system df
du -xh /srv/ktx --max-depth=2 | sort -h | tail -30
sudo du -xh /var/lib/docker --max-depth=1 | sort -h
```
Common: uploads, unrotated logs, DB growth, stale backup staging, old release bundles, build cache, abandoned restore workspaces.

Do not reflexively `docker system prune -a`; rollback images may be intentionally retained.
