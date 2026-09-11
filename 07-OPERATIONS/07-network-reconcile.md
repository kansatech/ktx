# Network Reconciliation

> **Purpose:** Restore shared-service attachments after infrastructure recreation.

Manual `docker network connect` memberships belong to a container instance. Recreating `ktx-proxy-01`, `ktx-percona-01`, `ktx-mail-01`, `ktx-log-01`, or `ktx-ssh-01` can remove its extra per-site attachments.

Run:
```bash
sudo /srv/ktx/platform/templates/scripts/ktx-network-reconcile.sh
```

The script reads **labels on each `ktx-site-*` or `ktx-app-*` network** to determine which shared services belong there. It does not blindly attach every service to every site.

Network labels used by the templates:
```text
ktx.proxy=true
ktx.database=true|false
ktx.mail=true|false
ktx.logging=true|false
ktx.ssh=true|false
```

After reconciliation, inspect a representative network:
```bash
docker network inspect ktx-site-example
```
