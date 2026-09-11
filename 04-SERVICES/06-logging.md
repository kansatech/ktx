# Central Logging Operation

> **Purpose:** Keep enough evidence to debug and investigate incidents.

Every forwarded log should preserve environment, site/container, process, and timestamp.

Suggested storage:
```text
/srv/ktx/logs/example/apache-access.log
/srv/ktx/logs/example/apache-error.log
/srv/ktx/logs/example/php.log
/srv/ktx/logs/example/auth.log
/srv/ktx/logs/example/cron.log
```

Start with 14-30 days local retention depending on volume, compressed rotations, and tighter/longer retention only if required.

Logs may contain IPs, usernames, request paths and application context; keep them non-public and access-controlled.
