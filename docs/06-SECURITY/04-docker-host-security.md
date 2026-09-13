# Docker Host Security

## Docker socket

`/var/run/docker.sock` is effectively a root-control interface. Only trusted host administrators and Docker itself should access it under the KTX Core model.

Traefik does not need it. SSHPiper does not need it. Workloads do not get it.

## Published ports

Native ingress means normal workloads use private static IPs rather than host `ports:` mappings. Any public mapping is an explicit exception and must be documented by that module.

## Docker group

Treat membership as privileged/root-equivalent.

## User-defined networks

Do not collapse isolated workload networks into a single shared bridge merely for convenience. Use the KTX network allocation model.

## Patching

Docker Engine updates are tested build -> dev -> prod as documented in lifecycle.
