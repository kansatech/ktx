# Weekly and Monthly Checks

## Weekly

- review `docker system df`;
- review `/srv/ktx/logs` growth;
- review auth and SSHPiper failures;
- inspect Traefik errors/ACME warnings;
- inspect workload network registry against `docker network ls`;
- verify no unexpected public listeners with `ss -lntup`;
- review pending security updates.

## Monthly

- test host-config recovery to a staging directory;
- compare running native binary versions with the approved Host Core manifest;
- review administrator SSH keys/firewall source ranges;
- review Traefik/SSHPiper supported versions/advisories;
- prune only understood Docker build/cache artifacts;
- rehearse a small Host Core rollback or disposable-host build periodically;
- verify this documentation still matches reality.
