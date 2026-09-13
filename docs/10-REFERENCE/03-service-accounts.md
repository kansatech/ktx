# Service Accounts and Permissions

| Account | Purpose | Login |
|---|---|---|
| `ktx` | Existing human administrator, sudo-capable; owns the source checkout | SSH through reserved route |
| `root` | OS administration through console/sudo | No SSH |
| `sshpiper` | Native daemon and workingdir plugin | System account, nologin |
| `traefik` | Native web ingress | System account, nologin |
| `syslog` | Ubuntu rsyslog | System account |

KTX creates only the missing `sshpiper` and `traefik` service accounts.
It does not create `ktx`, change its password, or grant Docker-group membership.
Docker access uses sudo and remains root-equivalent.

| Path | Owner and access |
|---|---|
| `/home/ktx/.ssh`, `authorized_keys` | `ktx:ktx`, 0700 directory / 0600 file |
| `/srv/ktx/secrets` | root, private; named `sshpiper:--x` ACL permits traversal only |
| `/srv/ktx/secrets/sshpiper`, `server_key` | `sshpiper:sshpiper`, 0700 / 0600 |
| `/srv/ktx/config/sshpiper/routes`, route directories/files | `sshpiper:sshpiper`, 0700 / 0600 |
| `/srv/ktx/config/traefik`, `dynamic` | `root:traefik`, 0750 |
| Traefik static config | `root:traefik`, 0640 |
| Generated dynamic routes | root-owned, 0644 inside the restricted directory |
| `/srv/ktx/data/traefik`, `/srv/ktx/logs/traefik` | `traefik:traefik`, 0750 |
| ACME state | `traefik:traefik`, 0600 |
| `/srv/ktx/logs/remote` | `syslog:adm`, 0750; received files 0640 |
| `/srv/ktx/logs` | root; service traversal ACLs for `traefik` and `syslog` |

An ACL on a directory can make `ls -l` show additional group-mask bits.
Use `getfacl` to see the actual grants. SSHPiper's strict check concerns route
**files**: do not grant group/other bits or ACLs on those files. Its systemd unit
mounts route and secret trees read-only, even though the service owns the files.

`init-layout` creates missing top-level paths and leaves existing ownership,
permissions, and ACLs intact. `apply-host` installs unit/logging files only.
Neither command repairs restored service permissions; recovery must verify them.

Diagnostic examples:

```bash
sudo namei -l /srv/ktx/secrets/sshpiper/server_key
sudo getfacl /srv/ktx/secrets /srv/ktx/logs
sudo -u sshpiper test -r /srv/ktx/secrets/sshpiper/server_key
sudo -u traefik test -w /srv/ktx/logs/traefik
sudo -u syslog test -w /srv/ktx/logs/remote
```
