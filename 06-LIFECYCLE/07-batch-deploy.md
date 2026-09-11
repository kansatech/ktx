# Batch Deployment

> **Purpose:** Avoid turning a routine runtime update into one giant outage.

For ~12 sites, update progressively: one low-risk site, then two or three, then remaining groups. For each group recreate, wait for health, test public URL, inspect logs/OOM, continue.

Container recreation should take seconds. Data size affects restore/migration/import time, not normal startup from existing bind mounts.
