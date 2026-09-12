# Roll Back Host Core

## Source/config-template regression

Identify the previous known-good tag:

```bash
git -C /srv/ktx tag --sort=-creatordate
```

Checkout:

```bash
sudo git -C /srv/ktx checkout --detach vPREVIOUS
sudo /srv/ktx/bin/ktx-apply-host
```

Then validate and restart only the affected service(s).

Because `config/` is ignored, checking out an older tag does not automatically overwrite server-specific configuration. If the failed release required a config-format change, restore the compatible configuration backup explicitly.

## Binary regression

Restore the exact previous binary artifact from:

```text
/srv/ktx/releases/<previous-release>/
```

then restart only that service.

## Server-local state to protect before core changes

```text
/srv/ktx/config/
/srv/ktx/secrets/
/srv/ktx/data/traefik/
/srv/ktx/containers/
/etc/ssh/sshd_config.d/10-ktx-admin.conf
```

## Host package regression

Ubuntu/Docker/kernel rollback is a different class of change. Use provider snapshots/package recovery appropriate to the failure; Git checkout does not reverse a kernel upgrade.
