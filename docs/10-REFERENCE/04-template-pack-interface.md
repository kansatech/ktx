# KTX Module Interface

The detailed authoring specification is in [`docs/12-MODULES/`](../12-MODULES/README.md).

A module may assume:

```bash
sudo /srv/ktx/bin/net create INSTANCE
sudo /srv/ktx/bin/net show INSTANCE

sudo /srv/ktx/bin/web-route add ROUTE BACKEND_IP BACKEND_PORT DOMAIN [DOMAIN...]

sudo /srv/ktx/bin/ssh-route init LOGIN UPSTREAM_USER BACKEND_IP BACKEND_PORT
sudo /srv/ktx/bin/ssh-route authorize LOGIN CUSTOMER_PUBLIC_KEY_FILE
sudo /srv/ktx/bin/ssh-route trust LOGIN KNOWN_HOSTS_LINE_FILE
```

Send syslog TCP to the assigned network gateway `.1`, port 514.

A normal module must not assume Docker socket access, privileged mode, public host ports, permission to edit Host Core Traefik/sshd/firewall policy, or one shared flat Docker network.

Module source repositories normally live under `/srv/ktx/images/ktx-*`; instantiated server configuration lives under `/srv/ktx/containers`.

Address notation `.1`/`.2` means subnet base + 1/+2. Always consume the `gateway` and `primary` values reported by `/srv/ktx/bin/net show`; later /28 allocations do not necessarily end in .1/.2. These host commands run through sudo, not from inside a workload.
