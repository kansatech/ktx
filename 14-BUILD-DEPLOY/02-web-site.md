# Build and Deploy a Site Web Container

> **Purpose:** Build the normal Apache + PHP-FPM + Composer + cron + sshd site runtime, then create one isolated site instance.

## Build the runtime image

```bash
export KTX_RELEASE=2026.09.10-r2
cd /srv/ktx/platform/templates/images/web-php85
sudo docker build \
  --build-arg KTX_BASE_RELEASE=${KTX_RELEASE} \
  -t ktx/web-php85:${KTX_RELEASE} .
```

Verify:

```bash
sudo docker run --rm ktx/web-php85:${KTX_RELEASE} php -v
sudo docker run --rm ktx/web-php85:${KTX_RELEASE} composer --version
sudo docker run --rm ktx/web-php85:${KTX_RELEASE} apachectl configtest
sudo docker run --rm ktx/web-php85:${KTX_RELEASE} php-fpm8.5 -tt
```

## Create site `example`

```bash
export SITE=example
sudo mkdir -p /srv/ktx/sites/${SITE}/{app,cron,ssh/hostkeys,config,restore}
sudo touch /srv/ktx/sites/${SITE}/ssh/authorized_keys
sudo chmod 0644 /srv/ktx/sites/${SITE}/ssh/authorized_keys
sudo mkdir -p /srv/ktx/secrets/sites/${SITE}
sudo chmod 0700 /srv/ktx/secrets/sites/${SITE}
```

Create its private network. The booleans are `database`, `mail`, and `ssh`; they become network labels used by reconciliation:

```bash
sudo /srv/ktx/platform/templates/scripts/ktx-site-network-create.sh ${SITE} true true true
sudo /srv/ktx/platform/templates/scripts/ktx-network-reconcile.sh
```

For a site with no SSH, for example, use `true true false`.

Copy templates:

```bash
sudo mkdir -p /srv/ktx/containers/ktx-web-${SITE}-01
sudo cp /srv/ktx/platform/templates/site/compose.yml.example \
  /srv/ktx/containers/ktx-web-${SITE}-01/compose.yml
sudo cp /srv/ktx/platform/templates/site/manifest.yml.example \
  /srv/ktx/sites/${SITE}/manifest.yml
sudo cp /srv/ktx/platform/templates/site/cron/ktx-site.example \
  /srv/ktx/sites/${SITE}/cron/ktx-site
```

Replace the template placeholders deliberately; do not run a global search/replace against `/srv/ktx`.

## SSH host keys

Generate once and persist:

```bash
sudo ssh-keygen -q -t ed25519 -N '' \
  -f /srv/ktx/sites/${SITE}/ssh/hostkeys/ssh_host_ed25519_key
```

The container template maps these into `/etc/ssh/ktx-hostkeys`; its sshd config points to those files.

## Start

```bash
cd /srv/ktx/containers/ktx-web-${SITE}-01
sudo docker compose config
sudo docker compose up -d
```

## Verify

```bash
sudo docker ps --filter name=ktx-web-${SITE}-01
sudo docker logs --tail=100 ktx-web-${SITE}-01
sudo docker exec ktx-web-${SITE}-01 curl -fsS http://127.0.0.1:8080/__ktx/health
```

Then test the public HTTPS domain through Traefik.

## Update runtime

Change only the immutable image tag in the site Compose/manifest and recreate:

```bash
sudo docker compose up -d --force-recreate
```

A plain `docker restart` does not load the new image.
