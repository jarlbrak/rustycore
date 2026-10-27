#!/usr/bin/env bash
# Install the project-pinned compiler for the actual Linux runner architecture.
set -euo pipefail
root=$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)
version=$(tr -d '[:space:]' < "$root/.protoc-version")
architecture=$(uname -m)
case "$version:$architecture" in
  28.3:x86_64) archive_arch=x86_64; digest=0ad949f04a6a174da83cdcbdb36dee0a4925272a5b6d83f79a6bf9852076d53f ;;
  28.3:aarch64|28.3:arm64) archive_arch=aarch_64; digest=1de522032a8b194002fe35cab86d747848238b5e4de4f99648372079f5b46f9a ;;
  *) echo "No pinned protoc checksum for $version on $architecture" >&2; exit 1 ;;
esac
work=$(mktemp -d)
trap 'rm -rf "$work"' EXIT
destination=${1:-"$HOME/.local"}
curl --fail --show-error --location --retry 3 --retry-all-errors \
  -o "$work/protoc.zip" \
  "https://github.com/protocolbuffers/protobuf/releases/download/v${version}/protoc-${version}-linux-${archive_arch}.zip"
printf '%s  %s\n' "$digest" "$work/protoc.zip" | sha256sum --check --strict
python3 -m zipfile -e "$work/protoc.zip" "$destination"
chmod +x "$destination/bin/protoc"
test "$("$destination/bin/protoc" --version)" = "libprotoc $version"
if [ -n "${GITHUB_PATH:-}" ]; then printf '%s\n' "$destination/bin" >> "$GITHUB_PATH"; fi
