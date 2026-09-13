# Quick Lookup

## Installation and operations

| Task | Procedure |
|---|---|
| Install a fresh host | [INSTALL.md](INSTALL.md) |
| Check this release candidate | [RC review](RC-REVIEW.md) |
| Daily host checks | [Daily operations](docs/05-OPERATIONS/01-daily.md) |
| Copy/paste host commands | [Command reference](docs/05-OPERATIONS/06-common-commands.md) |
| Allocate a workload network | [Network allocation](docs/02-NETWORKING/02-network-allocation.md) |
| Manage web ingress | [Web routes](docs/03-INGRESS/02-web-route-contract.md) |
| Manage SSH ingress and caller keys | [SSH routes](docs/03-INGRESS/04-ssh-route-contract.md) |
| Update or roll back Host Core | [Release lifecycle](docs/04-LIFECYCLE/01-core-release-lifecycle.md) |
| Patch and reboot | [Patching/reboot](docs/05-OPERATIONS/04-host-patching-reboot.md) |
| Recover a host | [Host rebuild](docs/07-RECOVERY/03-full-host-rebuild.md) |
| Diagnose administrator SSH | [SSH troubleshooting](docs/08-TROUBLESHOOTING/01-host-admin-ssh.md) |

## Explanations and contracts

| Topic | Read |
|---|---|
| Architecture | [System at a glance](docs/00-START/01-system-at-a-glance.md) |
| Decisions and tradeoffs | [Architecture decisions](docs/00-START/05-decisions.md) |
| Source versus local state | [Repository model](docs/00-START/06-repository-model.md) |
| Private networking | [Network model](docs/02-NETWORKING/01-network-model.md) |
| Host versus workload SSH | [SSH model](docs/03-INGRESS/05-admin-vs-workload-ssh.md) |
| Security | [Threat model](docs/06-SECURITY/01-threat-model.md), [hardening](docs/06-SECURITY/02-production-hardening.md) |
| Build/dev/prod | [Environments](docs/09-ENVIRONMENTS/README.md) |
| Ports, paths, accounts, versions | [Reference](docs/10-REFERENCE/README.md) |
| Create a module | [Module authoring](docs/12-MODULES/README.md) |
