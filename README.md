# KTX Host Core

`Kansatech/ktx` is the native host framework cloned directly into `/srv/ktx`.

It owns the Ubuntu/Docker host plumbing: **the `ktx` administrator account, SSHPiper, Traefik, rsyslog, firewall policy, deterministic workload networking, Host Core lifecycle, and the contract used by separate KTX module repositories.**

It does **not** contain PHP, Percona, Vaultwarden, Uptime Kuma, or other hosted workloads.

## New server

Follow **[INSTALL.md](INSTALL.md)**. It is the single authoritative fresh-host procedure; package-install commands are intentionally not repeated throughout the handbook.

## SSH model

There is only one public SSH ingress:

```text
Internet :22 -> SSHPiper
                  ├── ktx     -> 127.0.0.1:2222 -> host OpenSSH
                  ├── clienta -> workload A
                  └── clientb -> workload B
```

`root` is never an SSH login. Host OpenSSH is key-only after bootstrap and listens only on loopback. `ktx` is the host administrator and uses `sudo` when root privilege is needed.

## Repository / installed layout

```text
/srv/ktx/
├── .git/                    Kansatech/ktx history
├── README.md
├── INSTALL.md               one authoritative fresh-host procedure
├── docs/                    architecture/lifecycle/operations/reference
├── bin/                     Host Core commands
├── host/                    tracked native-service defaults/units/versions
├── module-template/         contract/skeleton for Kansatech/ktx-* repos
│
├── config/                  ignored: this server's config
├── secrets/                 ignored: secrets/private keys
├── images/                  ignored: separate module Git repositories
├── containers/              ignored: instantiated server-specific configs
├── data/                    ignored: persistent runtime data
├── logs/                    ignored: runtime logs
├── releases/                ignored: artifacts
├── recovery/                ignored: recovery workspace
└── tmp/                     ignored: scratch
```

Example nested module checkout:

```text
/srv/ktx/images/ktx-webphp85/.git -> Kansatech/ktx-webphp85
```

## Documentation

Use `docs/` when you need the **why**, lifecycle, troubleshooting, recovery, network contract, or module-authoring rules. Fresh-host package installation does not live there; `INSTALL.md` + `bin/ktx-init` are authoritative.

Start with [QUICK-LOOKUP.md](QUICK-LOOKUP.md).

## Git safety

Never run this in `/srv/ktx`:

```bash
git clean -fdx
```

KTX intentionally stores ignored server state under the checkout. `-x` means "delete the things KTX intentionally told Git not to own." That is a surprisingly efficient way to ruin an afternoon.

## Core rule

**If it operates the KTX host, it belongs in `Kansatech/ktx`. If KTX merely hosts it, it belongs in a separate `Kansatech/ktx-*` repository.**
