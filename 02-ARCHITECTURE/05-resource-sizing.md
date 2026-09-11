# Resource Sizing on 6 GB

> **Purpose:** Keep twelve sites realistic without pretending containers are VMs.

Containers do not reserve a whole Ubuntu VM's RAM. The main variable is concurrent Apache/PHP/database workload.

Planning range for a 6 GB VPS:
- host + Docker: ~0.5-0.8 GB
- Percona: ~0.8-1.5 GB depending tuning/workload
- shared infra idle: ~0.4-0.8 GB
- 12 mostly idle web containers: roughly ~0.6-1.2 GB combined is a realistic starting expectation if PHP-FPM uses `ondemand`
- remaining memory is cache/headroom/request concurrency

These are sizing estimates, not promises. `docker stats` on dev decides reality.

## Default site ceiling
Start around:
```yaml
mem_limit: 384m
mem_reservation: 64m
pids_limit: 256
```
Tiny sites may prove safe at 256 MB; busy/image-processing sites may need 512-768 MB.

## PHP-FPM
Starting pool:
```text
pm = ondemand
pm.max_children = 4
pm.process_idle_timeout = 10s
pm.max_requests = 500
```
Remember PHP `memory_limit` is per request/process, not per container.

## Percona
On this host class, start with an InnoDB buffer pool around 768 MB-1 GB, sensible connection limits, then tune from actual workload.

## Swap
A small 2 GB swap file is useful emergency cushioning, not working memory.
