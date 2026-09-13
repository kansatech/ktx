# Git and Repository Model

KTX is installed by cloning `Kansatech/ktx` directly to `/srv/ktx`.

There is no second "source checkout" copied somewhere else. The checked-out Git tag is the installed Host Core source.

## What Kansatech/ktx tracks

Git tracks:

```text
README.md
VERSION
CHANGELOG.md
docs/
bin/
host/
module-template/
```

These are portable Host Core source files.

## What Kansatech/ktx deliberately ignores

Git ignores:

```text
config/
secrets/
images/
containers/
data/
logs/
releases/
recovery/
tmp/
cache/
```

These directories are local to a server or contain separate repositories.

The bootstrap phase in [INSTALL.md](../../INSTALL.md) creates the ignored tree.
`init-layout` is also available for recovery; it preserves existing permissions.

## Separate module repositories

`images/` is a workspace containing independent Git repositories.

Example on `build.example.invalid`:

```bash
cd /srv/ktx/images
git clone git@github.com:Kansatech/ktx-webphp85.git
git clone git@github.com:Kansatech/ktx-percona84.git
```

Now:

```text
/srv/ktx/.git                         Kansatech/ktx
/srv/ktx/images/ktx-webphp85/.git    Kansatech/ktx-webphp85
/srv/ktx/images/ktx-percona84/.git   Kansatech/ktx-percona84
```

The parent repository ignores `images/`, so it does not attempt to commit the child repositories.

## Containers are instances, not source

A module repository carries tracked, secret-free **container templates**.

When instantiated on a particular server, the generated instance belongs under:

```text
/srv/ktx/containers/<instance>/
```

That directory is ignored by Host Core because it is server-specific.

Example:

```text
module source:
  /srv/ktx/images/ktx-webphp85/container/...

prod instance:
  /srv/ktx/containers/ktx-web-clienta-01/...
```

## Configuration vs secrets

`config/` contains server-specific configuration, including the SSHPiper route mapping private keys. Treat its backup as confidential, just like `secrets/`.

`secrets/` contains private keys, passwords, tokens, and other confidential material.

Both must be backed up by the server's recovery process even though Git ignores them.


## Critical warning: `git clean`

Do not run:

```bash
git clean -fdx
```

inside `/srv/ktx`.

The `-x` option tells Git to delete ignored files. KTX deliberately uses ignored directories for server config, secrets, child module repositories, container instances, and persistent data.

Also avoid aggressive nested-repository cleanup such as `git clean -ffdx`.

If you need to discard tracked Host Core changes, inspect `git status` and reset only the tracked files you actually intend to replace.

## Production Git rule

Do not run `git pull` on production's `main` branch and hope for the best.

Hosts deploy **tags**:

```bash
git -C /srv/ktx fetch --tags
git -C /srv/ktx checkout --detach v2026.09.11-rc.1
sudo /srv/ktx/bin/apply-host
```

The exact tag is first tested on build, then dev, then prod.

The checkout is writable by the sudo-capable `ktx` administrator and is part of the host trust boundary. Never grant workload/service accounts write access to its source or top-level directory. `/etc` units are installed copies; review and run `/srv/ktx/bin/apply-host` after changing tracked units. That command does not reset runtime ownership or restart services.
