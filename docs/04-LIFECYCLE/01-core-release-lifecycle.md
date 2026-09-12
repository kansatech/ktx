# Host Core Git Release Lifecycle

`Kansatech/ktx` is deployed by immutable Git tag.

Server-specific `config/`, `secrets/`, `containers/`, and runtime state are **not** part of the tag.

## Flow

```text
ktx-build-26
  work/test on branch/main
  validate Host Core
  create immutable Git tag
  build/verify native binary artifacts
        |
        v
ktx-dev-26
  fetch exact tag
  checkout detached tag
  import exact binary artifacts
  ktx-apply-host
  test/reboot/integration
        |
        v
ktx-prod-26
  fetch exact same tag
  checkout detached tag
  import exact same binary artifacts
  ktx-apply-host
  restart only affected services
  verify
```

## Tagging

Example:

```bash
git -C /srv/ktx status
git -C /srv/ktx tag -a v2026.09.11-r2 -m "KTX Host Core 2026.09.11-r2"
git -C /srv/ktx push origin v2026.09.11-r2
```

Once promoted, do not move or replace a release tag.

## Dev deployment

```bash
git -C /srv/ktx fetch --tags
git -C /srv/ktx checkout --detach v2026.09.11-r2
sudo /srv/ktx/bin/ktx-apply-host
```

Validate changes before restarting the affected native service.

## Prod deployment

Use the exact tag that passed dev.

Never:

```bash
git pull
```

blindly on production `main`.

## Native binary artifacts

Traefik/SSHPiper binaries are not committed merely to make Git large. Build/verify them on build and store the approved binaries/checksums under ignored:

```text
/srv/ktx/releases/<core-release>/
```

Promote those exact bytes to dev and prod, or attach them to the corresponding controlled GitHub Release if you later standardize that workflow.

## Rule

Git version-controls the Host Core source/configuration defaults. Runtime state and secrets stay local. Binary promotion still follows build -> dev -> prod.
