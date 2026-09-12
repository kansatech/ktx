# Port Reference

| Port | Owner | Exposure |
|---|---|---|
| 22/TCP | native SSHPiper | Public SSH router; `ktx` route leads to host |
| 80/TCP | native Traefik | Public HTTP/ACME/HTTPS redirect |
| 443/TCP | native Traefik | Public HTTPS |
| 2222/TCP | native OpenSSH | **Loopback only** (`127.0.0.1`), upstream for SSHPiper host route |
| 514/TCP | native rsyslog | KTX private Docker pool only |

Workload-internal ports are defined by their module repositories and normally are not published on the host.
