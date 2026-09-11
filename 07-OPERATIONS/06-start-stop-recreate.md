# Start / Stop / Restart / Recreate

> **Purpose:** Use the operation that actually matches the task.

Start existing stopped container:
```bash
docker start NAME
```
Restart same container/image:
```bash
docker restart NAME
```
Recreate from configured image:
```bash
docker compose up -d --force-recreate
```

Changing a Docker image on disk does not mutate an already-created container. **Upgrade means recreate.**

Be careful with `docker compose down -v`; named volumes may contain persistent data.
