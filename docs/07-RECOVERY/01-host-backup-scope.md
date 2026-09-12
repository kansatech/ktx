# Host Core Backup Scope

GitHub contains the portable Host Core source. A host backup therefore focuses on what Git deliberately does not contain.

Back up:

```text
/srv/ktx/config/
/srv/ktx/secrets/
/srv/ktx/containers/
/srv/ktx/data/                 selected native/workload state according to module docs
/srv/ktx/releases/             retained approved artifacts if not stored elsewhere
/etc/ssh/sshd_config.d/10-ktx-admin.conf
```

Optionally retain:

```text
/srv/ktx/logs/
```

according to log-retention policy.

You do **not** need to back up the `Kansatech/ktx` Git history as the only recovery source if GitHub is authoritative, but keeping an off-host mirror/export is prudent.

Module/workload repositories and their persistent data follow their own backup documents.
