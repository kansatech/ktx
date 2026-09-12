# Host Core Git Release Lifecycle

`Kansatech/ktx` is promoted by immutable Git tag. The tag pins native dependency versions in `host/versions.env`.

```text
build
  change/test Host Core
  bump pinned Traefik/SSHPiper versions if needed
  ktx-install-native ...
  integration test
  create immutable tag
        |
        v
dev
  checkout exact tag
  install the pinned native releases
  test SSH/web/network/reboot behavior
        |
        v
prod
  checkout exact same tag
  install only the native component(s) changed
  apply tracked files
  restart only affected services
  verify
```

## Tagging

```bash
git -C /srv/ktx status
git -C /srv/ktx tag -a v2026.09.11-r3 -m "KTX Host Core 2026.09.11-r3"
git -C /srv/ktx push origin v2026.09.11-r3
```

Do not move an already promoted tag.

## Dev/prod checkout

```bash
git -C /srv/ktx fetch --tags
git -C /srv/ktx checkout --detach v2026.09.11-r3
sudo /srv/ktx/bin/ktx-validate-repo
```

If the release changes a pinned native component, install that exact pinned release:

```bash
sudo /srv/ktx/bin/ktx-install-native sshpiper
sudo /srv/ktx/bin/ktx-install-native traefik
```

`ktx-install-native` downloads the version named by the checked-out tag and verifies the upstream release checksum before installation.

Then:

```bash
sudo /srv/ktx/bin/ktx-apply-host
```

and restart only the service the release actually changed.

## Server-local state

The Git tag does not own:

```text
config/
secrets/
images/
containers/
data/
logs/
```

Those remain server-specific and require their own backup/recovery plan.
