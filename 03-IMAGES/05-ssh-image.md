# SSHPiper Image

> **Purpose:** Provide username-based SSH routing through one edge port.

Use SSHPiper's working-directory plugin.

Structure:
```text
/var/sshpiper/clienta/
  sshpiper_upstream
  authorized_keys
  upstream private key
  known_hosts
```

Example upstream:
```text
site@ktx-web-clienta-01:2222
```

Customer:
```bash
ssh clienta@ssh.example.net
```

Enable strict upstream host-key checking. Persist each site's SSH host keys so recreating the web container does not silently change identity.

Password auth should be disabled unless a documented exception exists.
