# Web Ingress Problems

## 1. DNS

```bash
dig +short example.com
```

## 2. Public ports

```bash
sudo ss -lntp | grep -E ':(80|443)\b'
sudo ufw status
```

## 3. Traefik

```bash
systemctl status traefik --no-pager
journalctl -u traefik -n 150 --no-pager
tail -n 100 /srv/ktx/logs/traefik/traefik.log
```

## 4. Route file

```bash
sudo ktx-web-route show example
```

## 5. Backend from host

Use the private IP/port in that route:

```bash
curl -v http://172.28.4.2:8080/
```

If host->backend works but public route fails, focus on Traefik/config/TLS. If host->backend fails, focus on Docker network/workload.
