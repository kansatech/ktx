# Native Host Services

These are part of Host Core rather than workload modules.

| Component | Native service | Listener | Role |
|---|---|---|---|
| OpenSSH | `ssh.service` | `127.0.0.1:2222` | Host shell for `ktx`; key-only; not public |
| SSHPiper | `sshpiper.service` | `:22` | All public SSH routing, including host `ktx` |
| Traefik | `traefik.service` | `:80`, `:443` | Public HTTP/HTTPS ingress and ACME |
| Docker | `docker.service` | none public | Workload runtime |
| rsyslog | `rsyslog.service` | `:514` from KTX Docker pool | Central low-overhead workload logging |
| Chrony | `chrony.service` | normal NTP behavior | Host time |

Fresh installation/configuration is scripted by `bin/init`; these documents describe the operating model, not repeated APT steps.

KTX uses `ssh.service` directly; bootstrap disables Ubuntu `ssh.socket` activation before the later SSHPiper cutover.
