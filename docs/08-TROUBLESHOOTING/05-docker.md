# Docker Host Problems

```bash
systemctl status docker --no-pager
journalctl -u docker -n 200 --no-pager
docker info
docker ps -a
docker network ls
```

Validate daemon config:

```bash
sudo dockerd --validate --config-file=/etc/docker/daemon.json
```

If Docker is down, native administrator SSH still works. Native Traefik/SSHPiper may still listen publicly but backends will be unavailable; their errors should clearly show connection failures to private IPs.

After Docker recovery, verify workload networks still have their expected subnets and addresses before assuming all ingress failures are application failures.
