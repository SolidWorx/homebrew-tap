#!/usr/bin/env bash

set -euo pipefail

VER="$1"                     # e.g. 2.3.2
ASSETS=(
  solidinvoice-mac-arm64
  solidinvoice-mac-x86_64
  solidinvoice-linux-aarch64
  solidinvoice-linux-x86_64
)

for f in "${ASSETS[@]}"; do
  url="https://github.com/solidinvoice/solidinvoice/releases/download/${VER}/${f}"
  sha=$(curl -Ls "$url" | sha256sum | awk '{print $1}')   # or sha256sum
  printf "%-40s %s\n" "$f" "$sha"
done
