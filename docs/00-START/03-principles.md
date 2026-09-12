# Host Core Principles

1. **One authoritative install path.** Fresh-server setup is `INSTALL.md` plus the phased `ktx-init` command; architecture documents do not duplicate package-install recipes.
2. **SSH first.** Establish the `ktx` administrator, prove the key, then put SSHPiper in front before spending time on Docker or web ingress.
3. **No root SSH.** Humans log in as `ktx` and elevate with sudo.
4. **One public SSH port.** SSHPiper owns TCP 22 and routes by username, including the reserved `ktx` route back to loopback OpenSSH.
5. **Native host plumbing, containerized workloads.** Host Core operates the machine; KTX modules are things the machine hosts.
6. **No Docker socket ingress discovery.** Routes are explicit files/private addresses.
7. **Pin versions in Git.** Native Traefik and SSHPiper versions live in tracked `host/versions.env`; install tooling downloads those exact releases and verifies upstream checksums.
8. **Build -> dev -> prod still matters.** A version/config change is proven on build and dev before the same Host Core Git tag is used on prod.
9. **Server-local state stays local.** `config/`, `secrets/`, `containers/`, `data/`, and module checkouts are ignored by Host Core Git and backed up separately.
10. **Prefer boring recovery.** Provider console access remains the break-glass path if SSHPiper or networking is broken.
