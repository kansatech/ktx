# Host Incident Response

If the **host/control plane** may be compromised:

1. preserve provider console access;
2. isolate public ingress at provider firewall if needed;
3. preserve relevant logs/config/state and timestamps;
4. determine whether Docker socket/root/kernel access may have been obtained;
5. rotate host administrator credentials and any host-held ingress/ACME/SSH material whose exposure is plausible;
6. if root/control-plane compromise is credible, prefer rebuilding a fresh host from trusted Host Core artifacts over attempting to disinfect it;
7. restore workload state according to each template pack;
8. update Host Core controls/documentation based on root cause.

A compromised workload alone is a template/workload incident until evidence indicates host escape. Do not assume every container is compromised without evidence, but do not trust the host if Docker/root/kernel control was obtained.
