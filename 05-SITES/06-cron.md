# Site Cron

> **Purpose:** Keep application schedules with the site that owns them.

Each site owns `/srv/ktx/sites/<slug>/cron/ktx-site`, mounted read-only into `/etc/cron.d/ktx-site`.

`/etc/cron.d` format includes the user:
```text
*/5 * * * * site cd /var/www/html && /usr/bin/php bin/console app:task
```

Use absolute paths, locking for non-overlap jobs, and deliberate output/logging. Server baseline timezone is UTC.

Backups/host patching are platform schedules and do not belong in customer cron.
