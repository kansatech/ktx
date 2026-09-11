# Host Firewall and Exposure

> **Purpose:** Define what the world can actually reach.

## Production inbound
- TCP 80 -> Traefik
- TCP 443 -> Traefik
- TCP 22 -> SSHPiper, if customer SSH is offered
- TCP 2222 (example) -> host sshd **only from trusted admin sources/private management**

Everything else denied unless explicitly documented.

## Production database
No host mapping. Site containers use `ktx-percona-01:3306` over private site networks.

## Build/dev database access
If needed:
```yaml
ports:
  - "192.168.40.168:33601:3306"
```
Bind to a private/trusted host IP and firewall it to trusted clients. Containers still use internal 3306.

## Verify exposure
```bash
sudo ss -lntup
docker ps --format 'table {{.Names}}	{{.Ports}}'
```
Any unexpected prod published port is a problem to explain, not scenery.
