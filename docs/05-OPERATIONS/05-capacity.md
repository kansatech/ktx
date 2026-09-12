# Host Capacity

KTX Core itself should be relatively light. Most RAM/disk use belongs to workloads, Docker cache, and logs.

## Check host

```bash
free -h
vmstat 1 10
df -h
df -i
ps aux --sort=-%mem | head -25
```

## Check Docker

```bash
sudo docker stats
sudo docker system df
```

## Native service footprint

```bash
systemctl status traefik sshpiper rsyslog docker ssh --no-pager
ps -o pid,user,rss,cmd -C traefik -C sshpiperd -C rsyslogd -C dockerd
```

## Do not over-prune

`docker system prune -a` is not a weekly hygiene command. It can remove images retained for workload rollback. Cleanup belongs to the workload/image lifecycle that owns those artifacts.
