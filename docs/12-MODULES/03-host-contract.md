# Host Core Contract for Modules

A module may assume Host Core provides:

## Docker

Docker Engine and Compose plugin are installed.

The module may not assume Docker socket access from its containers.

## Deterministic workload network

Allocate:

```bash
sudo ktx-net create INSTANCE
sudo ktx-net show INSTANCE
```

Each workload receives a `/28`. The baseline convention reserves:

```text
.1  Docker bridge/gateway/host-side endpoint
.2  module's primary service endpoint
```

A module documents any additional static addresses it consumes.

## Optional HTTPS ingress

Register:

```bash
sudo ktx-web-route add ROUTE BACKEND_IP BACKEND_PORT DOMAIN [DOMAIN...]
```

The module does not edit Traefik static configuration.

## Optional SSH ingress

Register through:

```bash
sudo ktx-ssh-route ...
```

The module does not publish arbitrary SSH ports or edit host sshd.

## Logging

A module may send syslog TCP to its workload network gateway `.1` on port 514.

## Persistent paths

Instances use:

```text
/srv/ktx/containers/<instance>   configuration/compose
/srv/ktx/data/<instance>         persistent data
/srv/ktx/secrets/<instance>      secrets
/srv/ktx/logs/<instance>         host-visible logs when applicable
```

## Forbidden assumptions

A normal module must not require:

- privileged mode;
- host root filesystem mounts;
- Docker socket;
- public host ports;
- edits to Host Core firewall/Traefik/sshd policy;
- a shared flat network with unrelated workloads.

An exception requires explicit Host Core architecture review.
