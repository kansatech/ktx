# Update SSHPiper

1. Review the desired SSHPiper release.
2. Change `SSHPIPER_VERSION` in `host/versions.env` and its official archive hashes in `host/native-checksums.sha256` on build.
3. Install it with:

   ```bash
   sudo ./bin/install-native sshpiper
   ```

4. Test the reserved `ktx` host route plus representative workload routes, public-key authentication, mapping keys, strict host-key checking, and SFTP/SCP where used.
5. Promote the exact Host Core Git tag to dev, then prod.
6. On each target, install the pinned release and restart only `sshpiper.service`.
7. Immediately prove `ssh ktx@host` from a second terminal after a production restart.

Keep provider console access available during any SSHPiper update because it is in the host administration path.

Source: https://github.com/tg123/sshpiper
