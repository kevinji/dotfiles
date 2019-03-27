#!/bin/sh
set -e
DOWNLOAD_URL="https://github.com/getantibody/antibody/releases/download"
test -z "$TMPDIR" && TMPDIR="$(mktemp -d)"

last_version() {
  curl -s https://raw.githubusercontent.com/getantibody/homebrew-tap/master/Formula/antibody.rb |
    grep url |
    cut -f8 -d'/'
}

download() {
  version="$(last_version)" || true
  test -z "$version" && {
    echo "Unable to get antibody version."
    exit 1
  }
  echo "Downloading antibody $version for $(uname -s)_$(uname -m)..."
  rm -f /tmp/antibody.tar.gz
  curl -s -L -o /tmp/antibody.tar.gz \
    "$DOWNLOAD_URL/$version/antibody_$(uname -s)_$(uname -m).tar.gz"
}

extract() {
  tar -xf /tmp/antibody.tar.gz -C "$TMPDIR"
}

download
extract || true
mv -f "$TMPDIR"/antibody ~/bin/antibody
type antibody
