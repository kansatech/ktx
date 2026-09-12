# Template Network Contract

Every future KTX template pack that needs Docker networking must document:

- the KTX network allocation name;
- which address is its primary ingress endpoint (`.2` by default);
- all companion addresses it reserves;
- internal listening ports;
- whether it requires web ingress, SSH ingress, neither, or both;
- whether it sends syslog to `.1:514`;
- any explicit host-published port exception.

Normal template pack flow:

```text
1. ktx-net create <instance>
2. read primary_ip
3. create container(s) with static address(es)
4. if web: ktx-web-route add ... primary_ip port domains...
5. if ssh: ktx-ssh-route init ... primary_ip port
6. send syslog to gateway .1:514
```

The template must not alter `/srv/ktx/config/traefik/traefik.yml`, host sshd, UFW defaults, or Docker daemon policy. If it needs those changes, it requires a KTX Host Core revision.
