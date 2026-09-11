# Templates

These files are reference starting points for the KTX platform. They intentionally contain `REPLACE_*` placeholders and must be reviewed, pinned, and tested on `ktx-build-26` and `ktx-dev-26` before production use.

The handbook is authoritative about lifecycle and architecture; the templates demonstrate the intended shape. Do not treat an example file as a secret-bearing configuration or as a substitute for version-specific upstream documentation.

Notably, the restricted Docker API proxy is documented but does not include a fake "secure by default" copy/paste configuration. Its allowed API surface must be validated against the pinned Docker Engine and Traefik versions before release.
