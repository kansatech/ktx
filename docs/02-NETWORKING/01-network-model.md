# Private Workload Network Model

Native Traefik and SSHPiper must be able to reach Docker workloads without Docker API discovery. KTX solves this with deterministic user-defined bridge networks.

## Default pool

Examples use:

```text
172.28.0.0/16
```

**Change it before production if it conflicts with your LAN, VPN, cloud network, or routes.**

Each workload instance receives one `/28`:

```text
16 total IPv4 addresses
14 usable host addresses
```

KTX reserves:

| Address | Meaning |
|---|---|
| `.0` | network |
| `.1` | Docker bridge gateway / host endpoint / syslog target |
| `.2` | template's primary service |
| `.3-.14` | optional companion containers/services |
| `.15` | broadcast |

Example:

```text
ktx-net-example
172.28.4.0/28

172.28.4.1   host bridge gateway
172.28.4.2   primary workload service
172.28.4.3   optional companion
...
```

## Why `/28`

It is large enough for multi-container template packs while making allocation and human inspection easy. A `/16` contains 4096 `/28` networks—far beyond this platform's expected scale.

## Host routing

The Linux host can directly reach containers on these user-defined bridge subnets. Native Traefik can therefore route to `http://172.28.4.2:8080`, and native SSHPiper can route to `172.28.4.2:2222`, without publishing either port on the public host.

## No shared flat customer network

Separate workload networks reduce lateral reachability. A template pack may create a deliberate shared/service network only when its own documentation explains why.
