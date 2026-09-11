# Weekly Checks

> **Purpose:** Look for drift and growth before they become incidents.

- inspect disk growth under sites/data/logs
- review top memory consumers
- review mail rejections/queue
- review repeated SSH failures
- review Docker image/build-cache usage
- confirm new backup snapshots exist
- review repeated cron/app errors

Useful:
```bash
docker system df
du -xh /srv/ktx --max-depth=2 | sort -h | tail -30
```
Do not run `docker system prune -a` as a weekly ritual; retained images are part of rollback capability.
