# Native Service Accounts

| Account | Purpose | Shell |
|---|---|---|
| `traefik` | Traefik daemon, ACME state/logs | nologin |
| `sshpiper` | SSHPiper daemon and route state | nologin |
| `syslog` | Ubuntu rsyslog | package-defined |
| administrator account | human host administration | normal shell + controlled sudo |

Neither Traefik nor SSHPiper belongs in the `docker` group.
