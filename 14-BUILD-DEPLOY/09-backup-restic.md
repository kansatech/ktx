# Build and Deploy `ktx-backup-01` (restic)

> **Purpose:** Create logical DB dumps, back up KTX persistent files to an encrypted off-host repository, and restore them later.

## Version

Example current stable used by this revision:

```bash
export RESTIC_VERSION=0.19.1
export KTX_RELEASE=2026.09.10-r2
```

Before a future build, verify the desired stable restic release and test it on build/dev.

## Build

```bash
cd /srv/ktx/platform/templates/images/backup
sudo docker build \
  --build-arg KTX_BASE_RELEASE=${KTX_RELEASE} \
  --build-arg RESTIC_VERSION=${RESTIC_VERSION} \
  -t ktx/backup:${KTX_RELEASE} .
```

The build downloads the official restic Linux binary and verifies it against upstream `SHA256SUMS`. It also installs a MySQL-compatible client for logical dumps.

Verify:

```bash
sudo docker run --rm ktx/backup:${KTX_RELEASE} restic version
sudo docker run --rm ktx/backup:${KTX_RELEASE} mysqldump --version
```

## Secrets

```bash
sudo mkdir -p /srv/ktx/secrets/infrastructure/backup
sudo chmod 0700 /srv/ktx/secrets/infrastructure/backup
```

Create the restic password and repository pointer:

```bash
openssl rand -base64 48 | tr -d '\n' | sudo tee \
  /srv/ktx/secrets/infrastructure/backup/restic-password >/dev/null
printf '%s\n' 'sftp:BACKUPUSER@BACKUPHOST:/path/to/ktx-prod' | sudo tee \
  /srv/ktx/secrets/infrastructure/backup/repository >/dev/null
sudo chmod 0600 /srv/ktx/secrets/infrastructure/backup/{restic-password,repository}
```

The repository URI above is an example; restic also supports other backends. Configure any SSH/cloud credentials the chosen backend needs without putting them in Git.

Create one dedicated Percona backup account from an administrative MySQL session:

```sql
CREATE USER 'ktx_backup'@'%' IDENTIFIED BY 'LONG_RANDOM_SECRET';
GRANT SELECT, SHOW VIEW, TRIGGER, EVENT, SHOW_ROUTINE ON *.* TO 'ktx_backup'@'%';
```

Then create `/srv/ktx/secrets/infrastructure/backup/mysql-backup.cnf`:

```ini
[client]
host=ktx-percona-01
port=3306
user=ktx_backup
password=LONG_RANDOM_SECRET
```

Protect it:

```bash
sudo chmod 0600 /srv/ktx/secrets/infrastructure/backup/mysql-backup.cnf
```

The dump command uses `--single-transaction` and `--no-tablespaces`, so the account does not need broad administrative privileges.

## Deploy

```bash
sudo mkdir -p /srv/ktx/backups/{staging,restore-work}
sudo mkdir -p /srv/ktx/containers/ktx-backup-01
sudo cp /srv/ktx/platform/templates/containers/backup/compose.yml.example \
  /srv/ktx/containers/ktx-backup-01/compose.yml
sudo cp /srv/ktx/platform/templates/backup/ktx-backup.sh.example \
  /srv/ktx/containers/ktx-backup-01/ktx-backup.sh
sudo chmod 0755 /srv/ktx/containers/ktx-backup-01/ktx-backup.sh

cd /srv/ktx/containers/ktx-backup-01
sudo docker compose up -d
```

`ktx-backup-01` is not externally accessible and does not need privileged mode. The Compose template mounts site/platform data plus Vaultwarden, Uptime Kuma, RustDesk, SSHPiper, and Traefik ACME state read-only. It does **not** mount the live Percona data directory. The backup script creates logical Percona dumps and consistent SQLite `.backup` copies for Uptime Kuma/Vaultwarden before restic snapshots the data.

## Initialize a new repository

Only once:

```bash
sudo docker exec ktx-backup-01 ktx-restic snapshots
```

If it reports that the repository does not exist, initialize deliberately:

```bash
sudo docker exec ktx-backup-01 ktx-restic init
```

## Run backup manually

```bash
sudo docker exec ktx-backup-01 /usr/local/sbin/ktx-backup
```

## Schedule

Install the supplied host systemd service/timer, adjust schedule if desired, then:

```bash
sudo cp /srv/ktx/platform/templates/systemd/ktx-backup.service.example /etc/systemd/system/ktx-backup.service
sudo cp /srv/ktx/platform/templates/systemd/ktx-backup.timer.example /etc/systemd/system/ktx-backup.timer
sudo systemctl daemon-reload
sudo systemctl enable --now ktx-backup.timer
sudo systemctl list-timers ktx-backup.timer
```

## Verify

```bash
sudo docker exec ktx-backup-01 ktx-restic snapshots
sudo docker exec ktx-backup-01 ktx-restic check
```

Then perform a test restore. A green backup job without a restore test is merely optimistic storage.

### Sources

- https://restic.readthedocs.io/en/latest/020_installation.html
- https://restic.readthedocs.io/en/latest/040_backup.html
- https://restic.readthedocs.io/en/latest/050_restore.html
