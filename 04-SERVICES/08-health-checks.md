# Health Checks

> **Purpose:** Make checks meaningful and non-cascading.

Site `/__ktx/health` should be a static/local Apache check that does not require Percona or an external API.

A site can therefore be “runtime healthy” while the application separately reports dependency failure. That distinction is useful.

Backup health is “last successful backup is recent enough,” not “backup container process exists.”

Public monitoring should use the actual domain/HTTPS path to exercise the whole request chain.
