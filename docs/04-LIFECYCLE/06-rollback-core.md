# Roll Back Host Core

## Git/config rollback

Checkout the previous known-good Host Core tag:

```bash
git -C /srv/ktx fetch --tags
git -C /srv/ktx checkout --detach PREVIOUS_TAG
sudo /srv/ktx/bin/ktx-apply-host
```

## Native component rollback

The previous tag also contains the previous pinned Traefik/SSHPiper version. Reinstall only the component being rolled back:

```bash
sudo /srv/ktx/bin/ktx-install-native traefik
# or
sudo /srv/ktx/bin/ktx-install-native sshpiper
```

Then restart only that service.

For SSHPiper, use provider console/recovery access during rollback and prove `ssh ktx@host` externally before declaring recovery complete.

Server-local `config/` and `secrets/` are not rolled back automatically by Git. If the bad release changed their format, follow that release's migration/rollback notes.
