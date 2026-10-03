#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")"

EXCLUDE=(assets .git)

if ! command -v stow &>/dev/null; then
  echo "error: GNU Stow is not installed" >&2
  exit 1
fi

for dir in */; do
  module="${dir%/}"

  for ex in "${EXCLUDE[@]}"; do
    [[ "$module" == "$ex" ]] && continue 2
  done

  echo "==> stow $module"
  stow -v "$module"
done
