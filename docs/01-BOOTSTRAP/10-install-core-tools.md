# Install KTX Core Tools

KTX helper commands are tracked directly in `/srv/ktx/bin`.

Do not copy them into another source directory. Install stable command names as symlinks:

```bash
sudo /srv/ktx/bin/ktx-apply-host
```

This creates links such as:

```text
/usr/local/sbin/ktx-net       -> /srv/ktx/bin/ktx-net
/usr/local/sbin/ktx-web-route -> /srv/ktx/bin/ktx-web-route
/usr/local/sbin/ktx-ssh-route -> /srv/ktx/bin/ktx-ssh-route
/usr/local/sbin/ktx-host-check -> /srv/ktx/bin/ktx-host-check
```

It also links tracked Host Core systemd/rsyslog/logrotate files into their native system locations and runs:

```bash
systemctl daemon-reload
```

It **does not restart services**. That is deliberate: a Git checkout should never silently bounce production ingress.

## Verify

```bash
readlink -f /usr/local/sbin/ktx-net
ktx-net list
ktx-host-check
```

The first path should resolve into `/srv/ktx/bin`.
