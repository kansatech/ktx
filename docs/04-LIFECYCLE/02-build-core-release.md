# Build a Host Core Release

On `build.example.invalid`:

1. work on the intended Git branch;
2. update scripts/defaults/docs;
3. if changing Traefik or SSHPiper, update `host/versions.env` and the matching archive hashes in `host/native-checksums.sha256`;
4. run repository validation;
5. install/test the pinned native release(s);
6. test SSH routing, Traefik routes, Docker networking, rsyslog, firewall behavior, and reboot behavior as appropriate;
7. commit;
8. create an immutable annotated Git tag;
9. push the commit/tag;
10. deploy that exact tag to dev.

Useful validation:

```bash
./bin/validate-repo
```

For a native-version change:

```bash
sudo ./bin/install-native sshpiper
sudo ./bin/install-native traefik
```

The build host proves the version bump. Dev proves the exact Host Core tag in a realistic environment. Prod receives the same tag.

`validate-repo` parses each interpreter separately without creating Python caches. It checks local Markdown links, LF encoding, required files, JSON, and executable bits on Linux. ShellCheck and PyYAML are used when installed; skipped tools are reported. Also run the native validators and acceptance checks in [RC-REVIEW.md](../../RC-REVIEW.md).
