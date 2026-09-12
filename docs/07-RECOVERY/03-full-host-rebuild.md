# Full Host Rebuild

This is the blank-VPS / dead-host procedure.

## Required materials

- Ubuntu 24.04 install/reimage access;
- administrator SSH key;
- GitHub access to `Kansatech/ktx`;
- the exact previously approved Host Core Git tag;
- approved native binary artifacts or the controlled means to rebuild/fetch them;
- backup of `/srv/ktx/config`, `/srv/ktx/secrets`, and required data/containers;
- separate module/workload recovery sets;
- DNS/provider/firewall access.

## Order

1. install/reimage Ubuntu 24.04;
2. patch and install Git;
3. clone:
   ```bash
   sudo git clone https://github.com/Kansatech/ktx.git /srv/ktx
   ```
4. checkout the previously approved Host Core tag;
5. run:
   ```bash
   sudo /srv/ktx/bin/ktx-init-layout
   ```
6. restore server-specific `config/`, `secrets/`, required `data/`, and `containers/`;
7. configure/verify host administrator sshd;
8. install Docker;
9. install/promote the exact approved Traefik/SSHPiper binaries;
10. run:
    ```bash
    sudo /srv/ktx/bin/ktx-apply-host
    ```
11. start/verify native Traefik, SSHPiper, and rsyslog;
12. configure firewall;
13. recreate deterministic Docker networks from the restored registry;
14. clone/restore required KTX module repositories under `/srv/ktx/images` as their lifecycle requires;
15. restore workload instances according to those modules;
16. verify public ingress and logging.

The Git repository reconstructs the host framework; ignored server state reconstructs this particular host.
