# Full Host Rebuild

A full KTX Host Core rebuild starts from a clean Ubuntu 24.04 LTS host.

1. restore provider/VM console access;
2. manually create the sudo-capable `ktx` account with its local password;
3. clone `Kansatech/ktx` to `/srv/ktx` as `ktx` and check out the required Host Core tag;
4. follow root [`INSTALL.md`](../../INSTALL.md) through bootstrap, key installation, SSHPiper cutover, and finish;
5. restore ignored host-specific config/secrets from the protected backup source;
6. restore/re-clone module repositories under `/srv/ktx/images/`;
7. restore instance definitions/data according to the individual module recovery procedures;
8. recreate KTX networks/routes as recorded;
9. prove public HTTPS and each required SSH route;
10. run `ktx-host-check` and module-specific verification.

The `ktx` identity itself is a human/host prerequisite, not something reconstructed by `ktx-init`.

Because SSHPiper is in the host administration path, keep provider console access until the entire rebuild has been proven from an external SSH client.
