# Memory / OOM

> **Purpose:** Diagnose pressure before simply raising every limit.

```bash
free -h
vmstat 1 10
dmesg -T | grep -i -E 'oom|killed process'
docker stats --no-stream
docker inspect NAME --format '{{.State.OOMKilled}}'
```
Check PHP-FPM child count, PHP memory_limit, Apache workers, image/import jobs, runaway cron, plugin loops, Percona buffer/connection pressure.

Fix order: runaway workload -> concurrency/tuning -> app optimization -> site limit -> more host RAM if workload is legitimately larger.
