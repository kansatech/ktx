# ktx-prod-26

> **Purpose:** Internet-facing production rules.

Public: proxy 80/443; optional customer SSH 22; restricted host admin path.

Never public: MySQL, Docker API proxy, site Apache/sshd, internal SMTP, syslog, backup.

No Xdebug, no `display_errors`, no image builds, no ad-hoc package installation as permanent fixes. Immutable image tags, resource limits, backups, monitoring, production ACME.
