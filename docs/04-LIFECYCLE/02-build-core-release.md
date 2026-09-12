# Build a Host Core Release

On `ktx-build-26`:

1. work on the intended Git branch;
2. update scripts/defaults/docs;
3. if changing Traefik or SSHPiper, update the version in `host/versions.env`;
4. run repository validation;
5. install/test the pinned native release(s);
6. test SSH routing, Traefik routes, Docker networking, rsyslog, firewall behavior, and reboot behavior as appropriate;
7. commit;
8. create an immutable annotated Git tag;
9. push the commit/tag;
10. deploy that exact tag to dev.

Useful validation:

```bash
./bin/ktx-validate-repo
bash -n bin/ktx-*
python3 -m py_compile bin/ktx-net bin/ktx-ssh-route bin/ktx-web-route
```

For a native-version change:

```bash
sudo ./bin/ktx-install-native sshpiper
sudo ./bin/ktx-install-native traefik
```

The build host proves the version bump. Dev proves the exact Host Core tag in a realistic environment. Prod receives the same tag.
