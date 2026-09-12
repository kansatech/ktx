# `MODULE.yml`

Every module repository should have a small human-readable `MODULE.yml`.

Suggested minimum:

```yaml
schema: 1
name: webphp85
repository: Kansatech/ktx-webphp85
image: ktx/webphp85
version: 1.0.0

network:
  primary_ip: ".2"

ports:
  - name: http
    container: 8080

ingress:
  web: true
  ssh: true

persistent_state:
  - /srv/ktx/data/<instance>

notes: []
```

This is first a contract/documentation file. Do not turn it into a giant DSL before automation genuinely needs one.

Never put secrets in `MODULE.yml`.
