# Path Reference

| Path | Purpose | Git-owned by Kansatech/ktx? |
|---|---|---:|
| `/srv/ktx/README.md` | Host Core entry point | Yes |
| `/srv/ktx/docs/` | Host Core documentation | Yes |
| `/srv/ktx/bin/` | Host Core helper commands | Yes |
| `/srv/ktx/host/` | tracked native-service/default files | Yes |
| `/srv/ktx/module-template/` | module repository skeleton | Yes |
| `/srv/ktx/config/host.conf` | server-specific Host Core policy | No |
| `/srv/ktx/config/networks.tsv` | deterministic network allocation registry | No |
| `/srv/ktx/config/traefik/` | this host's Traefik static/dynamic config | No |
| `/srv/ktx/config/sshpiper/routes/` | this host's customer SSH routes | No |
| `/srv/ktx/secrets/` | private keys/passwords/tokens | No |
| `/srv/ktx/images/` | independent `Kansatech/ktx-*` module Git checkouts | No (child repos) |
| `/srv/ktx/containers/` | server-specific instantiated container definitions | No |
| `/srv/ktx/data/` | persistent runtime data | No |
| `/srv/ktx/logs/` | runtime logs | No |
| `/srv/ktx/releases/` | approved built/promoted artifacts | No |
| `/srv/ktx/recovery/` | restore workspace | No |

Conventional native install paths such as `/usr/local/sbin`, `/etc/systemd/system`, `/etc/rsyslog.d`, and `/etc/logrotate.d` are linked or installed from the tracked `/srv/ktx` checkout where practical.
