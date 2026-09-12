# Update Traefik

1. Review the supported Traefik branch and relevant security advisories.
2. Change `TRAEFIK_VERSION` in `host/versions.env` on build.
3. Install the pinned release with:

   ```bash
   sudo ./bin/ktx-install-native traefik
   ```

4. Test static configuration, watched dynamic routes, redirects, and ACME on build/dev.
5. Commit/tag the Host Core release.
6. Checkout the exact tag on prod.
7. Run the same `ktx-install-native traefik` command; the installer verifies the upstream checksum for the pinned release.
8. Restart only `traefik.service`.
9. Verify HTTPS routes/logs/certificates.

Do not use an unpinned `latest` binary.

As of 2026-09-11, Traefik 3.7 is in active/security support and 3.7.13 contains a current security fix.

Sources:
- https://doc.traefik.io/traefik/deprecation/releases/
- https://github.com/traefik/traefik/security/advisories/GHSA-qqjf-53cj-pwvv
