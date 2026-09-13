# RC Review — KTX Host Core 2026.09.11-rc.1

This is a source release candidate for a fresh Ubuntu 24.04 host cloned directly
to `/srv/ktx`. It is **not yet production-qualified**. Native component versions
remain Traefik 3.7.13 and SSHPiper 1.6.1.

The local artifact is `releases/ktx-host-core-2026.09.11-rc.1.tar.gz`, with a
separate SHA-256 file. It contains only portable source with executable command
modes; Git history, runtime state, and validation downloads are excluded.
Publishing/tagging this candidate is separate from preparing the local artifact.

## Simplified

- Short commands under `/srv/ktx/bin`: `init`, `init-layout`, `install-native`,
  `apply-host`, `host-check`, `net`, `ssh-route`, `web-route`, `repo-status`,
  `validate-repo`. No global `init`/`net` aliases or configurable installation root.
- One install guide and three explicit phases. The existing `ktx` account is a
  prerequisite; package installation is centralized in bootstrap/finish.
- Readable shell/Python, visible phase output and errors, explicit archive members,
  and installed copies of systemd/logging configuration.
- Explanations remain separate from installation, operations, recovery, and module
  authoring. Removed obsolete compile-on-host/Go instructions and machine-specific
  example hostnames; corrected command paths and module references.

## Corrected

- Complete, backed-up SSH policy avoids inherited drop-in precedence/listeners.
  Native OpenSSH ends at **127.0.0.1:2222 only**, with public-key authentication,
  no root SSH, and `ssh.socket` plus its generator disabled/masked.
- SSHPiper alone takes public 22 after loopback mapping-key authentication is
  tested. External login confirmation is bounded; failures/timeouts attempt to
  restore pre-cutover public OpenSSH. Completed phases refuse accidental reruns.
- Service ownership, private route modes, parent-directory traversal ACLs, and
  service-user log rotation. Reapplying source no longer resets runtime permissions.
- Reserved-route/path validation, SSHPiper-compatible usernames, parsed plain keys,
  revocation by key bytes, last-admin-key protection, atomic route writes, and IPv6
  endpoint formatting. Known-host trust requires verified literal upstream entries.
- Network mutations are locked; malformed/conflicting registry rows are rejected.
  Allocation preserves the six-column format and treats gateway/primary as subnet
  offsets. Failed Docker operations cannot silently free registry allocations.
- Firewall precedes web/syslog startup; syslog ingress is limited to the configured
  pool on KTX bridges. Docker conflicts/configuration are surfaced instead of removed
  or overwritten silently. Health-check failures fail installation.
- Native archive hashes are committed alongside version pins. Runtime, credentials,
  data, nested repositories, and validation artifacts remain ignored. `config/`
  backups are correctly classified as confidential because they hold mapping keys.

## Windows verification

Reviewed all 118 original tracked files and the final 121-file source set.

- Passed Bash syntax and ShellCheck 0.11.0 for all six shell commands; compiled
  all four Python commands and three embedded Python blocks without cache files.
- Parsed tracked JSON/YAML, documented YAML examples, and generated route YAML;
  checked systemd unit structure/accounts/paths, SSH policy, and logrotate users.
- Passed 134 targeted source/config/path/security assertions, including invalid
  SSH users/keys, IPv6 formatting, subnet offsets, corrupt/duplicate registry
  rejection, and simulated atomic-write failure. These are local source probes.
- Checked local Markdown links, source-path references, LF/no-BOM encoding,
  executable Git modes (100755 for all ten commands), ignored runtime paths,
  and the final diff. Scanned the complete source set for credential/key patterns;
  no real credential material was found. Existing Git history was not rewritten.
- Downloaded all four pinned native archives and verified their committed
  SHA-256 values, expected regular-file members, and Linux ELF64 CPU architecture
  without running those binaries.

Native systemd/OpenSSH/rsyslog/logrotate/Docker validators and service/ACL tests
were **not run**: this workspace is Windows and has no usable Ubuntu runtime.
The unit/config review is structural and source-based, not native semantic or
runtime validation. ShellCheck/PyYAML and probe/download files stayed in ignored
scratch space; no production dependency was added for validation.

## Required Linux acceptance before production

- Fresh Ubuntu 24.04 installation on each deployed CPU architecture; verify the
  official archive members, binary versions, Docker packages, and service startup.
- Real key-only workstation login before/after cutover; reject password, root,
  unknown users/keys, and changed upstream host keys. Test timeout/failure rollback
  and interrupted installation with console access. A shell trap cannot recover
  from power loss, SIGKILL, or a broken OS/service manager.
- Effective `sshd -T`, listener ownership on IPv4/IPv6, socket/generator masks,
  systemd overrides/order, surviving original session, and final state after reboot.
- Real service-user read/write access and ACL persistence; `sshd -t`,
  `systemd-analyze verify`, `rsyslogd -N1`, `logrotate --debug`, and
  `dockerd --validate`. Exercise log receipt and rotation.
- External firewall checks (22/80/443 only; no public 2222/514), host-to-container
  reachability, allocation/removal and concurrent registry updates, Traefik route
  reload, HTTP redirect, ACME staging, SSH/SFTP, and representative module contracts.
- Protected backup/restore of the matching SSH identity set, ACME state, ACLs,
  and network registry. Rehearse rollback with the same source/binary artifacts.

Earlier r1-r4 installations need a reviewed console migration; no automatic
upgrade from those states is claimed. See the [release lifecycle](docs/04-LIFECYCLE/01-core-release-lifecycle.md).
