# Naming and Conventions

> **Purpose:** Make names predictable enough to remain useful years later.

## Hosts
`ktx-build-26`, `ktx-dev-26`, `ktx-prod-26`.

## Infrastructure
`ktx-<role>-<instance>` such as `ktx-percona-01`.

Instance numbers mean **instance**, never software version.

## Sites
`ktx-web-<slug>-01`, for example `ktx-web-proofbinder-01`.

Slugs are lowercase ASCII letters/numbers/hyphens and should remain stable if branding changes.

## Networks
- `ktx-control`
- `ktx-management`
- `ktx-site-<slug>`

## Images
Examples:
- `ktx/base:2026.09.10-r1`
- `ktx/web-php85:2026.09.10-r1`
- `ktx/percona84:2026.09.10-r1`

## Database
Default database and user: `<slug>_app`.

## Release numbers
Use `YYYY.MM.DD-rN`. Once exported/promoted, a tag is immutable.
