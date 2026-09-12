# Host Core Configuration

Server-specific Host Core configuration lives under:

```text
/srv/ktx/config
```

It is deliberately ignored by `Kansatech/ktx`.

## Initialize

```bash
sudo /srv/ktx/bin/ktx-init-layout
```

This creates `/srv/ktx/config/host.conf` from the tracked default when it does not already exist.

## Host policy file

```text
/srv/ktx/config/host.conf
```

Example keys:

```text
KTX_ENV=prod
KTX_HOST=ktx-prod-26
KTX_DOCKER_POOL=172.28.0.0/16
KTX_NETWORK_PREFIX=ktx-net-
KTX_ADMIN_SSH_PORT=2222
KTX_PUBLIC_SSH_PORT=22
KTX_SYSLOG_PORT=514
KTX_ACME_EMAIL=admin@example.com
```

Tracked example:

```text
/srv/ktx/host/defaults/host.conf.example
```

Protect/own:

```bash
sudo chown root:root /srv/ktx/config/host.conf
sudo chmod 0644 /srv/ktx/config/host.conf
```

It should contain policy/configuration, not passwords or private keys. Secrets belong under `/srv/ktx/secrets`.

## Network registry

`ktx-net` maintains:

```text
/srv/ktx/config/networks.tsv
```

Treat this as server-specific configuration/state and back it up. It is not committed because allocations differ between hosts.
