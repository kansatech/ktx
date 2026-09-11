# Build -> Dev -> Prod

> **Purpose:** Promote exactly tested bytes.

## Golden rule
**Build once. Test the exact artifact. Promote the exact artifact.**

### Build
```bash
docker build --pull -t ktx/web-php85:2026.09.10-r2 /srv/ktx/platform/images/web-php85
mkdir -p /srv/ktx/releases/2026.09.10-r2
docker save ktx/web-php85:2026.09.10-r2 | zstd -T0 -19 > /srv/ktx/releases/2026.09.10-r2/ktx-web-php85.tar.zst
cd /srv/ktx/releases/2026.09.10-r2 && sha256sum *.tar.zst > SHA256SUMS
```
Record package/runtime versions and image ID in a release manifest.

### Dev
Securely copy release bundle, verify checksums, load exact image:
```bash
sha256sum -c SHA256SUMS
zstd -dc ktx-web-php85.tar.zst | docker load
```
Recreate representative sites and test PHP/Apache, WordPress/Symfony, DB, mail, cron, SSH, uploads, logs, proxy/TLS and memory.

### Prod
Copy the **same files** dev tested. Verify checksums. Load image. Change a small batch to the exact new tag and recreate. Monitor, then continue.

## Restart vs recreate
`docker restart` uses the same existing container/image. To apply a new image/config, use Compose recreation such as:
```bash
docker compose up -d --force-recreate
```

Never rebuild on prod.
