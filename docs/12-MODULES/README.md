# KTX Module Authoring

KTX modules are separate GitHub repositories that build and document one hosted workload/runtime.

Examples:

```text
Kansatech/ktx-webphp85
Kansatech/ktx-percona84
Kansatech/ktx-vaultwarden
```

A module is **not** committed into `Kansatech/ktx`.

On build, its repository is normally cloned under:

```text
/srv/ktx/images/ktx-<module>
```

Start with:

1. [Module model](01-module-model.md)
2. [Repository layout](02-repository-layout.md)
3. [Host Core contract](03-host-contract.md)
4. [Module metadata](04-module-metadata.md)
5. [Lifecycle](05-module-lifecycle.md)
6. [Instance generation](06-instance-layout.md)
7. [Versioning and releases](07-versioning.md)
8. [Create a new module repository](08-create-repository.md)

A reusable skeleton exists at `/srv/ktx/module-template`.
