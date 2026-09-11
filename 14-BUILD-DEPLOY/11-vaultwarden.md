# Build and Deploy `ktx-vaultwarden-01`

> **Purpose:** Build a pinned Vaultwarden release locally, keep its database/data persistent, and terminate TLS at Traefik.

## Version

As of this revision, Vaultwarden **1.37.2** is current and specifically required for compatibility with newer 2026.8+ Bitwarden clients.

```bash
export VAULTWARDEN_VERSION=1.37.2
export KTX_RELEASE=2026.09.10-r2
```

## Build locally from pinned upstream source

Vaultwarden has a non-trivial Rust + web-vault build. Rather than copy/fork its generated Dockerfile into KTX and slowly diverge, KTX uses the pinned upstream source build recipe, then retags the locally built image into the KTX release namespace.

On `ktx-build-26`:

```bash
mkdir -p /srv/ktx/images/vendor-src
cd /srv/ktx/images/vendor-src
rm -rf vaultwarden-${VAULTWARDEN_VERSION}
git clone --depth 1 --branch ${VAULTWARDEN_VERSION} \
  https://github.com/dani-garcia/vaultwarden.git \
  vaultwarden-${VAULTWARDEN_VERSION}
cd vaultwarden-${VAULTWARDEN_VERSION}
```

Build the Debian image using upstream's checked-in bake helper, which fills its source/version metadata:

```bash
docker/bake.sh debian
```

The default single-architecture Debian bake uses Docker output, so the image is loaded into the local Docker image store.

Find the locally generated tag with `docker image ls`, then tag it immutably into KTX, for example:

```bash
docker tag vaultwarden/server:testing ktx/vaultwarden:${KTX_RELEASE}
```

Before promotion, confirm:

```bash
docker run --rm ktx/vaultwarden:${KTX_RELEASE} /vaultwarden --version
```

Record the actual Vaultwarden and bundled Web Vault versions in the KTX release manifest.

## Data/secrets

```bash
sudo mkdir -p /srv/ktx/data/vaultwarden-01
sudo chmod 0700 /srv/ktx/data/vaultwarden-01
sudo mkdir -p /srv/ktx/secrets/infrastructure/vaultwarden
sudo chmod 0700 /srv/ktx/secrets/infrastructure/vaultwarden
```

Create the protected runtime environment file:

```bash
sudo install -m 0600 /dev/null /srv/ktx/secrets/infrastructure/vaultwarden/vaultwarden.env
TOKEN="$(openssl rand -base64 48)"
printf 'ADMIN_TOKEN=%s\n' "$TOKEN" | sudo tee /srv/ktx/secrets/infrastructure/vaultwarden/vaultwarden.env >/dev/null
unset TOKEN
```

A long random token works as the initial admin credential. If you choose Vaultwarden's Argon2 PHC form later, generate it with the pinned Vaultwarden image and preserve the complete value exactly. Never commit the env file to Git.

## Network/Compose

```bash
sudo /srv/ktx/platform/templates/scripts/ktx-app-network-create.sh vaultwarden true false
sudo /srv/ktx/platform/templates/scripts/ktx-network-reconcile.sh

sudo mkdir -p /srv/ktx/containers/ktx-vaultwarden-01
sudo cp /srv/ktx/platform/templates/containers/vaultwarden/compose.yml.example \
  /srv/ktx/containers/ktx-vaultwarden-01/compose.yml
```

Edit:

- `DOMAIN=https://vault.example.com`
- KTX image release
- protected `vaultwarden.env` contents
- signup policy
- SMTP sender/from settings appropriate to your relay/domain; the template already points SMTP at `ktx-mail-01`

Start:

```bash
cd /srv/ktx/containers/ktx-vaultwarden-01
sudo docker compose up -d
```

## Verify

```bash
sudo docker logs --tail=150 ktx-vaultwarden-01
sudo docker exec ktx-vaultwarden-01 /vaultwarden --version
curl -I https://vault.example.com/
```

Use the Vaultwarden diagnostics page after upgrades.

## TLS

Vaultwarden's web vault requires HTTPS/secure context. Traefik owns TLS; do not enable a second public TLS listener inside Vaultwarden.

## Backup

Back up `/srv/ktx/data/vaultwarden-01` according to the database backend in use. The template uses Vaultwarden's default SQLite storage; ensure backup timing/consistency is handled according to Vaultwarden guidance.

## Update

Clone/build the new pinned release on build, test on dev with a copy of Vaultwarden data, promote the exact image, and recreate the container using the same persistent data directory.

### Sources

- https://github.com/dani-garcia/vaultwarden/releases
- https://github.com/dani-garcia/vaultwarden/blob/main/README.md
- https://github.com/dani-garcia/vaultwarden/blob/main/docker/README.md
