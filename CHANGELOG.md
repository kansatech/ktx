# Changelog

## 2026.09.11-rc.1

- Reviewed the complete Host Core source and module skeleton; retained the native host architecture.
- Renamed host commands to short names under `/srv/ktx/bin` and updated the handbook; removed global command alias installation.
- Made installation phases explicit, guarded completed phases, and centralized the existing-account/key-verification procedure in `INSTALL.md`.
- Replaced SSH drop-in layering with a complete backed-up policy; added pre-cutover mapping-key authentication and bounded external-login confirmation with rollback attempts.
- Corrected service permissions, ACL traversal, layout reapplication, log rotation users, firewall ordering, and health-check failure handling.
- Hardened route/key input, reserved logins, atomic writes, network registry integrity/concurrency, and IPv6 endpoint formatting.
- Pinned native archive SHA-256 hashes without changing Traefik/SSHPiper versions; removed stale Go/source-build claims.
- Corrected confidential backup scope, recovery ordering, network offsets, and module/document links; expanded portable static validation.
- Added `RC-REVIEW.md` with Windows verification and explicit Ubuntu acceptance gates. This RC is not production-qualified.

## 2026.09.11-r4
- KTX no longer creates the `ktx` administrator account. Fresh install explicitly requires the human to create `ktx`, set its local password, and add it to `sudo` before cloning Host Core.
- Added Midnight Commander (`mc`) to the centralized bootstrap dependency set.
- Kept the package-install sequence centralized: only pre-clone prerequisites remain in `INSTALL.md`; Host Core prerequisites are installed by `init bootstrap`.
- Corrected Ubuntu 24.04 OpenSSH handling: final KTX state disables `ssh.socket` activation, enables `ssh.service`, and binds native OpenSSH directly to `127.0.0.1:2222` only.
- Hardened `secure-ssh` ordering so the SSHPiper unit is installed before listener cutover, loopback OpenSSH is proven before SSHPiper takes public port 22, and listener ownership is validated.
- Expanded SSH route documentation to explicitly describe the two independent key relationships: workstation -> SSHPiper and SSHPiper mapping key -> upstream SSH account.
- Documented that `known_hosts-line.txt` is merely ordinary OpenSSH known_hosts-formatted input; `ssh-route` now accepts stdin (`-`) for authorization/trust input.
- Documented that normal route/key/known_hosts edits do not require restarting SSHPiper.
- Reserved `ktx` for the exact host route and prohibited root SSH routes in `ssh-route`.
- Expanded SSH troubleshooting/checklists around `ssh.socket`, listener ownership, and public-key failures on either hop.

## 2026.09.11-r3
- Replaced the scattered bootstrap procedure with one root `INSTALL.md` and phased `bin/init` command.
- Fresh-host package installation is centralized in `init`; architecture/lifecycle docs no longer repeat APT commands.
- Made SSH the first Host Core priority: temporary password access is allowed only for `ktx` during bootstrap, then converted to public-key-only.
- Routed host administrator `ktx` through native SSHPiper on public TCP 22.
- Moved native OpenSSH to loopback-only `127.0.0.1:2222`; there is no public administrator SSH port.
- Preserved the OpenSSH Ed25519 host identity when SSHPiper takes over port 22 to avoid an unnecessary client host-key change.
- Added pinned native-version file and `install-native` for verified SSHPiper/Traefik release installation.
- Reserved SSHPiper login `ktx` for Host Core administration.
- Simplified new-host checklist, firewall model, health checks, recovery, and troubleshooting around the one-port SSH design.

## 2026.09.11-r2.1
- Added `bin/validate-repo` to fail fast when a clone/archive is missing required Host Core commands.
- Fresh-install instructions now validate the checkout before running `init-layout`.
- Revalidated that `bin/init-layout` is included and executable in the release archive.

## 2026.09.11-r2
- Restructured Host Core as the `Kansatech/ktx` repository cloned directly to `/srv/ktx`.
- Added `.gitignore` for server-specific config, secrets, module checkouts, container instances, data, logs, releases, and recovery state.
- Moved Host Core documentation under `docs/` and helper commands under `bin/`.
- Added `init-layout`, `apply-host`, and `repo-status`.
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
