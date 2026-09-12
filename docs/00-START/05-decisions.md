# Architecture Decisions

## Native Traefik instead of a proxy container

Traefik is host ingress. Running it natively removes Docker-network reconciliation for the proxy and removes any reason to grant it Docker API access. The file provider watches `/srv/ktx/config/traefik/dynamic` and updates routes live.

## Native SSHPiper instead of an SSH container

SSHPiper is also ingress. It listens on public port 22 and routes an external username to an explicit private backend. Running it natively removes another control-plane container and keeps the path easy to diagnose with `systemctl` and `journalctl`.

## Separate administrator sshd

OpenSSH listens on 2222 for host administration. A broken Traefik, SSHPiper, Docker daemon, or workload cannot remove the admin path. Production restricts 2222 at the provider/host firewall.

## No Docker socket in ingress

Traefik discovers nothing automatically. Future template packs explicitly create/remove routing files. This trades a tiny amount of provisioning work for a much smaller security boundary.

## Static private workload addressing

Each workload receives a `/28`. The bridge gateway is `.1`; the primary workload address is `.2`; `.3-.14` remain available for multi-container templates. Native ingress routes to these addresses directly.

## Native rsyslog

Low-overhead centralized logs are a host function. Workloads can forward to their network gateway on TCP 514 without needing a logging container.
