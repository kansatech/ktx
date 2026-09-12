# Production Environment

Production consumes tested Host Core tags and tested workload-module releases.

Public ingress:

```text
22/tcp   SSHPiper (including ktx host administration)
80/tcp   Traefik
443/tcp  Traefik
```

Native OpenSSH is key-only on `127.0.0.1:2222`; it is never exposed by the provider firewall or UFW.

Production does not normally build workload images. It deploys artifacts/releases already proven on build/dev.

Keep provider console/recovery access available because normal host SSH depends on SSHPiper.
