# Native Services

These services are installed directly on Ubuntu.

| Service | systemd unit | Listener | Reason it is native |
|---|---|---|---|
| OpenSSH | `ssh.service` | TCP 2222 | Host recovery/administration must not depend on Docker |
| Traefik | `traefik.service` | TCP 80/443 | Public web ingress must survive workload recreation and needs no Docker socket |
| SSHPiper | `sshpiper.service` | TCP 22 | Public SSH ingress is host plumbing, not a hosted app |
| rsyslog | `rsyslog.service` | TCP 514 from KTX private pool | Host owns central low-overhead log collection |
| Docker | `docker.service` | local socket | Workload runtime |
| chrony/system time | Ubuntu service | N/A | Reliable time for TLS/logging |
| UFW | native firewall | N/A | Host-native ingress policy |

KTX helper tools under `/usr/local/sbin` are also host-native:

```text
ktx-net
ktx-web-route
ktx-ssh-route
ktx-host-check
```

Future template packs consume those host contracts instead of editing KTX Core internals directly.
