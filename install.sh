#!/usr/bin/env bash
#
# Installation / update script for backcatalog

set -e

GH_REPO=https://raw.githubusercontent.com/bhavanki/backcatalog/master

install() {
  if [[ ! -x promote ]]; then
    echo "Downloading promote ..."
    curl -O "${GH_REPO}/promote"
    chmod +x promote
  fi
  if [[ ! -x demote ]]; then
    echo "Downloading demote ..."
    curl -O "${GH_REPO}/demote"
    chmod +x demote
  fi
  if [[ ! -x setup_backcatalog.sh ]]; then
    echo "Downloading setup_backcatalog.sh ..."
    curl -o setup_backcatalog.sh "${GH_REPO}/setup.sh"
    chmod +x setup_backcatalog.sh
  fi

  echo "Installation complete!"
  echo "Run setup_backcatalog.sh to set up backcatalog"
}

install
