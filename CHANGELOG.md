# Changelog

## 2026.09.11-r3
- Replaced the scattered bootstrap procedure with one root `INSTALL.md` and phased `bin/ktx-init` command.
- Fresh-host package installation is centralized in `ktx-init`; architecture/lifecycle docs no longer repeat APT commands.
- Made SSH the first Host Core priority: temporary password access is allowed only for `ktx` during bootstrap, then converted to public-key-only.
- Routed host administrator `ktx` through native SSHPiper on public TCP 22.
- Moved native OpenSSH to loopback-only `127.0.0.1:2222`; there is no public administrator SSH port.
- Preserved the OpenSSH Ed25519 host identity when SSHPiper takes over port 22 to avoid an unnecessary client host-key change.
- Added pinned native-version file and `ktx-install-native` for verified SSHPiper/Traefik release installation.
- Reserved SSHPiper login `ktx` for Host Core administration.
- Simplified new-host checklist, firewall model, health checks, recovery, and troubleshooting around the one-port SSH design.

## 2026.09.11-r2.1
- Added `bin/ktx-validate-repo` to fail fast when a clone/archive is missing required Host Core commands.
- Fresh-install instructions now validate the checkout before running `ktx-init-layout`.
- Revalidated that `bin/ktx-init-layout` is included and executable in the release archive.

## 2026.09.11-r2
- Restructured Host Core as the `Kansatech/ktx` repository cloned directly to `/srv/ktx`.
- Added `.gitignore` for server-specific config, secrets, module checkouts, container instances, data, logs, releases, and recovery state.
- Moved Host Core documentation under `docs/` and helper commands under `bin/`.
- Added `ktx-init-layout`, `ktx-apply-host`, and `ktx-repo-status`.
- Moved native tracked host files under `host/` and server-local configuration under ignored `/srv/ktx/config`.
- Added module repository skeleton and authoring/lifecycle documentation for independent `Kansatech/ktx-*` repositories.
- Changed Host Core promotion to immutable Git tags plus exact promoted native binary artifacts.

## 2026.09.11-r1

- Split KTX Host Core away from all workload/template documentation.
- Made Traefik, SSHPiper, OpenSSH, rsyslog, firewalling, and Docker host concerns explicitly native.
- Removed Docker API discovery from ingress architecture.
- Added deterministic per-workload `/28` network allocation contract.
- Added native helper tools for network, web-route, SSH-route, and host health management.
- Added build/dev/prod Host Core release lifecycle and recovery procedures.
