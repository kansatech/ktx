# Full Host Rebuild

A full host rebuild begins from a fresh Ubuntu 24.04 LTS machine.

1. restore/provider console access;
2. clone the intended `Kansatech/ktx` tag to `/srv/ktx`;
3. follow root [`INSTALL.md`](../../INSTALL.md) to establish `ktx` and the SSHPiper-backed SSH path;
4. restore server-local Host Core `config/` and `secrets/` as appropriate rather than blindly overwriting newly generated SSH state;
5. restore the network registry and persistent data required by modules;
6. clone the exact module repositories/tags under `/srv/ktx/images`;
7. restore instance definitions under `/srv/ktx/containers`;
8. recreate module workloads according to their own recovery docs;
9. verify web and SSH routes;
10. verify backups/monitoring.

Because SSHPiper is in the host administration path, keep provider console access until the entire rebuild has been proven from an external SSH client.
