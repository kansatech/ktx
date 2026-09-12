# Update SSHPiper

1. Review upstream tags/security changes.
2. Build the exact tag on `ktx-build-26` using the approved Go toolchain.
3. Test `workingdir` routing, downstream public keys, mapping-key auth, strict host-key validation, SCP/SFTP, and port forwarding if you permit them.
4. Promote exact binaries to dev, then prod.
5. Replace binaries atomically.
6. Restart `sshpiper.service`.
7. Existing route directories remain in `/srv/ktx/config/sshpiper/routes`.
8. Verify several routes and inspect logs.

Do not use a build from `master` as production merely because it compiled successfully.

Review upstream advisories; older SSHPiper versions had a proxy-protocol source-address spoofing issue patched in v1.3.0, one reason KTX pins current releases rather than treating SSH infrastructure as set-and-forget.
