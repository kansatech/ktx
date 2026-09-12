# System at a Glance

KTX Host Core is a native Ubuntu infrastructure layer surrounding Docker workloads.

```text
                               INTERNET
                                  |
              +-------------------+-------------------+
              |                   |                   |
            TCP 80              TCP 443             TCP 22
              |                   |                   |
              +-------- native Traefik -------+   native SSHPiper
                            |                   |          |
                            |                   |          |
                  deterministic Docker workload networks
                            |                   |          |
                         containers created by separate template packs

Administrator path:
  trusted admin -> TCP 2222 -> native OpenSSH -> host

Host logging:
  containers -> workload network gateway (.1):514/TCP -> native rsyslog
```

## What KTX Core knows

KTX Core knows how to:

- allocate a private Docker network and static address range;
- expose a backend through Traefik by writing one watched routing file;
- expose an SSH backend through SSHPiper by creating one routing directory;
- collect workload syslog on the network gateway;
- run Docker safely enough for the intended small-hosting model;
- patch and recover the host.

KTX Core does **not** know whether the workload behind `172.28.4.2:8080` is PHP, Vaultwarden, Uptime Kuma, a game server, or something created in 2034 by a developer with regrettable naming instincts.

## Default baseline, verified 2026-09-11

- Ubuntu 24.04 LTS
- Docker Engine from Docker's official APT repository
- Traefik 3.7.x; baseline package in this handbook: 3.7.13
- SSHPiper v1.6.1; built on `ktx-build-26`
- Go 1.26.8 on build only for the SSHPiper build
- OpenSSH from Ubuntu
- rsyslog from Ubuntu
- UFW/provider firewall for host-native ingress; Docker published ports are treated separately

Versions are baselines, not eternal truths. Updates follow the Host Core lifecycle.
