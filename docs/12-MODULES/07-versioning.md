# Module Versioning and Releases

Each `Kansatech/ktx-*` module versions independently.

Use immutable Git tags and immutable Docker image tags.

A module release should record:

- Git tag/commit;
- Docker image name/tag;
- image ID/digest;
- upstream software versions;
- build date;
- meaningful configuration changes;
- migration/rollback considerations.

Do not republish different image bytes under the same promoted tag.

GitHub is the source for module build/configuration history. `/srv/ktx/releases` holds promoted runtime artifacts unless/until you standardize GitHub Releases or another artifact store.
