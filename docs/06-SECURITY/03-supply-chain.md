# Supply-Chain Policy

Host Core consumes upstream software, so KTX makes provenance explicit.

- Ubuntu packages: Ubuntu repositories.
- Docker: Docker official Ubuntu repository.
- Traefik: official GitHub release, pinned version, published checksum verified on build.
- SSHPiper: exact signed/tagged upstream Git revision compiled on build.
- Go: official Go distribution on build only.

Rules:

1. No `curl ... | sudo sh` on prod.
2. No `latest` release URLs in prod procedures.
3. Build records exact versions/checksums/source commit.
4. Dev and prod receive exact promoted Host Core artifacts.
5. Review security advisories for internet-facing components before routine upgrades.
