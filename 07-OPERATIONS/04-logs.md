# Using Logs

> **Purpose:** Find evidence in the right layer first.

Container console:
```bash
docker logs --tail=200 ktx-web-example-01
docker logs -f ktx-proxy-01
```
Central:
```bash
grep -R "PHP Fatal" /srv/ktx/logs/example/
zgrep " 500 " /srv/ktx/logs/example/*.gz
```
Host:
```bash
journalctl -u docker --since today
journalctl -u ssh --since today
dmesg -T | tail -100
```

Web failure order: DNS -> Traefik -> Docker network -> Apache -> PHP-FPM -> application -> DB/external dependency.
