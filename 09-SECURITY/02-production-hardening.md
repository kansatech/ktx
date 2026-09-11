# Production Hardening

> **Purpose:** Apply the restrictive rules unique to public production.

Network: public only 80/443, optional 22 gateway, restricted admin SSH. Never public MySQL, Docker API, site Apache/sshd, internal SMTP/syslog/backup.

Host: key-only SSH, no root login, minimal sudo, provider firewall, security updates, time sync, off-host backup.

Docker: no privileged sites, no Docker socket, no host-root mounts, memory/PID limits, explicit networks, immutable tags, Traefik `exposedByDefault=false`, restricted Docker API proxy.

PHP: no Xdebug/display_errors; OPcache on; sensible upload/time/memory limits.

Site SSH: public key only, no sudo/root.

Secrets: unique DB passwords, protected host paths, rotate on compromise.
