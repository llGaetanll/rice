#!/bin/sh

# This script makes config file installation easier.
#
# Usage:
#     ./install.sh DESTINATION_DIR [program1 program2 ...]
#
# Example:
#     ./install.sh $HOME nvim alacritty tmux lf
#
# Each of these programs will then be symlinked to DESTINATION_DIR/.config/

# Get the directory the script is in (this is the source directory)
SRC=$(cd $(dirname "$0") && pwd)
cd - > /dev/null

# First parameter is the destination directory
DST="$1"
shift

# Create .config directory if it doesn't exist
mkdir -p "$DST/.config"

# Process remaining parameters as program names
for prog in "$@"; do
  ln -s "$SRC/.config/$prog" "$DST/.config/$prog"
done
