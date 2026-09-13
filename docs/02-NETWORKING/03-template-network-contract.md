# Template Network Contract

Every future KTX module that needs Docker networking must document:

- the KTX network allocation name;
- which address is its primary ingress endpoint (`.2` by default);
- all companion addresses it reserves;
- internal listening ports;
- whether it requires web ingress, SSH ingress, neither, or both;
- whether it sends syslog to `.1:514`;
- any explicit host-published port exception.

Normal module flow:

```text
1. /srv/ktx/bin/net create <instance>
2. read primary
3. create container(s) with static address(es)
4. if web: /srv/ktx/bin/web-route add ... primary port domains...
5. if ssh: /srv/ktx/bin/ssh-route init ... primary port
6. send syslog to gateway .1:514
```

The template must not alter `/srv/ktx/config/traefik/traefik.yml`, host sshd, UFW defaults, or Docker daemon policy. If it needs those changes, it requires a KTX Host Core revision.

Address notation `.1`/`.2` means subnet base + 1/+2. Always consume the `gateway` and `primary` values reported by `/srv/ktx/bin/net show`; later /28 allocations do not necessarily end in .1/.2. These host commands run through sudo, not from inside a workload.
