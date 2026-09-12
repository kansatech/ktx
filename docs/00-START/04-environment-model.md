# Build / Dev / Prod Model

All three hosts use the same Host Core architecture and Git repository. Their server-local configuration differs.

| Concern | Build | Dev | Prod |
|---|---|---|---|
| Host login | `ssh ktx@host` through SSHPiper | same | same |
| Public host sshd | never | never | never |
| Root SSH | disabled | disabled | disabled |
| Traefik | available for platform testing | test/staging routes | public production routes |
| Docker builds | primary purpose | occasional testing only | no normal image builds |
| Workload data | synthetic | test/sanitized | live |
| Secrets | build/test | dev | production |

Host Core is promoted by Git tag through build -> dev -> prod. Workload modules have their own independent lifecycle.
