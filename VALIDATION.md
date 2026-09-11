# Validation Notes

This revision received a static validation pass before packaging:

- all Compose/YAML example files parsed successfully
- all JSON files parsed successfully
- all shell/example shell files passed `bash -n`
- all relative Markdown links resolve to existing files
- no empty files remain
- the restricted Docker-API nginx configuration passed `nginx -t` after substituting the runtime socket group placeholder
- raw, unlabeled `docker network create ktx-site-*` instructions were removed in favor of the label-aware helper

Runtime validation still belongs on `ktx-build-26` and `ktx-dev-26`: build the images, start the services, and exercise the exact release artifacts before production promotion. Static validation is not a substitute for that lifecycle.
