# Host Firewall

KTX uses two layers:

1. VPS/provider firewall as the outer policy;
2. UFW for native Ubuntu listeners.

Docker-published ports are a separate concern because Docker documents that published ports may bypass UFW rules. Normal KTX workload templates therefore do not publish public ports.

## Production inbound policy

Public internet:

```text
80/tcp   Traefik HTTP/ACME/redirect
443/tcp  Traefik HTTPS
22/tcp   SSHPiper, only if public workload SSH is enabled
```

Restricted administration:

```text
2222/tcp OpenSSH, trusted administrator source CIDRs only
```

Private Docker pool only:

```text
514/tcp  rsyslog receiver
```

## Configure UFW safely

**Before enabling UFW, add the admin SSH allow and verify provider console access.**

Example, replace `203.0.113.4/32`:

```bash
sudo ufw default deny incoming
sudo ufw default allow outgoing

sudo ufw allow from 203.0.113.4/32 to any port 2222 proto tcp
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
sudo ufw allow 22/tcp
sudo ufw allow from 172.28.0.0/16 to any port 514 proto tcp

sudo ufw enable
sudo ufw status verbose
```

Build/dev may omit public 22/80/443 or restrict them to trusted networks depending on their exposure.

## IPv6

If the host has public IPv6, UFW must be configured for IPv6 (`IPV6=yes` in `/etc/default/ufw`) and provider firewall rules must match. Do not publish AAAA records until you have verified the IPv6 policy and Traefik listener.

## Docker exception warning

A future template that runs `ports: - "0.0.0.0:1234:1234"` has stepped outside normal KTX ingress policy. Treat that as an explicit security exception and protect it at the provider firewall/DOCKER-USER chain as appropriate.

Source: https://docs.docker.com/engine/install/ubuntu/
