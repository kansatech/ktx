# Per-Site Layout

> **Purpose:** Know exactly where one customer's pieces live.

Host:
```text
/srv/ktx/sites/example/
  manifest.yml
  app/
  cron/ktx-site
  ssh/hostkeys/
  config/
  restore/
```
Secrets: `/srv/ktx/secrets/sites/example/`.

Container:
```text
/var/www/html
/etc/cron.d/ktx-site
/home/site/.ssh
/run/ktx-secrets
```
Internal services: Apache 8080, sshd 2222, PHP-FPM Unix socket, cron, rsyslog.
No host ports are published by the site container.
