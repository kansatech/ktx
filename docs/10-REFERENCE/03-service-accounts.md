# Service Accounts

| Account | Purpose | Interactive login |
|---|---|---|
| `ktx` | Human Host Core administrator; sudo-capable | Yes, via SSHPiper route only |
| `root` | Operating-system superuser used by sudo/system services | No SSH login |
| `sshpiper` | Native SSHPiper daemon | No |
| `traefik` | Native Traefik daemon | No |
| `syslog` | Ubuntu rsyslog | No |

The `ktx` account keeps a local password for sudo, but final SSH authentication is public-key only.
