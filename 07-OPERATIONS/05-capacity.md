# Capacity and Performance

> **Purpose:** Know when the 6 GB VPS truly needs to grow.

Watch:
```bash
free -h
vmstat 1 10
df -h
docker stats
docker system df
```

Per-site: peak memory, OOM, PHP worker saturation, latency, concurrency.
Database: connections, slow queries, disk latency, buffer-pool effectiveness, size.

Signs to add RAM/capacity:
- sustained swap activity
- repeated legitimate OOM kills
- Percona cannot retain useful cache
- normal-load PHP queues
- no safe headroom during backup/maintenance
- sustained IO wait/load

If twelve useful sites genuinely need more than 6 GB, buying RAM is usually safer than collapsing the isolation model to save a few daemon processes.
