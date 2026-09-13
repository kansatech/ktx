# Implementation Sources

References checked for the RC on 2026-09-11. Native versions remain Traefik
3.7.13 and SSHPiper 1.6.1; a pinned version is not a promise of ongoing security
support. Review advisories before promotion.

- [Ubuntu 24.04 sshd_config manual](https://manpages.ubuntu.com/manpages/noble/man5/sshd_config.5.html): complete-policy directives, Includes, authentication, listeners, and host keys.
- [Ubuntu OpenSSH socket-activation guidance](https://discourse.ubuntu.com/t/sshd-now-uses-socket-based-activation-ubuntu-22-10-and-later/30189): direct service operation and socket migration details. Check the installed `/usr/share/doc/openssh-server/README.Debian.gz` during Linux acceptance, including the generator mask.
- [Docker Ubuntu installation](https://docs.docker.com/engine/install/ubuntu/): official package repository, conflicting packages, Ubuntu 24.04 support, and Docker/UFW caveats.
- [Traefik 3.7.13 release](https://github.com/traefik/traefik/releases/tag/v3.7.13) and [checksum manifest](https://github.com/traefik/traefik/releases/download/v3.7.13/traefik_v3.7.13_checksums.txt): pinned release and committed Linux archive hashes.
- [Traefik file provider](https://doc.traefik.io/traefik/providers/file/) and [ACME resolver](https://doc.traefik.io/traefik/reference/install-configuration/tls/certificate-resolvers/acme/): watched routes and HTTP-01 configuration.
- [SSHPiper 1.6.1 release](https://github.com/tg123/sshpiper/releases/tag/v1.6.1) and [checksum manifest](https://github.com/tg123/sshpiper/releases/download/v1.6.1/checksums.txt): pinned release and committed Linux archive hashes.
- [SSHPiper workingdir implementation](https://github.com/tg123/sshpiper/blob/v1.6.1/plugin/workingdir/workingdir.go): username rule, filenames, permission checks, and upstream format.
- [SSHPiper workingdir options](https://github.com/tg123/sshpiper/blob/v1.6.1/plugin/workingdir/main.go) and [daemon options](https://github.com/tg123/sshpiper/blob/v1.6.1/cmd/sshpiperd/main.go): key-only authentication, strict upstream trust, listener address, and host-key generation mode.
- [SSHPiper release layout](https://github.com/tg123/sshpiper/blob/v1.6.1/.goreleaser.yaml): archive naming and `sshpiperd` / `plugins/workingdir` members.

Reading upstream source and manifests does not validate Linux daemon startup,
permissions, systemd dependencies, or a real SSH connection. Those remain explicit
RC acceptance gates.
