# Architecture Decisions

> **Purpose:** Remember why the system looks like this before future-you “simplifies” it.

## One web container per site
Chosen for filesystem/runtime isolation, simple restores, site-owned cron, simple Apache roots, and legacy runtime separation.

## Apache + PHP-FPM together
The unit of isolation is the site server. Splitting PHP adds coordination with little benefit at this scale.

## Traefik owns TLS
One public IP has one 80/443 edge. Traefik discovers labeled containers and owns ACME. Site Apache remains plain HTTP.

## SSHPiper owns customer SSH
SSH cannot route by HTTP hostname. Username routing gives one public TCP 22 while site sshd ports remain private.

## Host admin SSH is separate
Recommended: host sshd on a separate restricted port/private path so a broken SSH gateway cannot lock out infrastructure administration.

## Per-site networks
A compromised customer should not share a flat network with all other sites.

## Percona 8.4 LTS
Chosen as compatibility-first MySQL-family baseline.

## Logical DB dumps + restic
Optimized for easy single-site recovery. Physical backup tooling can be added if database size/RTO later justifies it.
