# Update Traefik

1. Review the current supported Traefik branch and security advisories.
2. On build, download the exact desired release and verify its upstream checksum/signature metadata.
3. Put the binary into a new ignored `/srv/ktx/releases/<core-release>/` artifact set and update Host Core tracked version documentation; never overwrite an old promoted release.
4. Test static config and representative dynamic routes on build/dev.
5. Test new ACME issuance on a noncritical/test domain.
6. Promote the exact binary to prod.
7. Replace `/usr/local/sbin/traefik` atomically and restart only `traefik.service`.
8. Verify public HTTPS routes and logs.
9. Keep the prior binary/release for rollback.

As of 2026-09-11, Traefik 3.7 is in active/security support; 3.6 security support ended August 16, 2026.

Source: https://doc.traefik.io/traefik/deprecation/releases/
