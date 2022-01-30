#!/usr/bin/env bash
#
# Installation / update script for backcatalog

set -e

GH_REPO=https://github.com/bhavanki/backcatalog

install() {
  if [[ ! -x promote ]]; then
    echo "Downloading promote ..."
    curl -O "${GH_REPO}/promote"
  fi
  if [[ ! -x demote ]]; then
    echo "Downloading demote ..."
    curl -O "${GH_REPO}/demote"
  fi

  echo "Installation complete!"
  echo "Run setup.sh to set up backcatalog"
}

install
