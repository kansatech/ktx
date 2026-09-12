# Workload SSH Ingress Problems

Expected path: public TCP 22 -> native SSHPiper -> private workload SSH.

```bash
systemctl status sshpiper --no-pager
ss -lntp | grep ':22 '
journalctl -u sshpiper -n 150 --no-pager
sudo ktx-ssh-route show clienta
nc -vz 172.28.4.2 2222
```

Check in order:

1. public 22 reachable;
2. SSHPiper active;
3. route directory exists and files have strict permissions;
4. downstream key is in `authorized_keys`;
5. host can reach upstream IP/port;
6. `known_hosts` matches upstream persistent host key;
7. mapping key's public half is authorized upstream;
8. upstream account is allowed.
