#!/usr/bin/env sh

# This script loads the polybar defined by the $POLYBAR
# environment variable. This variable can be modified in
# your xinitrc

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# reload polybar on every monitor
# see: https://github.com/polybar/polybar/issues/763#issuecomment-392960721
for m in $(polybar --list-monitors | cut -d":" -f1); do
    # $POLYBAR is the path to the polybar file to be loaded
    MONITOR=$m polybar -c $POLYBAR bar &
done

