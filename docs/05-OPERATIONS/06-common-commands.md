# Common Host Commands

## KTX

```bash
sudo /srv/ktx/bin/host-check
sudo /srv/ktx/bin/net list
sudo /srv/ktx/bin/net show NAME
sudo /srv/ktx/bin/web-route list
sudo /srv/ktx/bin/web-route show NAME
sudo /srv/ktx/bin/ssh-route list
sudo /srv/ktx/bin/ssh-route show LOGIN
```

## Services

```bash
systemctl status traefik sshpiper ssh docker rsyslog --no-pager
sudo journalctl -u traefik -n 100 --no-pager
sudo journalctl -u sshpiper -n 100 --no-pager
```

## Network/listeners

```bash
sudo ss -lntup
ip route
sudo docker network ls
sudo docker network inspect NETWORK
```

## Docker

```bash
sudo docker ps
sudo docker ps -a
sudo docker stats
sudo docker system df
```

## Firewall

```bash
sudo ufw status verbose
```
