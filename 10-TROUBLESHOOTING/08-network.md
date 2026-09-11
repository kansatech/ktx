# Docker Network Problems

> **Purpose:** Repair connectivity without flattening isolation.

```bash
docker network inspect ktx-site-example
```
Check site + only required shared members.

If shared containers were recreated, run:
```bash
/srv/ktx/platform/templates/scripts/ktx-network-reconcile.sh
```

Docker DNS only resolves service names when containers share a network. If `ktx-percona-01` does not resolve, it probably is not attached to that site network.

Do not “fix” this by attaching every customer to one giant bridge.
