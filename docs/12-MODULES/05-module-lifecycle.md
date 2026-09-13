# Module Build -> Dev -> Prod Lifecycle

Each module has its own release history independent of Host Core.

## Build

On `build.example.invalid`:

```bash
cd /srv/ktx/images/ktx-MODULE
git fetch --tags
git checkout <source/release>
./bin/build
./bin/validate
```

The build produces an immutable Docker image tag and, where used, an exported artifact under `/srv/ktx/releases`.

## Dev

Dev receives:

- the **exact module Git release/tag** for docs/templates;
- the **exact Docker image artifact** produced on build.

Do not rebuild a supposedly identical production candidate on dev.

Instantiate representative containers under `/srv/ktx/containers`.

Test application-specific and Host Core integration behavior.

## Prod

Prod receives the same approved module release and same image bytes.

Only the targeted instances are recreated.

## Independent versions

Example:

```text
Host Core              v2026.09.11-rc.1
ktx-webphp85           v2026.09.4
ktx-percona84          v2026.08.2
```

Updating PHP does not create a Host Core release unless the Host Core contract itself changes.
