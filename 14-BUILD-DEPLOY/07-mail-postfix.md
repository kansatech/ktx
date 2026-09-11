# Build and Deploy `ktx-mail-01` (Postfix Relay)

> **Purpose:** Give all sites one internal SMTP endpoint while keeping external-provider credentials centralized.

## Build

```bash
export KTX_RELEASE=2026.09.10-r2
cd /srv/ktx/platform/templates/images/mail
sudo docker build \
  --build-arg KTX_BASE_RELEASE=${KTX_RELEASE} \
  -t ktx/mail:${KTX_RELEASE} .
```

## Create config/secrets

```bash
sudo mkdir -p /srv/ktx/containers/ktx-mail-01
sudo mkdir -p /srv/ktx/data/mail-01/spool
sudo mkdir -p /srv/ktx/secrets/infrastructure/mail
sudo chmod 0700 /srv/ktx/secrets/infrastructure/mail

sudo cp /srv/ktx/platform/templates/postfix/main.cf.example \
  /srv/ktx/containers/ktx-mail-01/main.cf
sudo cp /srv/ktx/platform/templates/postfix/sender_relay.example \
  /srv/ktx/containers/ktx-mail-01/sender_relay
sudo cp /srv/ktx/platform/templates/postfix/sasl_passwd.example \
  /srv/ktx/secrets/infrastructure/mail/sasl_passwd
sudo chmod 0600 /srv/ktx/secrets/infrastructure/mail/sasl_passwd
```

Edit the relay host mappings and credentials.

## Build Postfix hash maps

The container entrypoint runs `postmap` for mounted map files before starting Postfix. It does not print credentials.

## Compose/start

```bash
sudo cp /srv/ktx/platform/templates/containers/mail/compose.yml.example \
  /srv/ktx/containers/ktx-mail-01/compose.yml

cd /srv/ktx/containers/ktx-mail-01
sudo docker compose up -d
sudo /srv/ktx/platform/templates/scripts/ktx-network-reconcile.sh
```

There is **no host SMTP port mapping** on prod.

## Verify

```bash
sudo docker exec ktx-mail-01 postfix check
sudo docker exec ktx-mail-01 postqueue -p
sudo docker logs --tail=100 ktx-mail-01
```

From a site network/container, send a test message and trace its queue ID in the relay log.

## Dev

Use a safe relay/test account or recipient restriction. A copied production cron job should not be capable of sending real customer mail from dev.

### Sources

- https://www.postfix.org/SASL_README.html
- https://www.postfix.org/postconf.5.html
