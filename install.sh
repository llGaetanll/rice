#!/bin/sh

# This script makes config file installation easier.
#
# If you only want, say, nvim, alacritty, tmux, and lf, you can run
#
#     ./install.sh nvim alacritty tmux lf
#
# Each of these programs will then be symlinked to your `$HOME/.config/`
# directory.

# get the directory the script is in (this is the source directory)
SRC=$(cd $(dirname "$0") && pwd)
cd - > /dev/null

DST="$HOME"

for prog in "$@"; do
  ln -s "$SRC/.config/$prog" "$DST/.config/$prog"
done
