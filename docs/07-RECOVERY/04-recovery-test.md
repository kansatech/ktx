# Host Recovery Test

Periodically rehearse on a disposable VM/VPS:

- clone a known Host Core tag;
- complete the `INSTALL.md` flow;
- prove temporary `ktx` password SSH;
- install a public key;
- run the SSHPiper cutover;
- prove `ssh ktx@host` after cutover;
- complete Docker/Traefik/rsyslog setup;
- restore representative server-local config;
- restore/recreate at least one module instance.

Record any undocumented assumption and fix the playbook immediately.
