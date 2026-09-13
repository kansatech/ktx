# Restore Host Configuration

Use the provider console. Stage a trusted backup in a root-only directory under
`/srv/ktx/recovery`; do not overwrite a live `ktx` SSH route piecemeal over SSH.
For a replacement host, first follow [the rebuild procedure](03-full-host-rebuild.md).

1. Verify the backup's Host Core release and restore scope. Keep a copy of the
   currently working configuration/keys before replacing anything.
2. Stop affected writers/services from the console. Restoring SSH identity means
   stopping SSHPiper and OpenSSH; expect proxied sessions to disconnect.
3. Restore configuration, secrets, selected native state, and instance definitions
   with modes/ownership/ACLs. Do not blindly copy all of `/etc` onto a new Ubuntu
   installation; compare the backed-up KTX files and apply the required settings.
4. Restore the **matching SSH identity set together**: route mapping key and caller
   keys, `/home/ktx/.ssh/authorized_keys`, OpenSSH host key, SSHPiper `server_key`,
   and route `known_hosts`. Replacing only one can break the two-hop login.
5. Reconcile numeric UIDs/GIDs with the replacement host's accounts and verify the
   [permission table](../10-REFERENCE/03-service-accounts.md). Confirm the traversal
   ACLs on `secrets/` and `logs/`; do not broadly chmod either tree.
6. Install the reviewed tracked units using `sudo /srv/ktx/bin/apply-host`.
   Review/install `host/ssh/sshd_config` as the complete `/etc/ssh/sshd_config`,
   and retain the socket/generator masks established during installation.
7. Validate and start the affected services; for a full native-state restore:

   ```bash
   sudo /usr/sbin/sshd -t
   sudo rsyslogd -N1
   sudo dockerd --validate --config-file=/etc/docker/daemon.json
   sudo logrotate --debug /etc/logrotate.d/ktx-remote
   sudo systemctl daemon-reload
   sudo systemctl start ssh
   sudo systemctl start sshpiper
   sudo systemctl start docker rsyslog traefik
   sudo /srv/ktx/bin/host-check
   ```

8. Prove a fresh external key-only `ktx` login before leaving the console. Restore
   deterministic Docker networks, module data, and module routes as required.
   Use [network recovery](../02-NETWORKING/02-network-allocation.md) for a registry
   whose Docker networks no longer exist.

`apply-host` does not regenerate host configuration, fix restored permissions,
restart services, or reconcile mismatched SSH keys. Host-local state is outside
Git and must be restored deliberately.
