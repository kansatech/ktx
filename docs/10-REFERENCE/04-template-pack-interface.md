# KTX Module Interface

The detailed authoring specification is in [`docs/12-MODULES/`](../12-MODULES/README.md).

A module may assume:

```bash
ktx-net create INSTANCE
ktx-net show INSTANCE

ktx-web-route add ROUTE BACKEND_IP BACKEND_PORT DOMAIN [DOMAIN...]

ktx-ssh-route init LOGIN UPSTREAM_USER BACKEND_IP BACKEND_PORT
ktx-ssh-route authorize LOGIN CUSTOMER_PUBLIC_KEY_FILE
ktx-ssh-route trust LOGIN KNOWN_HOSTS_LINE_FILE
```

Send syslog TCP to the assigned network gateway `.1`, port 514.

A normal module must not assume Docker socket access, privileged mode, public host ports, permission to edit Host Core Traefik/sshd/firewall policy, or one shared flat Docker network.

Module source repositories normally live under `/srv/ktx/images/ktx-*`; instantiated server configuration lives under `/srv/ktx/containers`.
