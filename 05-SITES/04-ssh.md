# Site SSH/SFTP

> **Purpose:** Give customers shell/file access without host access.

External:
```bash
ssh example@ssh.yourdomain.example
```

Internal upstream is standard account `site@ktx-web-example-01:2222`.

`site` has no sudo, no Docker access, no other site mounts, no infrastructure secrets, and only application-level DB credentials.

SFTP uses the same SSH route; no separate SFTP daemon is required.

Administrator root debugging happens through Docker from the host, not by giving customer root inside the site.
