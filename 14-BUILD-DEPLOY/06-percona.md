# Build and Deploy `ktx-percona-01`

> **Purpose:** Build Percona Server for MySQL 8.4 LTS from Percona's Ubuntu packages and run it with persistent host storage.

## Build

```bash
export KTX_RELEASE=2026.09.10-r2
cd /srv/ktx/platform/templates/images/percona84
sudo docker build \
  --build-arg KTX_BASE_RELEASE=${KTX_RELEASE} \
  -t ktx/percona84:${KTX_RELEASE} .
```

The build uses Percona's official APT repository and `ps-84-lts` over HTTPS.

## Create data/secrets

```bash
sudo mkdir -p /srv/ktx/data/percona-01
sudo mkdir -p /srv/ktx/secrets/infrastructure/percona
sudo chmod 0700 /srv/ktx/secrets/infrastructure/percona
openssl rand -base64 36 | tr -d '\n' | sudo tee \
  /srv/ktx/secrets/infrastructure/percona/root-password >/dev/null
sudo chmod 0600 /srv/ktx/secrets/infrastructure/percona/root-password
```

## Compose

```bash
sudo mkdir -p /srv/ktx/containers/ktx-percona-01
sudo cp /srv/ktx/platform/templates/containers/percona/compose.yml.example \
  /srv/ktx/containers/ktx-percona-01/compose.yml
```

Production: no published port.

Dev-only example private mapping:

```yaml
ports:
  - "192.168.40.168:33601:3306"
```

## Start

```bash
cd /srv/ktx/containers/ktx-percona-01
sudo docker compose up -d
sudo /srv/ktx/platform/templates/scripts/ktx-network-reconcile.sh
```

First start initializes `/srv/ktx/data/percona-01` if empty.

## Verify

```bash
sudo docker logs --tail=200 ktx-percona-01
sudo docker exec ktx-percona-01 mysqladmin \
  --protocol=socket -uroot \
  -p"$(sudo cat /srv/ktx/secrets/infrastructure/percona/root-password)" ping
```

## Create a site database/user

Generate a site password and use the procedure in `05-SITES/05-database.md`. Application users get grants only on their own schema.

## Update

Build a new image from the same 8.4 LTS line, test with representative data on dev, back up prod, then recreate `ktx-percona-01` during a controlled maintenance window.

A Percona **major** upgrade is a migration project, not a casual image patch.

### Source

https://docs.percona.com/percona-server/8.4/apt-repo.html
