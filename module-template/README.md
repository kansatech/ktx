# KTX Module Template

Copy this skeleton into a **new repository**, not into the `Kansatech/ktx` Git history.

Expected repository naming:

```text
Kansatech/ktx-<module>
```

Examples:

```text
Kansatech/ktx-webphp85
Kansatech/ktx-percona84
```

On a build host, clone the module repository under:

```text
/srv/ktx/images/ktx-<module>
```

The parent `Kansatech/ktx` repository deliberately ignores `/srv/ktx/images`; each child directory is its own Git repository.

See `/srv/ktx/docs/11-MODULES/` for the full contract.

A module repository owns both its Docker image build context (`image/`) and reusable container-instance templates (`container/`). Generated instances live under `/srv/ktx/containers` and are server-local.
