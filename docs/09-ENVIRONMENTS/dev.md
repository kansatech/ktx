# Dev Host — ktx-dev-26

Dev validates the exact Host Core release produced by build.

- no normal recompilation of SSHPiper;
- install exact promoted Traefik/SSHPiper binaries;
- exercise deterministic networks;
- exercise native Traefik route creation/removal;
- exercise SSHPiper route creation/removal;
- permit private/debug workload port mappings only when a template pack documents them;
- use staging ACME/test domains during repeated certificate tests;
- use sanitized/nonproduction workload data.

A release is not approved for prod until dev has survived a restart/reboot and representative workload routing.
## Git role

Dev checks out the exact Host Core tag selected on build. Module source/templates may be cloned under `/srv/ktx/images`, but dev consumes the exact built image artifact rather than rebuilding it.

