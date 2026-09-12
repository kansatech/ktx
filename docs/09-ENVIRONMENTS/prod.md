# Production Host — ktx-prod-26

Prod consumes tested Host Core releases.

- no Go toolchain required;
- no compiling Host Core binaries;
- real ACME;
- public 80/443 and optionally 22;
- admin 2222 restricted to trusted source/private management;
- no normal public workload port mappings;
- no Docker socket access for ingress/workloads;
- security updates maintained;
- Host Core config/state included in recovery backup;
- changes recorded and rollback release retained.

If you find yourself SSH'd into prod compiling an ingress binary from GitHub master, the process has already left the road.
## Git role

Prod checks out an immutable Host Core tag in detached HEAD state. Never track `main` with blind `git pull` deployment. `/srv/ktx/images` may contain module checkouts only when operationally useful; production runtime does not require source trees for every image.

