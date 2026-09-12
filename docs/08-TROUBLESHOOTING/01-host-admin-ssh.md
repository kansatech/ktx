# Cannot Reach Host Administrator SSH

Expected path: TCP 2222 -> native OpenSSH.

Check from provider console:

```bash
systemctl status ssh --no-pager
ss -lntp | grep ':2222 '
sshd -t
ufw status verbose
journalctl -u ssh -n 100 --no-pager
```

Common causes:

- firewall source CIDR changed;
- sshd config invalid;
- key missing/permissions wrong;
- provider firewall blocks 2222;
- public IP/DNS changed.

SSHPiper/Docker/Traefik are irrelevant to this path. That independence is intentional.
