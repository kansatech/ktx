# Disk, Memory, and OOM

```bash
df -h
df -i
free -h
vmstat 1 10
dmesg -T | grep -i -E 'oom|killed process'
docker stats --no-stream
docker system df
du -xh /srv/ktx --max-depth=2 | sort -h | tail -30
```

Common host growth:

- workload persistent data;
- remote logs;
- Docker images/build cache;
- retained Host Core releases;
- temporary recovery directories.

Do not delete unknown Docker volumes/images during an outage simply to make `df` look happier. Identify ownership first.
