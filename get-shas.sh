#!/usr/bin/env bash

set -euo pipefail

VER="$1" # e.g. 2.3.2
ASSETS=(
  solidinvoice-mac-arm64
  solidinvoice-mac-amd64
  solidinvoice-linux-amd64
  solidinvoice-linux-arm64
)

for f in "${ASSETS[@]}"
do
  url="https://github.com/solidinvoice/solidinvoice/releases/download/${VER}/${f}"
  if ! sha=$(curl -LsSf "${url}" | sha256sum | awk '{print $1}')
  then
    echo "Skipping ${f}: failed to download ${url}" >&2
    continue
  fi
  printf "%-40s %s\n" "${f}" "${sha}"
done
