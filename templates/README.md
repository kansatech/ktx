# KTX Templates

These are reference implementation files used by the playbook. They are deliberately split by subsystem.

## Images

- `images/base`
- `images/web-php85`
- `images/proxy`
- `images/dockerapi`
- `images/sshpiper`
- `images/percona84`
- `images/mail`
- `images/log`
- `images/backup`
- `images/uptime-kuma`
- `images/rustdesk`

Vaultwarden is built from its pinned upstream source/Docker build recipe rather than a duplicated KTX Dockerfile; see `14-BUILD-DEPLOY/11-vaultwarden.md`.

## Container definitions

`containers/` contains one Compose example per infrastructure/application service. Site containers use `site/compose.yml.example`.

## Rule

Examples contain `REPLACE_*` values. A template is not production configuration until those values have been deliberately reviewed and replaced.
