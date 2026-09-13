# KTX Host Core

KTX is cloned directly into `/srv/ktx` and manages an Ubuntu 24.04 host: Docker,
native Traefik, SSHPiper, OpenSSH, rsyslog, firewall policy, and the network/ingress
contract for independent container modules. Hosted applications live in their
own repositories; this repository contains no deployable workload.

**Start with [INSTALL.md](INSTALL.md).** It is the single installation procedure.
The sudo-capable `ktx` account must already exist. This is release candidate
`2026.09.11-rc.1`; see [RC-REVIEW.md](RC-REVIEW.md) for validation and remaining gates.

## SSH

```text
Internet :22 -> native SSHPiper
                  |-- ktx     -> 127.0.0.1:2222 -> native OpenSSH
                  `-- example -> private workload SSH
```

SSHPiper is the only public SSH listener. Host OpenSSH is public-key-only,
loopback-only, and permits `ktx` alone; root SSH and Ubuntu socket activation are
disabled. Bootstrap temporarily permits password SSH while you establish a key.

## Source and local state

| Tracked source | Ignored host-local state |
|---|---|
| `bin/` — readable host commands | `config/`, `secrets/` — configuration and credentials |
| `host/` — service units, defaults, version pins | `data/`, `logs/` — persistent state and logs |
| `docs/` — operating handbook and explanations | `containers/` — generated workload instances |
| `module-template/` — authoring skeleton | `images/` — independent module Git checkouts |
| Root installation/release documents | `releases/`, `recovery/`, `tmp/`, `cache/` |

Use explicit commands such as `sudo /srv/ktx/bin/host-check` and
`sudo /srv/ktx/bin/net list`. Short names stay under `bin/`; KTX does not install
global aliases named `init` or `net`. Native units/configs are copied to `/etc`
by `apply-host`; checking out source does not automatically restart services.

**Never run `git clean -fdx` or `git clean -ffdx` in `/srv/ktx`.** Those commands
can delete the ignored configuration, secrets, module repositories, and data.
Ignored state needs protected off-host backups; Git is not that backup.

## Handbook

[QUICK-LOOKUP.md](QUICK-LOOKUP.md) links to operations, architecture, networking,
security, lifecycle, recovery, troubleshooting, and module authoring.
Explanatory pages do not repeat the installation sequence.
