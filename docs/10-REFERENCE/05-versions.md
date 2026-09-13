# Baseline Versions

Verified for this documentation revision: **2026-09-11**.

Tracked pins live in:

```text
/srv/ktx/host/versions.env
```

Current baseline:

| Component | Baseline |
|---|---|
| Ubuntu | 24.04 LTS |
| Traefik | 3.7.13 |
| SSHPiper | 1.6.1 |
| Docker Engine | Docker CE package offered at install time from Docker's official Ubuntu repository |

Host Core update tooling installs the exact tracked Traefik/SSHPiper release and verifies `host/native-checksums.sha256`, committed from the official release manifests.
