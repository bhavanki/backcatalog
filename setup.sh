#!/usr/bin/env bash
#
# ROM setup script for backcatalog

set -e

CONFIG_FILE=$HOME/.config/backcatalog.sh

get_dir() {
  local prompt=$1
  local destvar=$2
  local default_dir=$3
  local check_exists=$4
  local path

  echo "Enter the path to your ${prompt}"
  echo "[Default: $default_dir]"
  read -r -p "> " path
  if [[ -z $path ]]; then
    path=$default_dir
  fi

  if [[ -n $check_exists && ! -d $path ]]; then
    echo "Directory $path does not exist"
    exit 1
  fi

  IFS= read -r "${destvar?}" <<<"$path"
}

setup() {
  echo "This script configures backcatalog and moves ROMs. No ROMs are deleted."

  get_dir "RetroPie home directory" RPDIR "$HOME/RetroPie" 1
  get_dir "ROM directory" ROMDIR "$RPDIR/roms" 1
  get_dir "top-level backcatalog directory" BCTOPDIR "$RPDIR/backcatalog" ""
  echo

  # Find or create the backcatalog roms directory.
  ROMS_BASENAME=$(basename "$ROMDIR")
  BCDIR=$BCTOPDIR/$ROMS_BASENAME
  if [[ -d $BCDIR ]]; then
    echo "Found existing backcatalog roms directory:"
    echo "$BCDIR"
  else
    echo "Creating backcatalog roms directory $BCDIR"
    mkdir -p "$BCDIR"
    MOVE_ROMS=1
  fi

  # Write a new configuration file.
  echo "Updating configuration in $CONFIG_FILE"
  cat > "$CONFIG_FILE" <<EOF
# This is the home directory of RetroPie.
rpdir=$RPDIR
# This is the directory where RetroPie looks for ROMs.
romdir=$ROMDIR
# This is the directory where ROMs are stored in the backcatalog.
bcdir=$BCDIR
EOF

  # Move ROMs if necessary.
  if [[ -n $MOVE_ROMS ]]; then
    echo

    while IFS= read -r -d '' d; do
      echo "Moving ROM system dir $d to backcatalog"
      system=$(basename "$d")
      mv "$d" "$BCDIR/$system"
    done < <(find "$ROMDIR" -type d -mindepth 1 -maxdepth 1 -print0)

    echo
    echo "ROMs now live under $BCDIR"
    echo "Use 'promote' to make them available to RetroPie"
  else
    echo "Leaving ROMs in place"
  fi

  echo "Setup complete!"
}

setup
