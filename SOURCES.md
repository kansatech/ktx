# Research Notes / Sources

Upstream facts in this revision were checked on 2026-09-11.

- Docker supports Ubuntu 24.04 LTS and warns Docker-published ports can bypass ufw/firewalld expectations: https://docs.docker.com/engine/install/ubuntu/
- Traefik File provider supports a watched configuration directory and live file-based routers/services: https://doc.traefik.io/traefik/providers/file/
- Traefik 3.7 is in active/security support; 3.7.13 was released 2026-09-04 with security fixes: https://doc.traefik.io/traefik/deprecation/releases/ and https://github.com/traefik/traefik/releases/tag/v3.7.13
- Traefik HTTP-01 is compatible with HTTP->HTTPS redirection: https://doc.traefik.io/traefik/v3.6/reference/install-configuration/tls/certificate-resolvers/acme/
- SSHPiper v1.6.1 is a current tagged release; workingdir routes by username and supports authorized_keys, mapping `id_rsa`, and strict known_hosts: https://github.com/tg123/sshpiper/tags and https://pkg.go.dev/github.com/tg123/sshpiper/plugin/workingdir
- Ubuntu security updates/unattended-upgrades: https://documentation.ubuntu.com/security/security-updates/
- Go 1.26.8 release history: https://go.dev/doc/devel/release
