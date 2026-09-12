# Host Logs

## Native services

```bash
journalctl -u ssh --since today
journalctl -u sshpiper --since today
journalctl -u traefik --since today
journalctl -u docker --since today
journalctl -u rsyslog --since today
```

Traefik files:

```text
/srv/ktx/logs/traefik/traefik.log
/srv/ktx/logs/traefik/access.log
```

Remote workload syslog:

```text
/srv/ktx/logs/remote/<hostname>/<program>.log
```

Ubuntu security updates:

```text
/var/log/unattended-upgrades/unattended-upgrades.log
```

## Fast diagnosis order for public web

1. DNS/provider network
2. Traefik native service
3. dynamic route file
4. host-to-container backend connectivity
5. workload/application

For public SSH:

1. port 22/provider/UFW
2. SSHPiper service
3. route directory/downstream key
4. host-to-container TCP
5. upstream host key/mapping key
6. workload sshd/account
