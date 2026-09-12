# `/srv/ktx` Filesystem Layout

`/srv/ktx` is both the `Kansatech/ktx` checkout and the root of KTX local state.

```text
/srv/ktx/
├── .git/
├── README.md
├── VERSION
├── CHANGELOG.md
├── docs/                    tracked
├── bin/                     tracked
├── host/                    tracked
├── module-template/         tracked
│
├── config/                  ignored: server-specific non-secret config
│   ├── host.conf
│   ├── networks.tsv
│   ├── traefik/
│   │   ├── traefik.yml
│   │   └── dynamic/
│   └── sshpiper/
│       └── routes/
├── secrets/                 ignored: private keys/passwords/tokens
│   └── sshpiper/
├── images/                  ignored by Core; child module Git repos
├── containers/              ignored: instantiated container definitions
├── data/                    ignored: persistent workload/native-service data
│   └── traefik/
├── logs/                    ignored
├── releases/                ignored: build/promoted binary/image artifacts
├── recovery/                ignored
├── tmp/                     ignored
└── cache/                   ignored
```

## Create local directories

From the cloned repository:

```bash
cd /srv/ktx
sudo ./bin/ktx-init-layout
```

The command is idempotent. It creates directories and initial example-based configuration only when files do not already exist.

## Why images is ignored

`images/` contains **other Git repositories** such as:

```text
/srv/ktx/images/ktx-webphp85
/srv/ktx/images/ktx-percona84
```

Each child repository is versioned independently on GitHub. They are not subdirectories owned by the `Kansatech/ktx` history.

## Why containers is ignored

Module repositories contain reusable container templates. A concrete server instance contains hostnames, allocated private IPs, environment choices, and possibly secret references, so it belongs in:

```text
/srv/ktx/containers/<instance>
```

and is local/server-specific.

## Why config is ignored

Host Core defaults live under tracked `host/defaults/`. `/srv/ktx/config` is the materialized configuration for this machine.

That permits:

- build/dev/prod to use the same source tag;
- each host to have different hostname, private pool, ACME email, route files, and environment;
- `git status` to remain useful instead of showing local config changes forever.

## Secrets

`/srv/ktx/secrets` is mode 0700 and is never committed.

Git ignore is **not** a backup strategy. Back up `config`, `secrets`, required `data`, and instance definitions separately.
