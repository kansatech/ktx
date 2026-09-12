# Production Hardening

## Public surface

Expected:

```text
22/tcp   SSHPiper (if workload SSH offered)
80/tcp   Traefik
443/tcp  Traefik
2222/tcp host sshd, restricted source
```

Investigate anything else with:

```bash
sudo ss -lntup
sudo docker ps --format 'table {{.Names}}\t{{.Ports}}'
```

## Host

- key-only admin SSH;
- root SSH disabled;
- provider firewall + UFW;
- current security updates;
- UTC/Chrony healthy;
- no compiler/toolchain required for normal prod operation;
- no application runtimes casually installed on host;
- `/srv/ktx/secrets` mode 0700;
- recovery console/provider access maintained.

## Docker

KTX Core contract forbids future normal workloads from:

- mounting `/var/run/docker.sock`;
- `--privileged` without an explicit architecture exception;
- mounting host `/`;
- publishing arbitrary public host ports;
- changing host firewall policy.

## Traefik

- no Docker provider;
- no insecure dashboard;
- ACME file protected;
- dynamic directory writable only by root/KTX tooling;
- run as unprivileged service account with only bind-service capability.

## SSHPiper

- downstream public-key authentication only;
- strict upstream host-key verification;
- route files 0700/0600 as required;
- no admin UI by default;
- current version/security review.
