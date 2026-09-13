# Supply-Chain Policy

Host Core installs Ubuntu packages from Ubuntu repositories and Docker CE/Compose
from Docker's official Ubuntu repository. The initial Docker package versions
are those offered by that repository at installation time, not pinned by a Host
Core tag. Record package versions when promoting an environment.

Traefik and SSHPiper use official upstream binary archives. `host/versions.env`
pins versions and `host/native-checksums.sha256` pins the archive bytes for x86_64
and arm64. The installer verifies the committed SHA-256 entry before extracting
only the expected daemon/plugin files. No Go toolchain or on-host compilation is
required, and services are not restarted by the binary installer.

When changing a native version, review its upstream release and advisories,
obtain its checksum manifest from the official release, update both tracked
files, and test the resulting archive on build/dev. Pinning a checksum protects
against changed download bytes; it is not independent signature verification or
a guarantee that upstream software is safe. Keep the trusted Git release and
approved archives available off-host for recovery.

Do not use unpinned `latest` URLs or pipe downloaded scripts into a root shell.
See [upstream references](../../SOURCES.md).
