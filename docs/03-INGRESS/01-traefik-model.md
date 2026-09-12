# Traefik Ingress Model

Traefik runs natively and owns TCP 80/443.

It uses the file provider watching:

```text
/srv/ktx/config/traefik/dynamic
```

KTX route tooling creates/removes small dynamic YAML files. Traefik notices them without a service restart and without Docker API/socket access.

Workloads use deterministic private addresses, for example:

```text
example.com -> Traefik -> http://172.28.4.2:8080
```

TLS/ACME belongs to Traefik; workload containers normally speak plain HTTP on their private KTX network.

If Traefik is down, public web routes are down. Host SSH is unaffected because it uses SSHPiper on port 22.
