# Update Docker Engine

Docker Engine is host software, not a Host Core binary artifact.

## Lifecycle

1. Review the Docker package/version you intend to install.
2. Update build first.
3. Verify `docker version`, Compose, user-defined bridge networks, static IP assignment, host-to-container reachability, and reboot behavior.
4. Update dev.
5. Exercise representative template workloads and native ingress.
6. Schedule prod.
7. Confirm recovery access/backups/state copy.
8. Upgrade prod packages.
9. Reboot if required.
10. Run `ktx-host-check` and representative ingress tests.

Do not combine a Docker major/runtime upgrade with a Traefik/SSHPiper upgrade unless there is a compelling reason; one variable at a time makes failures diagnosable.
