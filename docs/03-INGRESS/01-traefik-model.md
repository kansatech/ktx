# Traefik Ingress Model

Traefik's install configuration is stable host state:

```text
/srv/ktx/config/traefik/traefik.yml
```

Workload routing is dynamic host state:

```text
/srv/ktx/config/traefik/dynamic/*.yml
```

The file provider watches the directory and automatically reloads valid changes. No Traefik restart is required when a future template adds/removes a route.

## Traffic path

```text
client -> :443 native Traefik -> private static workload IP:port
```

## TLS

Traefik owns ACME and certificate renewal. Workloads normally serve plain HTTP on private Docker networks.

## No Docker provider

KTX does not enable Traefik's Docker provider and does not give Traefik `/var/run/docker.sock`.

## Failure boundary

If Traefik is down, public websites are down, but host SSH administration still works on 2222 and workloads remain running privately.
