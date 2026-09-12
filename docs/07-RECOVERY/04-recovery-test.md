# Recovery Test

Periodically, on a disposable VM/VPS:

- bootstrap Ubuntu;
- clone `Kansatech/ktx` to `/srv/ktx`;
- checkout one approved Host Core Git tag;
- run `ktx-init-layout`;
- restore a copy of ignored Host Core config/secrets/state;
- install the exact approved native binary artifacts;
- run `ktx-apply-host`;
- recreate several workload networks;
- launch disposable dummy HTTP/SSH backends at recorded static IPs;
- verify native Traefik and SSHPiper routing;
- verify host admin SSH remains independent;
- verify rsyslog reception;
- record undocumented assumptions and fix the handbook.

A disaster-recovery document that has never met a blank machine is still speculative fiction.
