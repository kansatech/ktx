# KTX Host Core

`Kansatech/ktx` is both the Host Core source repository **and** the directory installed at:

```text
/srv/ktx
```

A new KTX server begins by cloning this repository into `/srv/ktx`. Tracked files define the host platform; ignored directories hold that particular server's configuration, secrets, module checkouts, container instances, and runtime data.

> **Scope:** KTX Host Core only. PHP, Percona, Vaultwarden, Uptime Kuma, Restic workloads, and other hosted services belong in separate `Kansatech/ktx-*` module repositories.

## Fresh server: first commands

After a clean Ubuntu 24.04 LTS install:

```bash
sudo apt update
sudo apt install -y git ca-certificates

sudo mkdir -p /srv
sudo git clone https://github.com/Kansatech/ktx.git /srv/ktx
cd /srv/ktx

sudo ./bin/ktx-init-layout
```

If the repository is private or you prefer GitHub SSH authentication, clone with the SSH URL instead.

Then continue with:

[`docs/01-BOOTSTRAP/01-fresh-ubuntu.md`](docs/01-BOOTSTRAP/01-fresh-ubuntu.md)

## Repository / installed layout

```text
/srv/ktx/
├── .git/                    Kansatech/ktx history
├── .gitignore
├── README.md
├── VERSION
├── CHANGELOG.md
├── docs/                    Host Core documentation
├── bin/                     tracked KTX host commands
├── host/                    tracked native-service files/defaults
├── module-template/         skeleton/contract for new ktx-* module repos
│
├── config/                  ignored: this server's non-secret config
├── secrets/                 ignored: this server's secrets/private keys
├── images/                  ignored by Core; contains separate module Git repos
├── containers/              ignored: instantiated server-specific container configs
├── data/                    ignored: persistent runtime data
├── logs/                    ignored: runtime logs
├── releases/                ignored: built/promoted artifacts
├── recovery/                ignored: restore workspace
└── tmp/                     ignored: scratch
```

`/srv/ktx/images/ktx-webphp85`, for example, can itself be a clone of `Kansatech/ktx-webphp85`. The parent KTX repository ignores that path, so the two histories do not collide.

## Start here

| Task | Document |
|---|---|
| Understand KTX Core | [System at a glance](docs/00-START/01-system-at-a-glance.md) |
| Understand Git/repository deployment | [Repository model](docs/00-START/06-repository-model.md) |
| Build a new host | [Fresh Ubuntu bootstrap](docs/01-BOOTSTRAP/01-fresh-ubuntu.md) |
| Understand `/srv/ktx` | [Filesystem layout](docs/01-BOOTSTRAP/02-filesystem.md) |
| Configure administrator SSH | [Admin SSH](docs/01-BOOTSTRAP/05-admin-ssh.md) |
| Install native Traefik | [Traefik](docs/01-BOOTSTRAP/06-traefik.md) |
| Install native SSHPiper | [SSHPiper](docs/01-BOOTSTRAP/07-sshpiper.md) |
| Understand workload networking | [Network model](docs/02-NETWORKING/01-network-model.md) |
| Promote Host Core build -> dev -> prod | [Core release lifecycle](docs/04-LIFECYCLE/01-core-release-lifecycle.md) |
| Create a new KTX module repository | [Module authoring](docs/12-MODULES/README.md) |
| Rebuild a dead host | [Full host rebuild](docs/07-RECOVERY/03-full-host-rebuild.md) |
| Find something quickly | [QUICK-LOOKUP.md](QUICK-LOOKUP.md) |


## Critical Git safety rule

Because `/srv/ktx` intentionally contains ignored runtime state, **never run this in the Host Core checkout**:

```bash
git clean -fdx
```

or its more aggressive variants.

`-x` tells Git to delete ignored files too. In KTX, ignored files include `config/`, `secrets/`, `images/`, `containers/`, and `data/`.

Normal release deployment uses `git fetch`, `git checkout`/`git switch --detach`, and `ktx-apply-host`—not destructive cleaning of the checkout.

## Core rule

**If it operates the KTX host, it belongs in `Kansatech/ktx`. If KTX merely hosts it, it belongs in a separate `Kansatech/ktx-*` repository.**

Examples:

```text
Kansatech/ktx
Kansatech/ktx-webphp85
Kansatech/ktx-percona84
Kansatech/ktx-vaultwarden
...
```

The Host Core defines the contract. Modules implement workloads against that contract.
