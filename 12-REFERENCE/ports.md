# Port Reference
| Service | Internal/container | Prod host |
|---|---:|---:|
| Traefik HTTP | 80 | 80 |
| Traefik HTTPS | 443 | 443 |
| SSHPiper | configured, e.g. 2222 | 22 |
| Host sshd | host 2222 | 2222 restricted |
| Site Apache | 8080 | none |
| Site sshd | 2222 | none |
| Percona | 3306 | none; dev private 33601+ optional |
| Postfix internal SMTP | 25/submission | none |
| rsyslog TCP | 514 | none |
| Docker API proxy | 2375 | none |
