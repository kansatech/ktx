# Operating Principles

1. **Host administration never depends on Docker.** OpenSSH remains native and independently reachable.
2. **Public ingress never gets the Docker socket.** Traefik uses the file provider; SSHPiper uses explicit working-directory routes.
3. **Workload IPs are deliberate.** KTX allocates a deterministic `/28` per workload instance and reserves `.2` for its primary service.
4. **Docker names are not an ingress contract.** Native services route by static private IP because the host does not use Docker's embedded DNS.
5. **Every public route is explicit.** A workload is invisible from the internet until a template pack creates a Traefik and/or SSHPiper route.
6. **No `latest`.** Native third-party binaries are pinned in a Host Core release.
7. **Build once, promote exact bytes.** SSHPiper is compiled on build, tested on dev, then the same binary goes to prod. Traefik follows the same artifact promotion model.
8. **Prod is not a compiler.** Go/build toolchains stay on build.
9. **Templates may add workloads; templates may not silently mutate KTX Core policy.** Host changes are a Host Core release.
10. **A fresh-host rebuild must be possible from docs + core release + backed-up host state.**
