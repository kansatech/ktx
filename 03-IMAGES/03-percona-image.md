# Percona Image

> **Purpose:** Keep the database runtime reproducible and conservative.

Baseline: **Percona Server for MySQL 8.4 LTS** from Percona's official APT repository on Ubuntu 24.04.

Persistent datadir: `/srv/ktx/data/percona-01`.

Production publishes no database port. Percona joins management and only those site networks requiring DB access.

Each site gets a unique database and least-privileged user with grants only on its schema.

Tune for a 6 GB shared host, not a 64 GB dedicated database machine.

Minor/security updates follow build -> dev -> prod. A major database upgrade is its own project with restore rehearsal and compatibility testing.
