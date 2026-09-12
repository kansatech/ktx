# Build a Host Core Release

This work happens on `ktx-build-26`, inside the `Kansatech/ktx` checkout at `/srv/ktx`.

## 1. Start clean

```bash
cd /srv/ktx
git status
git pull --ff-only
```

Do not tag a release with uncommitted Host Core changes.

Server-local ignored files do not belong in the tag.

## 2. Validate tracked source

At minimum:

```bash
python3 -m py_compile bin/ktx-net bin/ktx-web-route bin/ktx-ssh-route
bash -n bin/ktx-host-check bin/ktx-init-layout bin/ktx-apply-host bin/ktx-repo-status
```

Validate systemd/native configurations and perform the build-host functional tests documented elsewhere.

## 3. Build/obtain pinned native binaries

Build SSHPiper from its pinned source tag and obtain the pinned Traefik release exactly as documented in their lifecycle/bootstrap documents.

Store release artifacts outside Git:

```text
/srv/ktx/releases/2026.09.11-r2/
├── artifacts/
│   ├── traefik
│   ├── sshpiperd
│   └── workingdir
├── versions.txt
└── SHA256SUMS
```

These files are ignored by the Host Core Git repository.

## 4. Test Host Core on build

Test:

- helper syntax/functionality;
- test Docker network allocation/removal;
- Traefik config on non-public/test ingress;
- SSHPiper against a disposable SSH backend;
- `ktx-apply-host`;
- `ktx-host-check`.

## 5. Commit and tag

Update `VERSION` and `CHANGELOG.md`, then:

```bash
git add .
git commit
git tag -a v2026.09.11-r2 -m "KTX Host Core 2026.09.11-r2"
git push origin main
git push origin v2026.09.11-r2
```

Use your normal branch/review policy if it differs; the important property is that the promoted tag is immutable.

## 6. Promote

Copy the exact release-artifact directory to dev. Dev checks out the exact Git tag and uses the exact binary artifacts.

Only after dev acceptance do the same on prod.
