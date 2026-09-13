# Rebuild a Host

Start with a fresh Ubuntu 24.04 host and provider/VM console access. The
sudo-capable `ktx` account is a host prerequisite and must already exist.

1. Follow [INSTALL.md](../../INSTALL.md) using the required Host Core release.
   Prove its temporary and final key-only login paths. This establishes packages,
   service accounts, permissions, and a known working recovery point.
2. Stage the trusted backup privately. Use [Restore host configuration](02-restore-host-config.md)
   from the console to replace the matching SSH identities/routes together,
   restore native state, and reconcile ownership/ACLs. The newly created mapping
   key must not be left paired with an old restored upstream authorization file.
3. Recreate missing Docker networks with their recorded subnet, gateway, and
   bridge names before starting restored workloads. Do not allocate replacement
   addresses just because an old registry row already exists.
4. Re-clone the required module releases under `/srv/ktx/images`, then restore
   instance definitions and data using each module's recovery instructions.
5. Restore reviewed UFW/provider policy and verify public exposure. Prove a fresh
   administrator login, representative workload SSH/HTTPS, logs, and a reboot.

Restoring the old public SSH identity avoids a deliberate identity change for
clients. If you instead rotate it, distribute and verify the new fingerprint
through a trusted channel. Keep the console until external access is proven.
