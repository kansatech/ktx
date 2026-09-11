#!/usr/bin/env bash
set -euo pipefail
repo_file=/run/ktx-secrets/repository
pass_file=/run/ktx-secrets/restic-password
[[ -r "$repo_file" ]] || { echo "Missing $repo_file" >&2; exit 1; }
[[ -r "$pass_file" ]] || { echo "Missing $pass_file" >&2; exit 1; }
exec restic -r "$(cat "$repo_file")" --password-file "$pass_file" "$@"
