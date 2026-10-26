#!/bin/sh

set -eu

VER="$1" # e.g. 3.2.0
DIR="$(dirname "$0")"
FORMULA="${DIR}/Formula/solidinvoice.rb"
SHAS="$(mktemp)"
OUT="$(mktemp)"
trap 'rm -f "${SHAS}" "${OUT}"' EXIT

"${DIR}/get-shas.sh" "${VER}" >"${SHAS}"

# Point each url at the new version, set the sha256 below it from get-shas.sh,
# and drop the bottle block (brew pr-pull adds a fresh one for the new version).
awk -v ver="${VER}" '
  FILENAME == ARGV[1] { sha[$1] = $2; next }
  /^  bottle do$/ { skip = 1 }
  skip { if ($0 == "  end") { skip = 0; drop_blank = 1 }; next }
  drop_blank && $0 == "" { drop_blank = 0; next }
  { drop_blank = 0 }
  /^ *url / {
    sub(/download\/[^\/]+\//, "download/" ver "/")
    asset = $0; sub(/.*\//, "", asset); sub(/[^a-z0-9-].*/, "", asset)
    pending = sha[asset]; if (pending == "") { print "No SHA for " asset > "/dev/stderr"; exit 1 }
  }
  /^ *sha256 / && pending != "" { sub(/"[0-9a-f]+"/, "\"" pending "\""); pending = "" }
  { print }
' "${SHAS}" "${FORMULA}" >"${OUT}"

cp "${OUT}" "${FORMULA}"
echo "Bumped ${FORMULA} to ${VER}"
