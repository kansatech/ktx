# Host Core Backup Scope

Git restores portable source. A protected off-host backup restores host identity,
configuration, and state. Back up at least:

```text
/srv/ktx/config/                  includes private SSHPiper mapping keys
/srv/ktx/secrets/                 includes the public SSH listener's private host key
/srv/ktx/containers/              instance definitions; may contain credentials
/srv/ktx/data/                    native ACME and selected module state
/etc/ssh/                        OpenSSH policy and host identities
/etc/default/ssh
/etc/systemd/system/             enabled units, masks, and local overrides
/etc/systemd/system-generators/  sshd-socket-generator mask
/etc/ufw/
/etc/docker/daemon.json
/home/ktx/.ssh/authorized_keys    includes the SSHPiper mapping public key
```

Record the Host Core tag/commit, native binary versions/checksums, package
versions, and numeric service UIDs/GIDs. Retain approved archives if upstream
downloads cannot be relied upon during recovery. Module repositories and their
persistent data also need the backups required by their own procedures.

Preserve ownership, modes, symlinks, and ACLs (for example, use a backup tool with
ACL/xattr support). Encrypt the backup and restrict access: `config/` and ACME
state are confidential even though their paths are not named `secrets/`.

Take application-consistent module backups, and stop or quiesce writers when
capturing native state. Logs are optional according to retention policy. Keep a
source mirror/export if GitHub is not an acceptable single recovery dependency.
