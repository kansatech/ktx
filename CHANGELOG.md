# Changelog

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
