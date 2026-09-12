# Port Reference

| Port | Owner | Exposure |
|---:|---|---|
| 22/TCP | native SSHPiper | Public only if workload SSH offered |
| 80/TCP | native Traefik | Public |
| 443/TCP | native Traefik | Public |
| 514/TCP | native rsyslog | KTX private Docker pool only |
| 2222/TCP | native OpenSSH | Trusted administrator sources only |

Future workload ports remain private Docker addresses unless a separate template explicitly documents an exception.
