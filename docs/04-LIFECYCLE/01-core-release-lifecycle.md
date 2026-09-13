# Host Core Git Release Lifecycle

`Kansatech/ktx` is promoted by immutable Git tag. The tag pins native dependency versions in `host/versions.env`.

```text
build
  change/test Host Core
  bump pinned Traefik/SSHPiper versions if needed
  /srv/ktx/bin/install-native ...
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
git -C /srv/ktx tag -a v2026.09.11-rc.1 -m "KTX Host Core 2026.09.11-rc.1"
git -C /srv/ktx push origin v2026.09.11-rc.1
```

Do not move an already promoted tag.

## Dev/prod checkout

```bash
git -C /srv/ktx fetch --tags
git -C /srv/ktx checkout --detach v2026.09.11-rc.1
sudo /srv/ktx/bin/validate-repo
```

If the release changes a pinned native component, install that exact pinned release:

```bash
sudo /srv/ktx/bin/install-native sshpiper
sudo /srv/ktx/bin/install-native traefik
```

`/srv/ktx/bin/install-native` downloads the version named by the checked-out tag and verifies the archive hash committed in `host/native-checksums.sha256` before installation.

Then:

```bash
sudo /srv/ktx/bin/apply-host
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

## This RC and upgrades from earlier revisions

Short commands are now in `/srv/ktx/bin`; update operator/module calls to the new
paths. `apply-host` removes only old KTX symlinks pointing to the former command
paths. It does not install global short aliases.

This RC changes SSH policy ownership and installation safety. An already
installed r1-r4 host must **not** rerun bootstrap or bypass completion guards.
Use the provider console, back up its complete SSH configuration/identity set,
review the tracked complete `host/ssh/sshd_config`, reconcile socket/generator
masks and the [permission table](../10-REFERENCE/03-service-accounts.md), then
validate effective policy before restarting. There is no tested automatic
migration from those revisions; first rehearse on a disposable copy of the host.

A Git checkout and `apply-host` do not update `/etc/ssh/sshd_config`, Docker
configuration, runtime Traefik configuration, or their state. Compare the release
diff with those installed files and apply only the relevant reviewed changes.
Native binaries are also a separate install step. Reverting a Git tag alone does
not restore host-local state.
