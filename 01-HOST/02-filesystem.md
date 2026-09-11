# Host Filesystem Layout

> **Purpose:** Give every persistent thing an obvious home.

```text
/srv/ktx/
├── platform/       # versioned platform definitions + playbook
├── containers/     # instance Compose/config
├── sites/          # per-site persistent files/manifests
├── data/           # shared-service persistent state
├── secrets/        # root-protected credentials
├── backups/        # staging + restore workspace
├── releases/       # immutable promoted bundles
└── logs/           # centralized logs
```

Per site:
```text
/srv/ktx/sites/example/
├── manifest.yml
├── app/
├── cron/ktx-site
├── ssh/hostkeys/
├── config/
└── restore/
```

Secrets:
```text
/srv/ktx/secrets/sites/example/
```

Shared state examples:
```text
/srv/ktx/data/percona-01/
/srv/ktx/data/proxy-01/acme/
/srv/ktx/data/ssh-01/workingdir/
/srv/ktx/data/vaultwarden-01/
```

Do not back up `/var/lib/docker` as your application recovery strategy. Back up build definitions/releases and persistent state.
