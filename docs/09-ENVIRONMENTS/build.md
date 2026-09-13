# Build Host — build.example.invalid

Build exists to create trusted Host Core artifacts and future template artifacts.

Allowed/expected:

- Git/source checkouts;
- pinned upstream native binaries (no Go toolchain is required);
- compilers/build utilities needed by future modules;
- direct upstream downloads used to create pinned releases;
- test Docker networks and disposable workloads.

Avoid:

- production secrets/customer data;
- acting as the only copy of source or release artifacts;
- exposing unnecessary public services.

Traefik/SSHPiper can run here for integration tests, but public ACME should normally use staging/test domains.
## Git role

`/srv/ktx` is the working `Kansatech/ktx` clone. This is where Host Core changes are developed/tested/tagged. Module repos are cloned under `/srv/ktx/images` and built here.

