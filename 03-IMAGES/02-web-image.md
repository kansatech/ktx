# Standard Web Image

> **Purpose:** Define the per-site mini-server runtime.

Contents:
- Ubuntu 24.04 base
- Apache event MPM
- PHP 8.5 FPM + CLI
- Composer
- common extensions
- cron
- OpenSSH server
- rsyslog
- Supervisor (intentional multi-process site-server container)

Internal listeners:
- Apache 8080
- sshd 2222
- PHP-FPM Unix socket

Default document root: `/var/www/html`. Symfony sites may use a small site override for `/var/www/html/public`; do not invent a whole vhost architecture for it.

Use PHP-FPM `ondemand` to keep idle sites small.

PHP 8.5 is not Ubuntu 24.04's stock PHP stream; if using Ondřej Surý's Ubuntu PHP packages, treat that PPA as an explicit third-party supply-chain dependency and test/pin updates through build/dev/prod.

Standard extension set should cover common WordPress/Symfony/GLPI-style needs: curl, mbstring, xml, intl, mysql, gd, zip, bcmath, soap, opcache. Add unusual extensions to a specialized image unless they become common.
