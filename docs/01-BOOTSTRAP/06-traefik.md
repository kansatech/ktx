# Install Native Traefik

Traefik is KTX Host Core's native public HTTP/HTTPS ingress service.

## Source and release rule

The pinned Traefik version is selected/tested on `ktx-build-26`. Dev and prod install the **exact promoted binary artifact**, not `latest` downloaded independently.

Approved artifacts live outside Git under:

```text
/srv/ktx/releases/<host-core-release>/artifacts/traefik
```

## 1. Create service account

```bash
sudo useradd --system --home /nonexistent --shell /usr/sbin/nologin traefik || true
```

## 2. Initialize KTX local paths

```bash
sudo /srv/ktx/bin/ktx-init-layout
```

Set ownership after the service account exists:

```bash
sudo chown root:traefik /srv/ktx/config/traefik
sudo chown root:traefik /srv/ktx/config/traefik/traefik.yml
sudo chmod 0750 /srv/ktx/config/traefik
sudo chmod 0640 /srv/ktx/config/traefik/traefik.yml

sudo chown -R root:traefik /srv/ktx/config/traefik/dynamic
sudo chmod 0750 /srv/ktx/config/traefik/dynamic

sudo chown -R traefik:traefik /srv/ktx/data/traefik
sudo chown -R traefik:adm /srv/ktx/logs/traefik
sudo chmod 0750 /srv/ktx/data/traefik /srv/ktx/logs/traefik

sudo install -o traefik -g traefik -m 0600 /dev/null /srv/ktx/data/traefik/acme.json
```

Edit this host's ignored configuration:

```text
/srv/ktx/config/traefik/traefik.yml
```

At minimum set the real ACME email.

## 3. Install promoted binary

Example:

```bash
RELEASE=2026.09.11-r2

cd "/srv/ktx/releases/${RELEASE}"
sha256sum -c SHA256SUMS

sudo install -o root -g root -m 0755   artifacts/traefik   /usr/local/sbin/traefik
```

## 4. Apply tracked Host Core files

```bash
sudo /srv/ktx/bin/ktx-apply-host
```

This links the tracked `traefik.service` unit from `/srv/ktx/host/systemd`.

## 5. Start

```bash
sudo systemctl enable --now traefik
sudo systemctl status traefik --no-pager
```

## 6. Verify

```bash
sudo ss -lntp | grep -E ':(80|443)\b'
sudo journalctl -u traefik -n 100 --no-pager
sudo tail -n 50 /srv/ktx/logs/traefik/traefik.log
```

## Dynamic routes

Traefik watches:

```text
/srv/ktx/config/traefik/dynamic
```

Modules register web routes through `ktx-web-route`. No Docker socket/provider is required.

## HTTP -> HTTPS and ACME

Host Core redirects HTTP to HTTPS. Traefik itself handles ACME challenge traffic; workload containers do not need Certbot or a `/.well-known` exception.

Sources:
- https://doc.traefik.io/traefik/providers/file/
- https://doc.traefik.io/traefik/reference/install-configuration/entrypoints/
- https://doc.traefik.io/traefik/deprecation/releases/
