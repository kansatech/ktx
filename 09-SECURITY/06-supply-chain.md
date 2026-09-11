# Supply Chain

> **Purpose:** Use third-party software without losing reproducibility.

Prefer official upstream project/package sources, HTTPS, signatures/checksums where available, pinned versions, recorded provenance, and build/dev testing.

Deliberate dependencies include Docker's official repo, Percona official repo, Traefik, SSHPiper, restic, and (for PHP 8.5 on Ubuntu 24.04) the chosen third-party PHP packaging source.

“I build my own image” means the assembly recipe is yours. It does not make upstream code magically first-party.
