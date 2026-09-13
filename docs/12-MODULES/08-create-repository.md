# Create a Module Repository

Use a new, unused module name. `ktx-example` below is deliberately illustrative;
replace it with the module you intend to create. Run Git commands as the `ktx`
administrator on the build host, without sudo.

## Start directly in the module workspace

```bash
mkdir /srv/ktx/images/ktx-example
cp -a /srv/ktx/module-template/. /srv/ktx/images/ktx-example/
cd /srv/ktx/images/ktx-example
git init -b main
```

The parent Host Core repository ignores `images/`, so this is an independent
repository from the start. No temporary checkout or second clone is needed.

Replace the placeholder module name/repository/image in `MODULE.yml` and
`README.md`. Keep the version consistent across `MODULE.yml`, `VERSION`, and
`CHANGELOG.md`. The skeleton is documentation, not a deployable module: implement
its image, container template, commands, and lifecycle before marking it ready.

## Build the two reusable pieces

```text
image/       Docker image build context
container/   secret-free instance templates
bin/         module-specific build, validate, and instance commands
```

Generated instances belong under `/srv/ktx/containers/<instance>`. Persistent
state and secrets use the host paths in the [module contract](03-host-contract.md).
Never commit customer configuration, keys, credentials, or data to module source.

## Publish the independent source when ready

Review the files, create the intended empty repository on GitHub, then commit
and publish from this checkout. Replace the illustrative remote below:

```bash
git status --short
git add .
git commit -m "Initial KTX module"
git remote add origin git@github.com:Kansatech/ktx-example.git
git push -u origin main
```

Before production, complete the module's build, configuration, dev/prod,
update, backup, restore, monitoring, security, troubleshooting, and removal docs.
Use its own [release lifecycle](05-module-lifecycle.md); workload updates do not
implicitly update Host Core.
