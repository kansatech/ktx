# Storage and Persistence

> **Purpose:** Make it obvious what survives container deletion.

## Site runtime image
Contains OS/runtime binaries and standard KTX configuration. No customer data or secrets.

## Site host mounts
Typical:
```text
/srv/ktx/sites/example/app        -> /var/www/html
/srv/ktx/sites/example/cron/...   -> /etc/cron.d/ktx-site
/srv/ktx/sites/example/ssh/...    -> site SSH state
/srv/ktx/secrets/sites/example    -> /run/ktx-secrets (read-only)
```

## Percona
Datadir under `/srv/ktx/data/percona-01`. Primary backup is logical per-database dumps, not casual live copies of the datadir.

## Traefik
Persist ACME state under `/srv/ktx/data/proxy-01/acme/`; protect it as private-key material.

## SSHPiper
Persist routing/auth state under `/srv/ktx/data/ssh-01/workingdir/`.

## Rule
If `docker rm` destroys something important, persistence is wrong.
