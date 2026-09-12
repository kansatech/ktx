# Restore Host Configuration

After recloning the correct Host Core release:

1. run `/srv/ktx/bin/ktx-init-layout`;
2. restore `/srv/ktx/config`;
3. restore `/srv/ktx/secrets`;
4. restore required `/srv/ktx/data` native state such as Traefik ACME;
5. restore `/srv/ktx/containers` if those instance definitions are part of this recovery;
6. restore host administrator sshd drop-in if not recreated manually;
7. run `/srv/ktx/bin/ktx-apply-host`;
8. validate configs;
9. restart/reload affected native services;
10. recreate deterministic Docker networks from `config/networks.tsv` if necessary;
11. restore modules/workloads according to their separate repositories.

Git restores source. The recovery set restores the server's identity/state.
