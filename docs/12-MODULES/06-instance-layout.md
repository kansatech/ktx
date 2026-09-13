# Module Instance Layout

A module repository is reusable source. An instance is one deployment of it on a particular host.

Recommended:

```text
/srv/ktx/containers/<instance>/
├── compose.yml
├── manifest.yml
└── config/                 non-secret instance config when appropriate

/srv/ktx/data/<instance>/   persistent runtime state
/srv/ktx/secrets/<instance>/ private instance secrets
/srv/ktx/logs/<instance>/   host-visible logs if used
```

The module's `bin/instantiate` command may create these paths.

## Instance manifest

Record at least:

```yaml
instance: ktx-example-01
module: ktx-example
module_release: v1.2.3
image: ktx/example:1.2.3
network: ktx-net-ktx-example-01
primary_ip: 172.28.0.2
environment: prod
```

Do not include passwords.

`containers/` is ignored by the Host Core repository because instance details differ on build/dev/prod.
