# Internal Networking

> **Purpose:** Keep customer sites separated while still reaching shared infrastructure.

## Control plane
`ktx-control` contains only `ktx-proxy-01` and `ktx-dockerapi-01`.

## Management
`ktx-management` contains infrastructure-only traffic such as backup -> Percona. No site web container belongs here.

## Per-site network
Each site receives `ktx-site-<slug>`.

A normal site network contains:
- its one `ktx-web-<slug>-01`
- `ktx-proxy-01`
- `ktx-percona-01` if DB is required
- `ktx-mail-01` if mail is required
- `ktx-log-01`
- `ktx-ssh-01` only if SSH is enabled

No other customer's web container belongs there.

## Why shared services join many networks
This lets the proxy/database/mail/log/SSH services reach a site without putting all sites on one flat network. At dozens rather than thousands of sites, the extra Docker interfaces are an acceptable operational tradeoff for clearer lateral isolation.

## DNS
Containers use names, not fixed IPs. Inside a site network, `ktx-percona-01`, `ktx-mail-01`, etc. resolve through Docker DNS.

## Outbound internet
Site bridges are not created with `--internal`, because normal web apps need outbound HTTPS/API/package access. Limit outbound later only with an explicit egress design.

## Network lifecycle
When a **shared infrastructure container is recreated**, manual `docker network connect` attachments disappear with the old container. Run the network reconciliation script afterward. Site network definitions themselves remain.
