# Common Host Commands

## KTX

```bash
ktx-host-check
ktx-net list
ktx-net show NAME
ktx-web-route list
ktx-web-route show NAME
ktx-ssh-route list
ktx-ssh-route show LOGIN
```

## Services

```bash
systemctl status traefik sshpiper ssh docker rsyslog --no-pager
journalctl -u traefik -n 100 --no-pager
journalctl -u sshpiper -n 100 --no-pager
```

## Network/listeners

```bash
ss -lntup
ip route
docker network ls
docker network inspect NETWORK
```

## Docker

```bash
docker ps
docker ps -a
docker stats
docker system df
```

## Firewall

```bash
ufw status verbose
```
