# Traefik / ACME Problems

Check:

```bash
systemctl status traefik --no-pager
sudo journalctl -u traefik -n 200 --no-pager
sudo grep -iE 'acme|certificate|challenge|error' /srv/ktx/logs/traefik/traefik.log | tail -100
sudo ls -l /srv/ktx/data/traefik/acme.json
```

Then verify:

- DNS A/AAAA records point to this host;
- 80/443 are open at provider firewall and UFW;
- `acme.json` is writable by `traefik` and mode 0600;
- router hostname is correct;
- production rate limits were not hit;
- IPv6 AAAA isn't pointing somewhere broken.

Do not install Certbot into a workload to route around a broken Host Core certificate path.
