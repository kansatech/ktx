# Production Hardening

## Public listeners

```text
22/tcp   SSHPiper
80/tcp   Traefik HTTP/ACME/redirect
443/tcp  Traefik HTTPS
```

Host OpenSSH listens only on:

```text
127.0.0.1:2222
```

and is not a firewall/public listener.

## SSH

- root SSH disabled;
- public password authentication disabled after bootstrap;
- `ktx` administration is public-key only through SSHPiper;
- SSHPiper workingdir uses `--no-password-auth` and strict upstream host-key checking;
- workload route `ktx` is reserved and may not be overridden;
- provider console/recovery access must remain available because SSHPiper is in the admin path.

## Docker/workloads

- no routine public Docker port publishing;
- no Docker socket in workloads;
- deterministic private networks;
- module-specific least privilege;
- Docker group treated as root-equivalent.

## Host

- security updates maintained;
- UTC/reliable time;
- Host Core server-local config/secrets backed up;
- UFW plus provider firewall where available;
- public services kept pinned and updated through Host Core lifecycle.

- `ssh.socket` is inactive; native `ssh.service` binds only `127.0.0.1:2222`.
